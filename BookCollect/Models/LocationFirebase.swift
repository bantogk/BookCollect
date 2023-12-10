import Foundation
import FirebaseFirestoreSwift
import CoreLocation

struct LocationFirebase: Codable, Hashable {
    
    @DocumentID var id: String?
    
    var name: String
    var title: String
    var latitude: Double
    var longitude: Double
    
    init(id: String? = nil, name: String, title: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // Initialize from a dictionary
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
              let title = dictionary["title"] as? String,
              let latitude = dictionary["latitude"] as? Double,
              let longitude = dictionary["longitude"] as? Double else {
            return nil
        }
        
        self.init(id: nil, name: name, title: title, latitude: latitude, longitude: longitude)
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
