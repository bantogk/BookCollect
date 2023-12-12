
import SwiftUI
import CodeScanner

struct ScanView: View {
    
//    @EnvironmentObject var router : TabRouter
    @EnvironmentObject var bookManager : BookManager
    @EnvironmentObject var firebaseHelper : FireDBHelper
    
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a Book Barcode to get started!"
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.ean13],
            simulatedData: "9780345391803",
            completion: { response in
                if case let .success(result) = response {
                    self.scannedCode = result.string
                    print(#function, "returned \(self.scannedCode)")
                    requestByISBN(isbn: self.scannedCode)
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
    
    func requestByISBN(isbn: String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            bookManager.getBooks(newURL: "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyD61Fnw_bU96bpeA4SbvGZye2AjmlmCP5o")
        }
    }
    
    var body: some View {
        VStack{
            if(self.scannedCode == "Scan a Book Barcode to get started!"){
                Spacer()
                VStack{
                    Text(self.scannedCode)
                        .bold()
                        .font(.title2)
                }//VStack
                Spacer()
                Button{
                    self.isPresentingScanner = true
                }label:{
                    Text("Scan a Barcode (ISBN)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        
                }//Button
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .frame(maxWidth: .infinity)
            }else{
                VStack {
                    if self.bookManager.bookList.items.isEmpty {
                        VStack{
                            HStack{
                                
                                ProgressView()
                                    .controlSize(.large)
                                Text("Reading...")
                                    .font(.headline)
                                    .bold()
                                    .padding()
                                
                            }
                            Text("Give me a moment to read the lines.")
                                .font(.caption)
                        }.background(.white)
                        
                    } else {
                        List {
                            
                            ForEach(self.bookManager.bookList.items.indices, id: \.self) { bookIndex in
                                let book = self.bookManager.bookList.items[bookIndex]
                                
                                NavigationLink(
                                    destination: ScanDetails(
                                        bookItem: self.bookManager.bookList.items[bookIndex],
                                        isbn: self.scannedCode
                                    ).environmentObject(self.bookManager)
                                ) {
                                    VStack {
                                        
                                        if let bookURL = book.volumeInfo.imageLinks?.thumbnail {
                                            AsyncImage(url: bookURL)       .padding()
                                        } else {
                                            Text("Image N/A")
                                                .padding()
                                                .font(.subheadline)
                                        }
                                        
                                        LabeledContent {
                                            Text("\(book.volumeInfo.title)")
                                                .font(.subheadline)
                                        } label: {
                                            Text("Title:")
                                        }
                                        
                                        LabeledContent {
                                            Text("\(book.volumeInfo.authors.joined(separator: ", "))")
                                                .font(.subheadline)
                                        } label: {
                                            Text("Author:")
                                        }
                                        
                                        LabeledContent {
                                            Text("\(book.volumeInfo.averageRating?.description ?? "??") / 5 stars")
                                                .font(.subheadline)
                                        } label: {
                                            Text("Rating")
                                        }
                                        
                                        Text("\(book.volumeInfo.description)")
                                            .lineLimit(3)
                                        
                                    }//VStack
                                }//NavLink
                            }//ForEach
                        }//List
                        .listStyle(.insetGrouped)
                        .listRowSeparator(.visible)
                    }//if-else
                }//Vstack
                Spacer()
                Button{
                    self.isPresentingScanner = true
                }label:{
                    Text("Scan a Barcode (ISBN)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        
                }//Button
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .frame(maxWidth: .infinity)
            }//if-else
        }//VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .onAppear(){
            self.scannedCode = "Scan a Book Barcode to get started!"
        }
        
    }//body
}//struct
