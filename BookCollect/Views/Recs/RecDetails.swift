// Melissa Munoz / Eli - 991642239

import SwiftUI

struct RecDetails: View {
    
    @EnvironmentObject var bookManager : BookManager
    @State var bookList : [Books]
    @State var category : String
    var selectedIndex : Int = -1
    @State private var locations: [Location] = [Location]()
    
    var body: some View {
        VStack{
            
            Text("Good choice!")
            
            Text("")
            
            NavigationLink{
                MapView()
            }label: {
                Text("Search the nearest Bookstores")
                    .font(.title2)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            
        }
        .onAppear(){
            
            bookManager.getBooks(category: category)
            
        }//OnAppear
        
    }//body
}//view

//#Preview {
//    RecDetails()
//}
