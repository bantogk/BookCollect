// Melissa Munoz / Eli - 991642239
//references: https://youtu.be/WTzBKOe7MmU?si=OMozbW-os4O_EgzH

import SwiftUI
import MapKit

struct MapView: View {
    
    //for tabview
    @EnvironmentObject var router : TabRouter
    @EnvironmentObject var locationHelper : LocationHelper
    
    @State private var search: String = ""
    
    @State private var locations: [Location] = [Location]()
    
    @State private var isSheetPresented: Bool = false
    
    
    var body: some View {
        ZStack{
            VStack{
                
                ZStack(alignment: .top) {
                    
                    BookMap(locations: locations).environmentObject(self.locationHelper)
                        .sheet(isPresented: $isSheetPresented) {
                            SheetView(locations: self.locations)
                        }//sheet
                    
                    TextField("Search For Nearby Locations", text: $search, onEditingChanged: { _ in })
                    {
                        // commit
                        self.getNearByLocations(search:self.search)
                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .offset(y: 44)
                    
                }
            }//VStack
            .onAppear(){
                self.getNearByLocations(search:"Book")
                
            }
        }//ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .clipped()
    }//body

    
    private func getNearByLocations(search : String) {
        
        //MkLocalSearch vs Geocoding
        //Geocoding recommendations based off coordinations, but userQuery, Mklocalsearch is more common to use
        //A utility object for initiating map-based searches and processing the results.
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
                if let response = response {
                    
                    //get the locations
                    let mapItems = response.mapItems
                    
                    //now we can create an array of locations
                    self.locations = mapItems.map {
                        Location(placemark: $0.placemark)
                    }//self.locations
                    
                    //ensure to present Sheet
                    self.isSheetPresented = true
                    
                    
                }//if/else
            
        }//search.start
        
    }//getNearBy
    
    
  
}//Struct

//#Preview {
//    MapView().environmentObject(TabRouter())
//}
