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
import Contacts

class MapController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var clinicMap: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    var dataClinics : [MapMKAnnotation]?
    var showFirstTimeLocation: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clinicMap.delegate = self
        
        checkLocationServices()
        getData()
        clinicMap.addAnnotations(dataClinics!)
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)

            clinicMap.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization(){
        switch  CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            clinicMap.showsUserLocation = true
            locationManager.startUpdatingLocation()
            centerViewOnUserLocation()
            break;
        case .denied:
            // Show alert instructing them how to turn on permisssions
            break;
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break;
        case .restricted:
            // show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        default:
            print(" problem with Location Manager : \(CLLocationManager.authorizationStatus())")
            break
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //DATA
    func getData(){
        
        let data = [
            [1, "Waras Satwa", "0821-7227-8307", "", 1.132544, 104.044093, "Komp. Ruko Graha Kadin, Blok F No. 6, Batam Center"],
            [2, "Maiyus Musrianti", "0812-662-0648", "24 jam", 1.014892, 104.073823, "Jl. Perum Bukit Barelang, Blok E2 No. 22, Tanjung Piayu"],
            [3, "Drh. Gusra Firdaus & Drh. Hermyn Febrianti", "0821-1516-6763", "11:00-21:30", 1.034677, 103.997918, "Jl. Trans Barelang, Blok Goldston 2 No. 36, Tembesi"],
            [4, "De'Chruse Pet Center", "0813-1074-0498", "09:00-19:00", 1.132823, 104.036016, "Ruko Puri Loka, Blok E No. 3, Sei Panas"],
            [5, "Berastagi Pet Clinic", "0812-2707-4404", "24 jam", 1.154105, 104.002952, "Komp Orchid Center, Blok B No. 9-10, Sei Jodoh"],
            [6, "Bruno Pet Clinic", "0877-7241-0888", "09:00-19:00", 1.133208, 104.015769, "Jl. Teratai 2, No. 4, Lubuk Baja Kota"],
            [7, "OJ Pet Care", "0778-408-4745", "08:00-22:00", 1.112522, 103.974599, "Ruko Tisenia, Blok E No. 6, Tiban"],
            [27, "Bee Vet Clinic", "0823-8457-5250", "09:00-21:00", 1.049187, 103.974423, "Jl. Aviari Griya Pratama, Ruko Arta Mandiri No. 4, Buliang"],

            [8, "Awal Care", "(021)22982483", "09:00-21:00", -6.221260, 106.914353, "Jl. Duren Sawit, Blok J II No. 6, RT.9/RW.11, Klender, Jaktim"],
            [28, "El Care", "0823-1121-1898", "08:00-21:00", -6.231374, 106.928824, "Jl. Taman Malaka Selatan, blok B3 No. 6A-E, RT.3/RW.9 Pd. Kopi, Jaktim"],
            [10, "Klinik Hewan Garden", "0851-0062-8282", "10:00-19:00", -6.220461, 106.921712, "Jl. Buaran Raya, NO. 62, RT.6/RW.13, Klender, Jaktim"],
            [11, "Drh Wiana T. & Drh Porinda H.A", "021-850-1143", "07:00-09:00 16:00-20:00", -6.225419, 106.888577, "Jl. Cipinang Elok, Blok BJ No. 6, RT.6/RW.10, Cipinang Muara, Jaktim"],
            [12, "Drh. Tri Widharetna Msc", "021-850-3294", "", -6.223898, 106.884396, "Jl. Cipinang Jaya I, No. 39, RT.7/RW.3, Cipinang Besar, Jaktim"],
            [13, "Drh. Cholillah K", "021-866-03740", "15:00-16:00", -6.224150, 106.926462, "Jl. Kayu Manis X, No. 23, RT.8/RW.10, Pisangan Baru, Jaktim"],
            [14, "Malaka Pet Clinic", "0857-7956-6119", "09:00-21:00", -6.227349, 106.927524, "Jl. Malaka Raya, No. 112, RT.3/RW.8, Malaka Sari, Jaktim"],
            [15, "Drh Mth Widiastuti", "021-8561-1631", "16:00-21:00", -6.219907, 106.902690, "Jl. Dermaga, No. 26, RT.6/RW.8, Klender, Jaktim"],
            [16, "Room V Petshop & Klinik", "0822-6052-6905", "09:00-21:00", -6.221685, 106.926676, "Jl. Delima Raya, No. 3, RT.8/RW.5, Malaka Sari, Jaktim"],

            [17, "updt klinik hewan", "(031)3520678", "08:00-15:30", -7.230471, 112.726460, "Jl. Ikan Dorang, No. 15, Perak Bar, Krembangan"],
            [18, "K & P Clinic", "0816-509-222", "buka 24 jam", -7.269931, 112.731337, "Jl. Wonorejo III, No. 69i, Wonorejo, Tegalsari"],
            [19, "VERO", "0817-0336-6880", "10:00-16:00", -7.299326, 112.753207, "Jl. Bratang Gede IV A, No. 23, RW 07, Ngagelrejo, Wonokromo"],
            [20, "Surabaya Animal Clinic", "0821-3214-6221", "09:00-21:00", -7.320185, 112.789058, "Jl. Pandugo Timur XIII, Perum YKP Pandugo II, Blok E-6, Penjaringan Sari, Rungkut"],
            [21, "WEKA", "(031)5677577", "09:00-16:00", -7.283686, 112.713663, "Jl. Dukuh Kupang XXV, No. 54, Dukuh Kupang, DukuhPakis"],
            [22, "Intimedipet", "0816-689-846", "09:30-17:00", -7.301504, 112.755665, "Jl. Baratajaya II, No. 52, Brata Jaya, Gubeng"],
            [23, "Puppy", "(031)8720747", "", -7.331830, 112.775130, "Jl. Rungkut Mapan Tengah I, Blok FD/10, Rungkut Tengah, Gn. Anyar"],
            [24, "Carovet", "0813-5725-5739", "09:00-17:00", -7.313240, 112.698161, "Jl. Raya Wiyung, No. 9, Wiyung"],
            [25, "Brigida Quinta Ardani", "0816-5411-971", "09:00-15:00", -7.280416, 112.679384, "Jl. Raya Prada Indah, No. 6, Pradahkalikendal, Dukupakis"],
            [26, "Jeje", "0812-4956-4972", "08:00-16:00", -7.327413, 112.690254, "Jl. Pd. maritim Indah Cluster Boulevard, No. 2, Balas Klumprik, Wiyung"]
        ]
        
        for item in data {
            let locationCoordinate2D = CLLocationCoordinate2D(latitude: item[4] as! CLLocationDegrees, longitude: item[5] as! CLLocationDegrees )

            let newDataClinic = MapMKAnnotation(
                coordinate: locationCoordinate2D,
                id: item[0] as! Int,
                title: item[1] as! String,
                phoneNumber: item[2] as! String,
                timeOpen: item[3] as! String,
                address: item[6] as! String)

            if self.dataClinics != nil {
                self.dataClinics!.append(newDataClinic)
            } else {
                self.dataClinics = [newDataClinic]
            }
        }
    }
}


