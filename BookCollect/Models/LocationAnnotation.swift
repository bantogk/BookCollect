//
//  LocationAnnotation.swift
//  BookCollect
//
//  Created by Eli Munoz on 2023-11-27.
//

import Foundation
import MapKit
import UIKit

final class LocationAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(location: Location) {
        self.title = location.name
        self.coordinate = location.coordinate
    }
}
