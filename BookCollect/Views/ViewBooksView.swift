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
                List{
                    ForEach(self.dbHelper.bookList.enumerated().map({$0}), id: \.element.self){ index, book in
                        
                        NavigationLink{
                           // BookDetailsView(selectedBookIndex : index).environmentObject(self.dbHelper)
                        }label: {
                            HStack{
                                Text(book.bookName ?? "NA")
                                    .bold()
                                Text(book.author ?? "NA")
                                    .bold()
                                Text("\(book.bookPages)" ?? "NA")
                                    .bold()
                                Text(book.publisher ?? "NA")
                                    .bold()
                                Text(book.language ?? "NA")
                                    .bold()
                                Text("\(book.releaseYear)" ?? "NA")
                                    .bold()
                                Text((book.bookGenre) ?? "NA")
                                    .bold()
                                Text((book.bookType) ?? "NA")
                                    .bold()
                                
                                
                            }//HStack
                        }//NavigationLink
                        
                    }//ForEach
                    .onDelete(){indexSet in
                        for index in indexSet{
                            print(#function, "Trying to delete student : id : \(self.dbHelper.bookList[index].id), bookName :  \(self.dbHelper.bookList[index].bookName)")
                            
                            //delete the student from database
                            self.dbHelper.deleteBook(docIDtoDelete: self.dbHelper.bookList[index].id!)
                        }
                    }
                    
                }//List
                .searchable(text: self.$searchText, prompt: "Search by Firstname")
                .onChange(of: self.searchText){ _ in
                    self.runSearch()
                }
            
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink{
                        AddBookView().environmentObject(self.dbHelper)
                    }label: {
                        Image(systemName: "plus.square")
                    }//NavigationLink
                }//ToolbarItem
            }//toolbar
            
            .navigationTitle("Student List")
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


#Preview {
    ViewBooksView()
}
