//
//  FireDBHelper.swift
//  BookCollect
//
//  Created by Eli Munoz on 2023-11-14.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var bookList = [BookFirebase]()
    
    @Published var locationList = [LocationFirebase]()

    
    private let db : Firestore
    
    //singleton design pattern
    //singleton object
    
    private static var shared : FireDBHelper?
    
    private let COLLECTION_NAME = "Books"
    private let ATTRIBUTE_BNAME = "bookName"
    private let ATTRIBUTE_ANAME = "author"
    private let ATTRIBUTE_PUB = "publisher"
    private let ATTRIBUTE_LAN = "language"
    private let ATTRIBUTE_BPAG = "bookPages"
    private let ATTRIBUTE_RYEAR = "releaseYear"
    private let ATTRIBUTE_GEN = "bookGenre"
    private let ATTRIBUTE_TYPE = "bookType"
    
    
    private let COLLECTION_LNAME = "Locations"
    private let ATTRIBUTE_LNAME = "name"
    private let ATTRIBUTE_LTITLE = "title"
    private let ATTRIBUTE_LLATITUDE = "latitude"
    private let ATTRIBUTE_LLONGITUDE = "longitude"
    private let ATTRIBUTE_LLDATE = "date"
    
    private init(database : Firestore){
        self.db = database
    }
    
    static func getInstance() -> FireDBHelper{
        
        if (self.shared == nil){
            shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return self.shared!
    }
    
    func insertBook(book : BookFirebase){
        do{
           // if(book.bookName == self.db.collection(COLLECTION_NAME).document() )
            try self.db.collection(COLLECTION_NAME).addDocument(from: book)
            
        }catch let err as NSError{
            print(#function, "Unable to insert : \(err)")
        }
    }
    
    func deleteBook(docIDtoDelete : String){
        self.db
            .collection(COLLECTION_NAME)
            .document(docIDtoDelete)
            .delete{error in
                if let err = error{
                    print(#function, "Unable to delete : \(err)")
                }else{
                    print(#function, "Document deleted successfully")
                }
            }
    }
    
    func retrieveAllBooks(){
        do{
            
            self.db
                .collection(COLLECTION_NAME)
                .order(by: ATTRIBUTE_BNAME, descending: true)
                .addSnapshotListener( { (snapshot, error) in
                    
                    guard let result = snapshot else{
                        print(#function, "Unable to retrieve snapshot : \(error)")
                        return
                    }
                    
                    print(#function, "Result : \(result)")
                    
                    result.documentChanges.forEach{ (docChange) in
                        
                        do{
                            //obtain the document as Student class object
                            let book = try docChange.document.data(as: BookFirebase.self)
                            
                            print(#function, "book from db : id : \(book.id) bookname : \(book.bookName)")
                            
                            //check if the changed document is already in the list
                            let matchedIndex = self.bookList.firstIndex(where: { ($0.id?.elementsEqual(book.id!))!})
                            
                            if docChange.type == .added{
                                
                                if (matchedIndex != nil){
                                    //the document object is already in the list
                                    //do nothing to avoid duplicates
                                }else{
                                    self.bookList.append(book)
                                }
                                
                                print(#function, "New document added : \(book)")
                            }
                            
                            if docChange.type == .modified{
                                print(#function, "Document updated : \(book)")
                                
//                                if (matchedIndex != nil){
//                                    //the document object is already in the list
//                                    //replace existing document
//                                    self.studentList[matchedIndex!] = stud
//                                }
                            }
                            
                            if docChange.type == .removed{
                                print(#function, "Document deleted : \(book)")
                                
//                                if (matchedIndex != nil){
//                                    //the document object is still in the list
//                                    //delete existing document
//                                    self.studentList.remove(at: matchedIndex!)
//                                }
                            }
                            
                        }catch let err as NSError{
                            print(#function, "Unable to access document change : \(err)")
                        }
                        
                    }
                })
            
        }catch let err as NSError{
            print(#function, "Unable to retrieve \(err)" )
        }
        
    }
    
    func retrieveBookByName(bname : String){
        do{
            
            self.db
                .collection(COLLECTION_NAME)
                .whereField("bookName", isEqualTo: bname)
//                .whereField("gpa", isGreaterThan: 3.4 )
//                .whereField("firstname", in: [fname, "Amy", "James])
//                .order(by: "gpa", descending: true)
                .addSnapshotListener( { (snapshot, error) in
                    
                    guard let result = snapshot else {
                        print(#function, "Unable to search database for the firstname due to error  : \(error)")
                        return
                    }
                    
                    print(#function, "Result of search by first name : \(result)")
                    
                    result.documentChanges.forEach{ (docChange) in
                        //try to convert the firestore document to Student object and update the studentList
                        do{
                            let book = try docChange.document.data(as: BookFirebase.self)
                            
                            if docChange.type == .added{
                                self.bookList.append(book)
                            }
                        }catch let err as NSError{
                            print(#function, "Unable to obtain Student object \(err)" )
                        }
                    }
                })
            
        }catch let err as NSError{
            print(#function, "Unable to retrieve \(err)" )
        }
    }
    
    func updateBook( updatedStudentIndex : Int ){
        
//        //setData more apprpropriate if entire document needs to be updated
//        do{
//            try self.db
//                .collection(COLLECTION_NAME)
//                .document(self.studentList[updatedStudentIndex].id!)
//                .setData(from: self.studentList[updatedStudentIndex])
//        }catch let err as NSError{
//            print(#function, "Unable to update \(err)" )
//        }
        
        //updateData more apprpropriate if some fields of document needs to be updated
       self.db
            .collection(COLLECTION_NAME)
            .document(self.bookList[updatedStudentIndex].id!)
            .updateData([ATTRIBUTE_BNAME : self.bookList[updatedStudentIndex].bookName,
                         ATTRIBUTE_ANAME : self.bookList[updatedStudentIndex].author,
                         ATTRIBUTE_PUB : self.bookList[updatedStudentIndex].publisher,
                         ATTRIBUTE_LAN : self.bookList[updatedStudentIndex].language,
                         ATTRIBUTE_RYEAR : self.bookList[updatedStudentIndex].releaseYear,
                          ATTRIBUTE_BPAG : self.bookList[updatedStudentIndex].bookPages,
                          ATTRIBUTE_GEN : self.bookList[updatedStudentIndex].bookGenre,
                          ATTRIBUTE_TYPE : self.bookList[updatedStudentIndex].bookType,
                        ]){ error in
                
                if let err = error{
                    print(#function, "Unable to update document : \(err)")
                }else{
                    print(#function, "Document updated successfully")
                }
                
            }
    }
    
    
    
    
    
    
    //Locations
    func insertLocation(location: LocationFirebase) {
        do {
            try self.db.collection(COLLECTION_LNAME).addDocument(from: location)
        } catch let err as NSError {
            print(#function, "Unable to insert: \(err)")
        }
    }
    
    func deleteLocation(docIDtoDelete: String) {
        self.db.collection(COLLECTION_LNAME).document(docIDtoDelete).delete { error in
            if let err = error {
                print(#function, "Unable to delete: \(err)")
            } else {
                print(#function, "Document deleted successfully")
            }
        }
    }
    
    func retrieveAllLocations() {
        self.db.collection(COLLECTION_LNAME)
            .order(by: ATTRIBUTE_LLDATE, descending: false)
            .addSnapshotListener { [weak self] snapshot, error in
            guard let result = snapshot else {
                print(#function, "Unable to retrieve snapshot: \(error ?? "Unknown Error" as! Error)")
                return
            }
            
            result.documentChanges.forEach { docChange in
                do {
                    let location = try docChange.document.data(as: LocationFirebase.self)
                    
                    if docChange.type == .added {
                        self?.locationList.append(location)
                    }
                    
                    if docChange.type == .modified {
                        // Handle modified document if needed
                    }
                    
                    if docChange.type == .removed {
                        if let index = self?.locationList.firstIndex(where: { $0.id == location.id }) {
                            self?.locationList.remove(at: index)
                        }
                    }
                    
                } catch let err as NSError {
                    print(#function, "Unable to access document change: \(err)")
                }
            }
        }
    }
    
    
    
    
}

