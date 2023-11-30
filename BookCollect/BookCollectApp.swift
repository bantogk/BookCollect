

import SwiftUI

@main
struct BookCollectApp: App {
    
    init() {
        self.locations = []
    }
    
    let locationHelper = LocationHelper()
    let bookManager = BookManager()
    let locations: [Location]

    
    var body: some Scene {
        WindowGroup {
            ContentView(locations: locations)
                .environmentObject(self.locationHelper)
                .environmentObject(self.bookManager)
        }
    }
}
