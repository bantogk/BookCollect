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
                            //changed selectedBookIndex : -> selectedBookIndex:
                            //somehow fixes the list selection
                            BookDetailsView(selectedBookIndex: index).environmentObject(self.dbHelper)
                        }label: {
                            VStack(alignment: .leading){
                                //The compiler is unable to run due to view complexity
                                //To maintain consistent building, only the Name and Author Will be Shown
//                                Text("Name of Book").bold().foregroundColor(.blue)
                                Text(book.bookName ?? "NA")
                                    .bold()
//                                Text("Author").bold().foregroundColor(.blue)
                                Text(book.author ?? "NA")
//                                    .bold()
//                                Text("Number of Pages").bold().foregroundColor(.blue)
//                                Text("\(book.bookPages)" ?? "NA")
//                                    .bold()
//                                Text("Publisher").bold().foregroundColor(.blue)
//                                Text(book.publisher ?? "NA")
//                                    .bold()
//                                Text("Language").bold().foregroundColor(.blue)
//                                Text(book.language ?? "NA")
//                                    .bold()
//                                Text("Release Year").bold().foregroundColor(.blue)
//                                Text("\(book.releaseYear)" ?? "NA")
//                                    .bold()
//                                Text("Genre").bold().foregroundColor(.blue)
//                                Text((book.bookGenre) ?? "NA")
//                                    .bold()
//                                Text("Type of Book").bold().foregroundColor(.blue)
//                                Text((book.bookType) ?? "NA")
//                                    .bold()
                            }
                            // aligns text left
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        
                    }
                    .onDelete(){indexSet in
                        for index in indexSet{
                            print(#function, "Trying to delete book : id : \(self.dbHelper.bookList[index].id), bookName :  \(self.dbHelper.bookList[index].bookName)")
                            
                            //delete the student from database
                            self.dbHelper.deleteBook(docIDtoDelete: self.dbHelper.bookList[index].id!)
                        }
                    }
                    .searchable(text: self.$searchText, prompt: "Search by Book Name")
                    .onChange(of: self.searchText){ _ in
                        self.runSearch()
                    }.toolbar{
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink{
                                AddBookView().environmentObject(self.dbHelper)
                            }label: {
                                Image(systemName: "plus.square")
                            }//NavigationLink
                        }//ToolbarItem
                    }//toolbar
                    
                    .navigationTitle("Books List")
                    .navigationBarTitleDisplayMode(.inline)
                }//NavigationLink
                .onAppear(){
                    //get all Students from database
                    self.dbHelper.retrieveAllBooks()
                }//onAppear
            }//body
            
            
        }
        
    }
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
