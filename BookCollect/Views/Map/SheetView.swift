// Melissa Munoz / Eli - 991642239


import SwiftUI
import MapKit


struct SheetView: View {
    @State private var search: String = ""
    @State var locations: [Location] = [Location]()
    @State private var tapped: Bool = false
    
    
    private func getNearByLocations() {
        
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
                
            }//if/else
            
        }//search.start
        
    }//getNearBy:amdmarks
    
    func calculateOffset() -> CGFloat {
        
        if self.locations.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        }//if-else
        else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }//else
    }//calculateOffset
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $search, onEditingChanged: {_ in}){
                    self.getNearByLocations()
                }//onEditingChanged
                .autocorrectionDisabled()
                .keyboardType(.default)
            }
            .modifier(TextFieldGrayBackgroundColor())
            
            Spacer()
            
            List {
                
                ForEach(self.locations, id: \.id) { location in
                    
                    VStack(alignment: .leading) {
                        Text(location.name)
                            .fontWeight(.bold)
                        
                        Text(location.title)
                    }//VStack
                }//ForEach
                
            }//List
        }//VStack
        .padding()
//        .interactiveDismissDisabled()
        .presentationDetents([.height(200), .large])
    }
    
    
}

struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
    
}
