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
    
    @State private var bookName : String = ""
    
    @State private var bookPages : String = ""
    
    @State private var author : String = ""
    
    @State private var language : String = ""
    
    @State private var publisher : String = ""
    
    @State private var releaseYear : String = ""
    
    @State private var selectedOption1 : Int = 1
    private var bookGenre = ["Horror", "Fantasy", "Sci-Fi", "Superhero"]
    
    @State private var selectedOption2 : Int = 1
    private var bookType = ["Fiction", "Non-Fiction"]
    
    var body: some View {
        NavigationStack{
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
    
    func addBook(){
        let newBook = BookFirebase(bookName: bookName, author: author, language: language, publisher: publisher, bookPages: Int(bookPages) ?? 0, releaseYear: Int(releaseYear) ?? 0, bookGenre: bookGenre[selectedOption1], bookType: bookType[selectedOption2])
        
//        //save the student info in database
        self.dbHelper.insertBook(book: newBook)
    }
}
#Preview {
    AddBookView()
}
