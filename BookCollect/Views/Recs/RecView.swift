// Melissa Munoz / Eli - 991642239

/* TO DO: Save recommendations to subcollections in database */

import SwiftUI

struct RecView: View {
    @State private var category: String = "adventure"
    @EnvironmentObject var bookManager: BookManager
    @State private var bookList: [Book] = [Book]() //bantogk: renamed class to Book to maintain consistency
    
    var body: some View {
        ZStack {
            VStack {
                Text("I heard you like \(category)")
                    .font(.title)
                Text("Here are some recommendations you might like...")
                    .font(.caption)
                
                if self.bookManager.bookList.items.isEmpty {
                    Text("No data received from API")
                } else {
                    List {
                        ForEach(self.bookManager.bookList.items.indices, id: \.self) { bookIndex in
                            let book = self.bookManager.bookList.items[bookIndex]
                            
                            NavigationLink(
                                destination: RecDetails(bookList: self.bookList, category: self.category, selectedIndex: bookIndex).environmentObject(self.bookManager)
                            ) {
                                //bantogk: Moved VStack to BookView
//                                BookView(book: Book)
                                VStack {
                                    
                                    if let bookImage = book.volumeInfo.image {
                                        Image(uiImage: bookImage)
                                        //                                            .resizable()
                                        //                                            .aspectRatio(contentMode: .fit)
                                        //                                            .frame(width: 300, height: 100)
                                        //                                            .padding()
                                    } else {
                                        Text("No image available")
                                            .padding()
                                    }
                                    
                                    LabeledContent {
                                        Text("\(book.volumeInfo.title)")
                                    } label: {
                                        Text("Title:")
                                    }
                                    
                                    LabeledContent {
                                        Text("\(book.volumeInfo.authors.joined(separator: ", "))")
                                    } label: {
                                        Text("Author:")
                                    }
                                    
                                    LabeledContent {
                                        if let categories = book.volumeInfo.categories {
                                            Text("\(categories.joined(separator: ", "))")
                                        } else {
                                            Text("No categories available")
                                        }
                                    } label: {
                                        Text("Categories:")
                                    }
                                    
                                    LabeledContent {
                                        if let firstIndustryIdentifier = book.volumeInfo.industryIdentifiers.first {
                                            Text("\(firstIndustryIdentifier.identifier)")
                                                .font(.caption)
                                        } else {
                                            Text("No identifier available")
                                        }
                                    } label: {
                                        Text("ISBN:")
                                    }
                                    
                                    LabeledContent {
                                        Text("\(book.volumeInfo.averageRating?.description ?? "??") / 5 stars")
                                    } label: {
                                        Text("Rating")
                                    }
                                    
                                    Text("\(book.volumeInfo.description)")
                                        .lineLimit(3)
                                    
                                }//VStack
                            }//NavLink
                        }//ForEach
                    }//List
                    .listStyle(.inset)
                    .listRowSeparator(.visible)
                }//if-else
            }//Vstack
            .onAppear() {
                bookManager.getBooks(category: category)
            }//onAppear
        }//Zstack
    }//body
}//view

//struct RecView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecView().environmentObject(TabRouter())
//    }
//}
