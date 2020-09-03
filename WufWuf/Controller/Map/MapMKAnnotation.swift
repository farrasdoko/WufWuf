//
//  MapMKAnnotation.swift
//  WufWuf
//
//  Created by michael tamsil on 31/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import Foundation
import MapKit

class MapMKAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var id: Int?
    var phoneNumber: String?
    var timeOpen: String?
    var title: String?
    var address: String = ""
    
    init(coordinate: CLLocationCoordinate2D, id: Int, title: String, phoneNumber: String, timeOpen: String, address: String){
        self.coordinate = coordinate
        self.id = id
        self.phoneNumber = phoneNumber
        self.timeOpen = timeOpen
        self.title = title
        self.address = address
    }
}
