

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var router : TabRouter
    
    var body: some View {
        ZStack{
            VStack{
                
                Text("List View")
                    .bold()
                    .foregroundColor(.white)
                
                Button{
                    router.change(to: .scan)
                }label:{
                    Text("To Map")
                }//Button
                
            }//VStack
        }//ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mint)
        .clipped()
    }//body
}//struct

#Preview {
    ListView()
        .environmentObject(TabRouter())
}
