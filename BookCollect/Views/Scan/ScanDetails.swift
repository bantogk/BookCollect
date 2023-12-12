//
//  ScanDetails.swift
//  BookCollect
//
//  Created by Kyelle on 2023-12-11.
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
                Section{
                    if let bookURL = book.imageLinks?.thumbnail {
                        AsyncImage(url: bookURL)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    } else {
                        Text("No image available")
                            .padding()
                        
                    }
                }
                
                Section(header: Text("Details")){
                    LabeledContent{
                        Text("\(book.averageRating?.description ?? "??") / 5 stars")
                    }label:{
                        Text("Average Rating:")
                            .font(.headline)
                        
                    }
                    
                    LabeledContent{
                        Text("\(book.authors.joined(separator: ", "))")
                    }label:{
                        Text("Authors:")
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
                    
                    
                    LabeledContent{
                        if let firstIndustryIdentifier = book.industryIdentifiers.first {
                            Text("\(firstIndustryIdentifier.identifier)")
                                .font(.caption)
                        }
                    }label:{
                        Text("ISBN:")
                            .font(.headline)
                    }
                    
                    
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
        .navigationTitle(book.title)
        .onAppear(){
            bookManager.getBooks(newURL: "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyD61Fnw_bU96bpeA4SbvGZye2AjmlmCP5o")
        }
    }
}


