// Group 10
// Melissa Munoz / Eli - 991642239


import SwiftUI

struct RecView: View {
    @State private var category: String = ""
    @EnvironmentObject var bookManager: BookManager
    @EnvironmentObject var firebaseHelper : FireDBHelper
    @State private var bookList: [Books] = [Books]()
    
    var body: some View {
        VStack {
            
            if self.bookManager.bookList.items.isEmpty {
                VStack{
                    HStack{
                        
                        ProgressView()
                            .controlSize(.large)
                        Text("Loading...")
                            .font(.headline)
                            .bold()
                            .padding()
                        
                    }
                    Text("Currently catching dust bunnies! Please wait!")
                        .font(.caption)
                }.background(.white)
                
            } else {
                VStack{
                    Text("I heard you like")
                        .font(.headline)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text("\(self.category)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Text("books.")
                        .font(.headline)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                }.padding()
                List {
                    
                    ForEach(self.bookManager.bookList.items.indices, id: \.self) { bookIndex in
                        let book = self.bookManager.bookList.items[bookIndex]
                        
                        NavigationLink(
                            destination: RecDetails(book: self.bookManager.bookList.items[bookIndex], category: self.category).environmentObject(self.bookManager)
                        ) {
                            VStack {
                                
                                if let bookURL = book.volumeInfo.imageLinks?.thumbnail {
                                    AsyncImage(url: bookURL)       .padding()
                                } else {
                                    Text("No image available :(")
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
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.pink)
        .clipped()
        .onAppear() {
            self.firebaseHelper.retrieveAllBooks()
            //                print(#function, "\n\n\(self.firebaseHelper.bookList.first?.bookGenre)\n\n")
            
            //What this does: execute the following code block on the main queue after a delay of 2 seconds from the current time.
            //Ensures that retrieveallbooks is done before this operation works
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.pickRandomGenre(from: self.firebaseHelper.bookList)
                bookManager.getBooks(newURL: "https://www.googleapis.com/books/v1/volumes?q=subject:\(category)&key=APIKEYHERE")
            }
            
            //                self.pickRandomGenre(from: self.firebaseHelper.bookList)
            //                bookManager.getBooks(category: self.category)
        }//onAppear
    }//body
    
    func pickRandomGenre(from books: [BookFirebase]){
        //unique
        var genres: Set<String> = []
        
        //get all books
        for book in books {
            if !genres.contains(book.bookGenre) {
                genres.insert(book.bookGenre)
            }
        }
        
        //if its not empty, pick a random index and assign category to variable
        if !genres.isEmpty {
            let index = Int.random(in: 0..<genres.count)
            let randomGenre = genres.index(genres.startIndex, offsetBy: index)
            self.category = genres[randomGenre]
            print(#function, "Category: \(self.category)")
        } else {
            print(#function, "no genres found")
        }
    }
    
}//view

//struct RecView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecView().environmentObject(TabRouter())
//    }
//}
