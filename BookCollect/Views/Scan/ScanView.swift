
import SwiftUI

struct ScanView: View {
    
    @EnvironmentObject var router : TabRouter
    
    var body: some View {
        
        ZStack{
            VStack{
                
                Text("Scan View")
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
        .background(.pink)
        .clipped()
        
    }//body
}//struct

#Preview {
    ScanView().environmentObject(TabRouter())
}
