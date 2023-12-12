//
//  AddBookView.swift
//  BookCollect
//
//  Created by Christian on 2023-12-09.
//

import SwiftUI

struct AddBookView: View {
    
    @EnvironmentObject var dbHelper : FireDBHelper
    
    @Environment(\.dismiss) var dismiss
    
    @State private var bookName : String
    
    @State private var bookPages : String
    
    @State private var author : String
    
    @State private var language : String
    
    @State private var publisher : String
    
    @State private var releaseYear : String
    
    @State private var selectedOption1 : Int = 0
    private var bookGenre = ["Adventure", "Mystery", "Drama", "Superhero", "Romance", "Horror", "Thriller", "Fantasy", "History", "Art", "Travel", "Philosophy"]
    
    @State private var selectedOption2 : Int = 0
    private var bookType = ["Fiction", "Non-Fiction"]
    
    init(){
        _bookName = State(initialValue: "")
        _bookPages = State(initialValue: "")
        _author = State(initialValue: "")
        _language = State(initialValue: "")
        _publisher = State(initialValue: "")
        _releaseYear = State(initialValue: "")
    }

    init(book: BookItem){
        _bookName = State(initialValue: book.volumeInfo.title)
        _bookPages = State(initialValue: String(book.volumeInfo.pageCount ?? 0) ?? "")
        _author = State(initialValue: book.volumeInfo.authors[0])
        _language = State(initialValue: book.volumeInfo.language ?? "")
        _publisher = State(initialValue: book.volumeInfo.publisher ?? "")
        _releaseYear = State(initialValue: book.volumeInfo.publishedDate ?? "")
    }
    
    var body: some View {
        NavigationStack{
            Form{
                VStack{
                    Text("Add a Book to the Database").font(.largeTitle).foregroundColor(.blue).navigationTitle("Book Addition Screen")
                        .toolbar {
                            NavigationLink{ //passes array to list screen
                                ViewBooksView()
                            }label:{
                                Text("To Book List")
                            }//NavigationLink
                        }
                    //user inputs
                    TextField("Name of Book", text : self.$bookName).keyboardType(.default).autocapitalization(.none).padding().overlay{
                        RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2)
                    }
                    TextField("Author", text : self.$author).keyboardType(.default).autocapitalization(.none).padding().overlay{
                        RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2)
                    }
                    
                    TextField("Number of Pages", text : self.$bookPages).keyboardType(.numberPad).autocapitalization(.none).padding().overlay{
                        RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2)
                    }
                    
                    TextField("Language", text : self.$language).keyboardType(.default).autocapitalization(.none).padding().overlay{
                        RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2)
                    }
                    
                    TextField("Publisher", text : self.$publisher).keyboardType(.default).autocapitalization(.none).padding().overlay{
                        RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2)
                    }
                    
                    TextField("Release Year", text : self.$releaseYear).keyboardType(.numberPad).autocapitalization(.none).padding().overlay{
                        RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2)
                    }
                    
                    Picker("Book Genre", selection: self.$selectedOption1){
                        ForEach(0..<self.bookGenre.count){
                            Text("\(self.bookGenre[$0])")
                        }}.border(.black, width: 2)
                    Picker("Fiction or Non-Fiction", selection: self.$selectedOption2){
                        ForEach(0..<self.bookType.count){
                            Text("\(self.bookType[$0])")
                        }}.pickerStyle(.segmented)
                    //calls method that adds coffee to array
                    Button(action: self.addBook){
                        Text("Add Book")
                    }.buttonStyle(.borderedProminent)
                }
            }
        }
    }
    
    func addBook(){
        let newBook = BookFirebase(bookName: bookName, author: author, language: language, publisher: publisher, bookPages: Int(bookPages) ?? 0, releaseYear: Int(releaseYear) ?? 0, bookGenre: bookGenre[selectedOption1], bookType: bookType[selectedOption2])
        
//        //save the student info in database
        self.dbHelper.insertBook(book: newBook)
        dismiss()
    }
}
//#Preview {
//    AddBookView()
//}
