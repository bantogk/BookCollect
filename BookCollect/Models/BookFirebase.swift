// Group 10
//
//  BookFirebase.swift
//  BookCollect
//
//  Created by Christian - 991612602 on 2023-12-09.
//

import Foundation
import FirebaseFirestoreSwift


struct BookFirebase : Codable, Hashable{
    
    @DocumentID var id : String? = UUID().uuidString
    
    
    var bookName : String = ""
    
    var bookPages : Int = 0
    
    var author : String = ""
    
    var language : String = ""
    
    var publisher : String = ""
    
    var releaseYear : Int = 0
    
    var bookGenre : String = ""
    
    var bookType : String = ""
    
    init(){
        self.bookName = ""
        self.bookPages = 0
        self.author = ""
        self.language = ""
        self.publisher = ""
        self.releaseYear = 0
        self.bookGenre = ""
        self.bookType = ""
    }
    
    init(bookName: String, author: String, language: String, publisher : String, bookPages: Int, releaseYear : Int, bookGenre : String, bookType : String){
        self.bookName = bookName
        self.bookPages = bookPages
        self.author = author
        self.language = language
        self.publisher = publisher
        self.releaseYear = releaseYear
        self.bookGenre = bookGenre
        self.bookType = bookType
    }
    
    init?(dictionary: [String: Any]){
        guard let bookName = dictionary["bookName"] as? String else{
            return nil
        }
        
        guard let author = dictionary["author"] as? String else{
            return nil
        }
        
        guard let language = dictionary["language"] as? String else{
            return nil
        }
        guard let publisher = dictionary["language"] as? String else{
            return nil
        }
        
        guard let bookPages = dictionary["bookPages"] as? Int else{
            return nil
        }
        guard let releaseYear = dictionary["bookPages"] as? Int else{
            return nil
        }
        guard let bookGenre = dictionary["bookGenre"] as? String else{
            return nil
        }
        guard let bookType = dictionary["bookType"] as? String else{
            return nil
        }
        
        self.init(bookName: bookName, author: author, language: language, publisher: publisher, bookPages: bookPages, releaseYear: releaseYear, bookGenre: bookGenre, bookType: bookType)
        
    }
    
}
