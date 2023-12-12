// Melissa Munoz / Eli - 991642239


import SwiftUI

struct FavLocationsView: View {
    
    @EnvironmentObject var dbHelper : FireDBHelper
    
    
    var body: some View {
        
        
        VStack{
            
            if self.dbHelper.locationList.isEmpty{
                Text("No Favourites Listed")
            }else{
                
                List{
                    
                    ForEach(self.dbHelper.locationList, id: \.id.self){ location in
                        
                        VStack(alignment: .leading){
                            
                            Text(location.name)
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text(location.title)
                                .font(.subheadline)
                            
                        }//VStack
                        
                    }//ForEach
                    .onDelete(){
                        indexSet in
                        for index in indexSet{
                            
                            //delete the student from database
                            self.dbHelper.deleteLocation(docIDtoDelete: self.dbHelper.locationList[index].id!)
                        }
                    }
                }//List
                
                
                
            }
            
            
        }//VStack
        .navigationTitle("Favourite Locations")
        .onAppear(){
            if self.dbHelper.locationList.isEmpty {
                self.dbHelper.retrieveAllLocations()
            }
        }//onAppear
        
    }//body
}//struct

//#Preview {
//    FavLocationsView()
//}
