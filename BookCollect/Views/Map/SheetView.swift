// Melissa Munoz / Eli - 991642239
//references: https://youtu.be/WTzBKOe7MmU?si=OMozbW-os4O_EgzH

import SwiftUI
import MapKit


struct SheetView: View {
    @State var locations: [Location]
    @State private var showAlert: Bool = false
    @State private var selectedLocation: Location?
    @EnvironmentObject var firebaseHelper : FireDBHelper
    
    var body: some View {
        VStack {
            Spacer()
            
            
            
            List {
                
                ForEach(self.locations, id: \.id) {
                    
                    location in
                    
                    Button{
                        
                        print(#function, "Clicking \(location.name)")
                        self.showAlert = true
                        self.selectedLocation = location
                        
                    }label:{
                        
                        HStack(alignment: .lastTextBaseline){
                            
                            
                            
                            VStack(alignment: .leading) {
                                Text(location.name)
                                    .fontWeight(.bold)
                                
                                Text(location.title)
                                    .foregroundColor(.black)
                            }//VStack
                        }//HStack
                        .padding()
                    }//Button
                    
                }//ForEach
                
            }//List
            .listStyle(.insetGrouped)
        }//VStack
        .alert(isPresented: $showAlert) {
            if let selectedLocation = self.selectedLocation {
                return Alert(
                    title: Text("Favourite \(selectedLocation.name)?"),
                    message: Text("Allow us to manage your favourites locations."),
                    primaryButton: .default(
                        Text("Save"),
                        action: {
                            
                            let locationFirebase = selectedLocation.convertToLocationFirebase()

                            //add to database
                            self.firebaseHelper.insertLocation(location: locationFirebase)
                        }
                    ),
                    secondaryButton: .destructive(
                        Text("Cancel")
                        // action: deleteWorkoutData
                    )
                )
            } else {
                return Alert(title: Text("Error"), message: Text("Location not found"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
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
