// Melissa Munoz / Eli - 991642239


import Foundation
import MapKit
import FirebaseFirestoreSwift
import CoreLocation

struct LocationFirebase: Codable, Hashable {
    
    @DocumentID var id: String?
    var name: String
    var title: String
    var latitude: Double
    var longitude: Double
    
    var date : Date
    
    
    init(id: String?, name: String, title: String, latitude: Double, longitude: Double, date: Date) {
        self.id = id ?? UUID().uuidString
        self.name = name
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
    }
    
    // Initialize from a dictionary
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
              let title = dictionary["title"] as? String,
              let latitude = dictionary["latitude"] as? Double,
              let date = dictionary["date"] as? Date,
              let longitude = dictionary["longitude"] as? Double else {
            return nil
        }
        
        self.init(id: nil, name: name, title: title, latitude: latitude, longitude: longitude, date: date)
    }
    
    func convertToLocation() -> Location {
        // Create an MKPlacemark using the latitude and longitude
        let coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        return Location(placemark: placemark)
    }
    
    // Convert to a dictionary for Firestore
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "title": title,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
}
