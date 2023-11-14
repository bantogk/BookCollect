//
//  MapView.swift
//  BookCollect
//
//  Created by Eli Munoz on 2023-11-14.
//

import SwiftUI

struct MapView: View {
    
    @EnvironmentObject var router : TabRouter
    
    var body: some View {
        ZStack{
            VStack{
                
                Text("Map View")
                    .bold()
                    .foregroundColor(.white)
                
                Button{
                    router.change(to: .list)
                }label:{
                    Text("To List")
                }//Button
                
            }//VStack
        }//ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .clipped()
    }//body
}//Struct

#Preview {
    MapView().environmentObject(TabRouter())
}
