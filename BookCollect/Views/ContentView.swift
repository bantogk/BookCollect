

import SwiftUI

enum Screen {
    case rec, scan, list
}//tabEnum

final class TabRouter: ObservableObject{
    
    @Published var screen: Screen = .scan
    
    func change(to screen: Screen){
        self.screen = screen
    }
}//tabRouter

struct ContentView: View {
    
    @StateObject var router = TabRouter()
    @EnvironmentObject var locationHelper : LocationHelper
    @EnvironmentObject var bookManager : BookManager
    let locations: [Location]

    
    var body: some View {
        
        NavigationStack{
            TabView(selection: $router.screen){
                
                ScanView()
                    .tag(Screen.scan)
                    .environmentObject(router)
                    .tabItem{
                        Label("Scan", systemImage:"barcode.viewfinder")
                    }//scanTab
                
                RecView()
                    .padding()
                    .tag(Screen.rec)
                    .environmentObject(router)
                    .environmentObject(bookManager)
                    .tabItem{
                        Label("Recs", systemImage:"book.circle")
                    }//scanTab
                
//                MapView()
//                    .environmentObject(self.locationHelper)
//                    .tag(Screen.scan)
//                    .environmentObject(router)
//                    .tabItem {
//                        Label("Map", systemImage:"map.circle.fill")
//                        
//                    }//mapTab
                
                ListView()
                    .padding()
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(locations: locations)
//    }
//}
