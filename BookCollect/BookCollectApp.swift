//
//  BookCollectApp.swift
//  BookCollect
//
//  Created by Kyelle on 2023-11-13.
//

import SwiftUI

@main
struct BookCollectApp: App {
    
    init() {
        self.locations = []
    }
    
    let locationHelper = LocationHelper()
    let locations: [Location]

    
    var body: some Scene {
        WindowGroup {
            ContentView(locations: locations)
                .environmentObject(self.locationHelper)
        }
    }
}
