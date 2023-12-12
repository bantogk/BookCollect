// Group 10
// Melissa Munoz / Eli - 991642239


import Foundation
import MapKit
import UIKit

final class LocationAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let pinColor : UIColor

    init(location: Location, title: String, subtitle: String, pinColor: UIColor) {
        self.subtitle = location.title
        self.title = location.name
        self.coordinate = location.coordinate
        self.pinColor = pinColor
    }
}