extension MapController: CLLocationManagerDelegate {

    // it will update the map making current location will be in the middle
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        if showFirstTimeLocation {
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//            clinicMap.setRegion(region, animated: true)
//            showFirstTimeLocation = false
//            self.locationManager.stopUpdatingLocation()
//        }
//    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationServices()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let button = MapUIButton(type: .detailDisclosure, annotation: annotation)
        
        button.addTarget(self, action: #selector(self.onTapped(_:event:)), for: .touchUpInside)
        
        if (annotation is MKUserLocation) {
            return nil
        }else {
            let titikLokasiKlinikView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "clinic")
            titikLokasiKlinikView.canShowCallout = true
            titikLokasiKlinikView.animatesDrop = true
            titikLokasiKlinikView.isEnabled = true
            titikLokasiKlinikView.rightCalloutAccessoryView = button
            return titikLokasiKlinikView
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
    }
    
    @objc func onTapped(_ sender: MapUIButton, event: UIEvent){
        let annotation = sender.annotation
        let title = annotation?.title
        
        enum ALERTID: String {
            case CONTACT = "Hubungi"
            case DIRECTION = "Petunjuk Arah"
            case CANCEL = "Kembali"
        }
        
        if let dataClinic = self.dataClinics?.first(
            where: {
                $0.title == title &&
                $0.coordinate.latitude == annotation?.coordinate.latitude &&
                $0.coordinate.longitude == annotation?.coordinate.longitude
        }){
            
            func alertHandler(action: UIAlertAction) {

                switch action.title {
                    case ALERTID.CONTACT.rawValue:
                        guard let number = URL(string: "tel://\(dataClinic.phoneNumber!)") else { return }
                        UIApplication.shared.open(number)
                        break
                    case ALERTID.DIRECTION.rawValue:

                        if let location = locationManager.location?.coordinate {
                            let sourceCoordinate = CLLocationCoordinate2D( latitude: location.latitude, longitude: location.longitude)
                            let sourceAddress = [CNPostalAddressStreetKey: "Posisi Saya"]
                            let sourceMKPlacemark = MKPlacemark(coordinate: sourceCoordinate, addressDictionary: sourceAddress )
                            let source = MKMapItem(placemark: sourceMKPlacemark)
                            
                            print(dataClinic.title!)
                            let destination = MKMapItem(placemark: MKPlacemark(coordinate: dataClinic.coordinate, addressDictionary: [CNPostalAddressStateKey: dataClinic.title!] ) )
                                
                            MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])

                        }
                        break;
                    default:
                        break
                }
            }
            
            let alert = UIAlertController(title: dataClinic.title, message: dataClinic.address, preferredStyle: .alert)
            let contact = UIAlertAction(title: ALERTID.CONTACT.rawValue, style: .default, handler: alertHandler(action:))
            let direction = UIAlertAction(title: ALERTID.DIRECTION.rawValue, style: .default, handler: alertHandler(action:))
            let cancel = UIAlertAction(title: ALERTID.CANCEL.rawValue, style: .cancel, handler: nil)
            
            for action in [contact, direction, cancel] {
                alert.addAction(action)
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
}
