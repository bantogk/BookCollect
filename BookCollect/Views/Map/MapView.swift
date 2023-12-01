//
//  MapView.swift
//  BookCollect
//
//  Created by Eli Munoz on 2023-11-14.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    //for tabview
    @EnvironmentObject var router : TabRouter
    @EnvironmentObject var locationHelper : LocationHelper
    
    @State private var locations: [Location] = [Location]()
    
    @State private var isSheetPresented: Bool = false
    
    
    var body: some View {
        ZStack{
            VStack{
                
                Text(self.locationHelper.currentLocation?.coordinate.longitude.description ?? "NA")
                    .bold()
                    .foregroundColor(.white)
                Text(self.locationHelper.currentLocation?.coordinate.latitude.description ?? "NA")
                    .bold()
                    .foregroundColor(.white)
                ZStack(alignment: .bottomTrailing){
                    BookMap(locations: locations).environmentObject(self.locationHelper)
                    
                        .sheet(isPresented: $isSheetPresented) {
                            SheetView(locations: locations)
                        }//sheet
                    
                    Button {
                        self.isSheetPresented = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title.weight(.semibold))
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }//Button
                    .padding(.bottom,80)
                    .padding(.trailing, 20)
                    
                }//ZStack
            }//VStack
        }//ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .clipped()
    }//body
}//Struct

//#Preview {
//    MapView().environmentObject(TabRouter())
//}
