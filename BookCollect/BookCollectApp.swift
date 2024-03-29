// Group 10
//
// Melissa Munoz - 991642239
// Christian Mackenzie - 991612602
// Kyelle Bantog - 991645909

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct BookCollectApp: App {
    
    let fireDBHelper : FireDBHelper
    
    init() {
        self.locations = []
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper.getInstance()
    }
    
    let locationHelper = LocationHelper()
    let bookManager = BookManager()
    let locations: [Location]

    
    var body: some Scene {
        WindowGroup {
              ContentView(locations: locations)
                .environmentObject(self.locationHelper)
                .environmentObject(self.bookManager).environmentObject(fireDBHelper)
//            AddBookView().environmentObject(fireDBHelper)
        }
    }
}
