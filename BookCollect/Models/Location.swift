// Group 10
// Melissa Munoz / Eli - 991642239


import Foundation

import MapKit

struct Location: Identifiable, Hashable {
    
    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
    
    var date: Date{
        return Date()
    }
    
    func convertToLocationFirebase() -> LocationFirebase {
            let locationFirebase = LocationFirebase(
                id: nil,
                name: self.name,
                title: self.title,
                latitude: self.coordinate.latitude,
                longitude: self.coordinate.longitude,
                date: self.date
            )
            return locationFirebase
        }
    
}
