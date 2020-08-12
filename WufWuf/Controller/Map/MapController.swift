//
//  MapController.swift
//  WufWuf
//
//  Created by Farras Doko on 12/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController {
    
    @IBOutlet weak var clinicMap: MKMapView!
    let annotationID = "clinic"
    
    var locationManager: CLLocationManager?
    let warasatwa = CLLocation(latitude: 1.132544, longitude: 104.044093)
    var request: MKDirections.Request?
    
    private enum alertID: String {
        case hubungi = "Hubungi", arah = "Petunjuk Arah"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard CLLocationManager.authorizationStatus() != .denied else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            clinicMap.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
        
        addBarButton()
        addWarasatwa()
        createDirection()
    }
    
    private func addWarasatwa() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = warasatwa.coordinate
        annotation.title = "Klinik Hewan Warasatwa"
        clinicMap.addAnnotation(annotation)
    }
    
    // show the compass in the navigation bar
    func addBarButton() {
        let compass = MKCompassButton(mapView: clinicMap)
        compass.compassVisibility = .adaptive
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
        clinicMap.showsCompass = false
        
        navigationItem.leftBarButtonItem = navigationItem.backBarButtonItem
    }
    
    // create in mapKit direction
    func createDirection() {
        request = MKDirections.Request()
        request?.source = MKMapItem(placemark: MKPlacemark(coordinate: clinicMap.userLocation.coordinate, addressDictionary: nil))
        
        request?.destination = MKMapItem(placemark: MKPlacemark(coordinate: warasatwa.coordinate, addressDictionary: nil))
        
        request?.requestsAlternateRoutes = true
        request?.transportType = .automobile
        
        let directions = MKDirections(request: request!)
        directions.calculate { (response, error) in
            guard let unwrappedResponse = response else { return }
            for route in unwrappedResponse.routes {
                self.clinicMap.addOverlay(route.polyline)
                self.clinicMap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                self.locationManager?.stopUpdatingLocation()
                self.clinicMap.showsUserLocation = false
                
            }
        }
        
        clinicMap.showAnnotations(clinicMap.annotations, animated: true)
        clinicMap.layoutMargins = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
    }
    
    @objc func annotationTapped() {
        func alertHandler(action: UIAlertAction) {
            switch action.title {
            case alertID.hubungi.rawValue:
                guard let number = URL(string: "tel://+6282172278307") else { return }
                UIApplication.shared.open(number)
            case alertID.arah.rawValue:
                guard let source = request?.source, let destination = request?.destination else {
                    break
                }
                source.name = "Lokasi Anda"
                destination.name = "Klinik Hewan Waras Satwa"
                MKMapItem.openMaps(with: [source,destination], launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
                break
            default:
                break
            }
        }
        
        let alert = UIAlertController(title: "Klinik Hewan Waras Satwa", message: "Komplek ruko Graha Kadin, Blk. F No.6, Tlk. Tering, Kec. Batam Kota, Kota Batam, Kepulauan Riau 29432.", preferredStyle: .alert)
        let hubungi = UIAlertAction(title: "Hubungi", style: .default, handler: alertHandler)
        let arah = UIAlertAction(title: "Petunjuk Arah", style: .default, handler: alertHandler)
        let cancel = UIAlertAction(title: "Kembali", style: .cancel, handler: nil)
        for action in [hubungi, arah, cancel] {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension MapController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            self.clinicMap.showsUserLocation = true
            createDirection()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = .cyan
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(annotationTapped), for: .touchUpInside)

        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
        annotationView.isEnabled = true
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = button
        return annotationView
    }
    
}
