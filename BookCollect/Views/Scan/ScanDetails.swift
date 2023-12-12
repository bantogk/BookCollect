// Group 10
//
//  ScanDetails.swift
//  BookCollect
//
//  Created by Kyelle - 991645909 on 2023-12-11.
//

import SwiftUI

struct ScanDetails: View {
    @EnvironmentObject var bookManager : BookManager
    @State var bookItem : BookItem
    @State var isbn : String
    
    var body: some View {
        let book = bookItem.volumeInfo
        VStack{
            Form{
                Section(header: Text("Cover")){
                    if let bookURL = book.imageLinks?.thumbnail {
                        AsyncImage(url: bookURL)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    } else {
                        Text("Image N/A")
                            .padding()
                        
                    }
                }
                
                Section(header: Text("Author(s)")){
                    Text("\(book.authors.joined(separator: ", "))")
                        .bold()
                }
                
                Section(header: Text("Additional Information")){
                    LabeledContent{
                        Text("\(book.averageRating?.description ?? "NA") / 5 stars")
                    }label:{
                        Text("Rating:")
                            .font(.headline)
                        
                    }
                    
                    LabeledContent{
                        Text(String(book.pageCount ?? 0))
                    }label:{
                        Text("# of Pages:")
                            .font(.headline)
                    }

                    LabeledContent{
                        Text(book.language ?? "NA")
                    }label:{
                        Text("Language:")
                            .font(.headline)
                    }

                    LabeledContent{
                        Text(book.publisher ?? "NA")
                    }label:{
                        Text("Publisher:")
                            .font(.headline)
                    }
                    
                    LabeledContent{
                        Text(book.publishedDate ?? "NA")
                    }label:{
                        Text("Release Year:")
                            .font(.headline)
                    }
                    
                    LabeledContent{
                        if let categories = book.categories {
                            Text("\(categories.joined(separator: ", "))")
                        }
                    }label:{
                        Text("Categories:")
                            .font(.headline)
                    }
                    
                }//Section
                
                Section(header: Text("Description")){
                    Text("\(book.description)")
                }//Section
            }//Form
            
            HStack{
                NavigationLink{
                    AddBookView(book: bookItem)
                }label: {
                    Text("Add Book")
                        .font(.largeTitle)
                        .bold()
                }//NavigationLink
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .padding()
            }//HStack
        }//VStack
        .padding()
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.large)
        .onAppear(){
            bookManager.getBooks(newURL: "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyD61Fnw_bU96bpeA4SbvGZye2AjmlmCP5o")
        }
    }
}


