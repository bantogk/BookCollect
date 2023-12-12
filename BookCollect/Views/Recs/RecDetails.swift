// Group 10
// Melissa Munoz / Eli - 991642239

import SwiftUI

struct RecDetails: View {
    
    @EnvironmentObject var bookManager : BookManager
    @State var book : BookItem
    @State var category : String
    @State private var locations: [Location] = [Location]()
    
    var body: some View {
        VStack{
            Form{

                Section{
                    
                    if let bookURL = book.volumeInfo.imageLinks?.thumbnail {
                        AsyncImage(url: bookURL)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    } else {
                        Text("No image available")
                            .padding()
                        
                    }
                    
                    Text("\(self.book.volumeInfo.title)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    //            if let bookImage = book.volumeInfo.image {
                    //                Image(uiImage: bookImage)
                    //                .resizable()
                    //                .aspectRatio(contentMode: .fit)
                    //                .frame(width: 300, height: 100)
                    //                .padding()
                    //            } else {
                    //                Text("No image available")
                    //                    .padding()
                    //            }
                    //
                }//Section
                
                Section(header: Text("Details")){
                    LabeledContent{
                        Text("\(book.volumeInfo.averageRating?.description ?? "??") / 5 stars")
                    }label:{
                        Text("Average Rating:")
                            .font(.headline)
                        
                    }
                    
                    LabeledContent{
                        Text("\(book.volumeInfo.authors.joined(separator: ", "))")
                    }label:{
                        Text("Authors:")
                            .font(.headline)
                    }
                    
                    LabeledContent{
                        if let categories = book.volumeInfo.categories {
                            Text("\(categories.joined(separator: ", "))")
                        }
                    }label:{
                        Text("Categories:")
                            .font(.headline)
                    }
                    
                    
                    LabeledContent{
                        if let firstIndustryIdentifier = book.volumeInfo.industryIdentifiers.first {
                            Text("\(firstIndustryIdentifier.identifier)")
                                .font(.caption)
                        }
                    }label:{
                        Text("ISBN:")
                            .font(.headline)
                    }
                    
                    
                }//Section
                
                Section(header: Text("Description")){
                    Text("\(book.volumeInfo.description)")
                }//Section
            }//Form
            HStack{
                Spacer()
                NavigationLink{
                    MapView()
                }label: {
                    Text("Search near Bookstores")
                        .font(.title2)
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                .padding()
                Spacer()
            }
        }//VStack
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            
            bookManager.getBooks(newURL: "https://www.googleapis.com/books/v1/volumes?q=subject:\(category)&key=AIzaSyD61Fnw_bU96bpeA4SbvGZye2AjmlmCP5o")
            
        }//OnAppear
        
    }//body
}//view

//#Preview {
//    RecDetails()
//}
