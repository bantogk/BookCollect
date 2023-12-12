//
//  ViewBooksView.swift
//  BookCollect
//
//  Created by Christian on 2023-12-09.
//

import SwiftUI

struct ViewBooksView: View {
    
    @EnvironmentObject var dbHelper : FireDBHelper
    @State private var searchText : String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(self.dbHelper.bookList.enumerated().map({$0}), id: \.element.self){ index, book in
                        
                        NavigationLink{

                            BookDetailsView(selectedBookIndex: index).environmentObject(self.dbHelper)

                            BookDetailsView(selectedBookIndex : index).environmentObject(self.dbHelper)
                        }label: {
                            VStack(alignment : .leading){
                                Text("Name of Book: \(book.bookName ?? "NA")").bold().foregroundColor(.blue)
                                Text("Author: \(book.author ?? "NA")").bold()
                                Text("Number of Pages: \(String(book.bookPages) ?? "NA")").bold()
                                Text("Publisher: \(book.publisher ?? "NA")").bold()
                                Text("Language: \(book.language ?? "NA")").bold()
                                Text("Release Year: \(String(book.releaseYear) ?? "NA")").bold()
                                Text("Genre: \(book.bookGenre ?? "NA")").bold()
                                Text("Type of Book: \(book.bookType ?? "NA")").bold()
                            }//VStack
                        }//NavigationLink
                        
                    }//ForEach
                    .onDelete(){indexSet in
                        for index in indexSet{
                            print(#function, "Trying to delete book : id : \(self.dbHelper.bookList[index].id), name :  \(self.dbHelper.bookList[index].bookName)")
                            
                            //delete the student from database
                            self.dbHelper.deleteBook(docIDtoDelete: self.dbHelper.bookList[index].id!)
                        }
                    }
                    
                }//List
                .searchable(text: self.$searchText, prompt: "Search by Firstname")
                .onChange(of: self.searchText){ _ in
                    self.runSearch()
                }
            }//VStack
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink{
                        AddBookView().environmentObject(self.dbHelper)
                    }label: {
                        Image(systemName: "plus.square")
                    }//NavigationLink
                }//ToolbarItem
            }//toolbar
            
            .navigationTitle("Book List")
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationStack
        .onAppear(){
            //get all Students from database
            self.dbHelper.retrieveAllBooks()
        }//onAppear
    }//body
    
    private func runSearch(){
        print(#function, "searching for Text : \(self.searchText)")
        
        self.dbHelper.bookList.removeAll()
        
        if(self.searchText.isEmpty){
            self.dbHelper.retrieveAllBooks()
        }else{
            self.dbHelper.retrieveBookByName(bname: self.searchText)
        }
    }
}


//#Preview {
//    ViewBooksView()
//}
