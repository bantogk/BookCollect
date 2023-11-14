//
//  ContentView.swift
//  BookCollect
//
//  Created by Kyelle on 2023-11-13.
//

import SwiftUI

enum Screen {
    case map, scan, list
}//tabEnum

final class TabRouter: ObservableObject{
    
    @Published var screen: Screen = .map
    
    func change(to screen: Screen){
        self.screen = screen
    }
}//tabRouter

struct ContentView: View {
    
    @StateObject var router = TabRouter()
    
    
    var body: some View {
        
        NavigationStack{
            TabView(selection: $router.screen){
                
                ScanView()
                    .tag(Screen.map)
                    .environmentObject(router)
                    .tabItem{
                        Label("Scan", systemImage:"barcode.viewfinder")
                    }//scanTab
                
                MapView()
                    .tag(Screen.scan)
                    .environmentObject(router)
                    .tabItem {
                        Label("Map", systemImage:"map.circle.fill")
                        
                    }//mapTab
                
                ListView()
                    .tag(Screen.list)
                    .environmentObject(router)
                    .tabItem {
                        Label("List", systemImage: "list.bullet.circle.fill")
                        
                    }//listTab
                
            }//TabView
            .navigationTitle("BookCollect")
            .navigationBarTitleDisplayMode(.inline)
        }//NavStack
    }//Body
}//View

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
