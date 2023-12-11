//
//  BookDetailsView.swift
//  BookCollect
//
//  Created by Christian on 2023-12-09.
//

import SwiftUI

struct BookDetailsView: View {
    
    @EnvironmentObject var dbHelper : FireDBHelper
    @Environment(\.dismiss) var dismiss
    
    public var selectedBookIndex : Int = -1
    
    @State private var bookName : String = ""
    
    @State private var bookPages : String = ""
    
    @State private var author : String = ""
    
    @State private var language : String = ""
    
    @State private var publisher : String = ""
    
    @State private var releaseYear : String = ""
    
    @State private var selectedOption1 : Int = 0
    private var bookGenre = ["Adventure", "Mystery", "Drama", "Superhero", "Romance", "Horror", "Thriller", "Fantasy", "History", "Art", "Travel", "Philosophy"]
    
    @State private var selectedOption2 : Int = 0
    private var bookType = ["Fiction", "Non-Fiction"]
    
    private var releaseyear : Int{
        return Int(self.releaseYear) ?? 0
    }
    
    private var bookpages : Int{
        return Int(self.bookPages) ?? 0
    }
    
    init(selectedBookIndex : Int){
        self.selectedBookIndex = selectedBookIndex
    }
    
    var body: some View {
        
        VStack{
            
            Form{
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
                
            }//Form
                
                Button{
                    self.updateStudent()
                }label: {
                    Text("Save Info")
                        .font(.title2)
                }
                .buttonStyle(.borderedProminent)
        }//VStack
        .onAppear(perform: {
            
            //show existing student information on Form
            self.bookName = self.dbHelper.bookList[selectedBookIndex].bookName ?? "NA"
            self.bookPages = "\(self.dbHelper.bookList[selectedBookIndex].bookPages)"
            self.author = self.dbHelper.bookList[selectedBookIndex].author ?? "NA"
            self.language = self.dbHelper.bookList[selectedBookIndex].language ?? "NA"
            self.publisher = self.dbHelper.bookList[selectedBookIndex].publisher ?? "NA"
            self.releaseYear = "\(self.dbHelper.bookList[selectedBookIndex].releaseYear)"
        })
        .onDisappear(){
            //event will be triggered when the view is removed from foreground
            //take necessary actions such as taking backup of data, etc.
            print(#function, "StudentDetailView removed from foreground")
        }
        .navigationTitle("Student Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }//body
    
    private func updateStudent(){
        
        //get the updated details from form and update the dbHelper studentList object
        self.dbHelper.bookList[selectedBookIndex].bookName = self.bookName
        self.dbHelper.bookList[selectedBookIndex].bookPages = self.bookpages
        self.dbHelper.bookList[selectedBookIndex].author = self.author
        self.dbHelper.bookList[selectedBookIndex].language = self.language
        self.dbHelper.bookList[selectedBookIndex].publisher = self.publisher
        self.dbHelper.bookList[selectedBookIndex].releaseYear = self.releaseyear
        
        //save the student info in database
        self.dbHelper.updateBook(updatedStudentIndex: self.selectedBookIndex)
        
        //remove current view/screen from stack
        dismiss()
    }
}

#Preview {
    BookDetailsView(selectedBookIndex: -1)
}
