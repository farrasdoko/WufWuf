//
//  MapUIButton.swift
//  WufWuf
//
//  Created by michael tamsil on 02/09/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit
import MapKit

class MapUIButton: UIButton {
    var annotation: MKAnnotation?
    
    convenience init(type: ButtonType, annotation: MKAnnotation){
        self.init(type: type)
        self.annotation = annotation;
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
