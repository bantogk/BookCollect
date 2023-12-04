
import SwiftUI
import CodeScanner

struct ScanView: View {
    
    @EnvironmentObject var router : TabRouter
    
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a Book Barcode to get started."
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.ean13],
            simulatedData: "9780441172719",
            completion: { response in
                if case let .success(result) = response {
                    self.scannedCode = result.string
                    print(#function, "returned \(self.scannedCode)")
                    self.isPresentingScanner = false
                }
//                if case let .error(error) = response {
//                    self.scannedCode = "Must be 13-digit Barcode (EAN-13)"
//                    print(error.localizedDescription)
//                    self.isPresentingScanner = false
//                }
            }
        )
    }
    
    var body: some View {
        ZStack{
            VStack{
                Text(scannedCode)
                    .bold()
                
                Button{
                    self.isPresentingScanner = true
                }label:{
                    Text("Start Scanning!")
                }//Button
                
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
            }//VStack
        }//ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        
    }//body
}//struct

// Not Swift 5.7 compatible
//#Preview {
//    ScanView().environmentObject(TabRouter())
//}

//struct ScanView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScanView().environmentObject(TabRouter())
//    }
//}
