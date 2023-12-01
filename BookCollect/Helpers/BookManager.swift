// Melissa Munoz / Eli - 991642239


import Foundation
import UIKit

class BookManager : ObservableObject{
    
    @Published var bookList = Books()
    
    init(){
        //        self.getBooks()
    }
    
    func getBooks(category: String){
        
        print("GetBooks() Fetching data from API called")
        
        let baseURL = "https://www.googleapis.com/books/v1/volumes?q=subject:\(category)&key=AIzaSyD61Fnw_bU96bpeA4SbvGZye2AjmlmCP5o"
        
        //convert string to URL type
        guard let apiURL = URL(string: baseURL) else{
            return
        }
        
        print(#function, "BASEURL: \(baseURL)\n")
        print(#function, "APIURL: \(apiURL)\n")
        
        //initiate asynchronosu background task
        let task = URLSession.shared.dataTask(with: apiURL){
            
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let err = error {
                
                print(#function, "Unable to connect to the web service :\(err)")
                
                return
            }else{
                
                print(#function, "Connected to web service\n")
                
                if let httpResponse = response as? HTTPURLResponse{
                    if (httpResponse.statusCode == 200){
                        
                        //if-ok
                        print("HTTP: 200 OK!\n")
                        
                        DispatchQueue.global().async {
                            
                            do{
                                
                                if (data != nil){
                                    
                                    if let jsonData = data{
                                        let decoder = JSONDecoder()
                                        
                                        var decodedBook = try decoder.decode(Books.self, from:jsonData)
                                        
//                                        dump(decodedBook)
                                        
       
                                        for bookIndex in 0..<decodedBook.items.count {
                                            var book = decodedBook.items[bookIndex]
                                            
                                            if let thumbnailURL = book.volumeInfo.imageLinks?.thumbnail {
                                                
                                                self.fetchImageFromAPI(from: thumbnailURL) { 
                                                    
                                                    imageData in
                                                    
                                                    DispatchQueue.main.async {
                                                        if let imageData = imageData, let image = UIImage(data: imageData) {
                                                            
                                                            
                                                            book.volumeInfo.image = image
                                                            
                                                            self.bookList.items[bookIndex] = book
                                                            
                                                            
                                                        } else {
                                                            print(#function, "Failed to get image data for book with index \(bookIndex).")
                                                        }
                                                    }//Dispatch
                                                }//fetchDatafromApi
                                            } else {
                                                print(#function, "No JSON data of small thumbnail available for book with index \(bookIndex).")
                                            }//if-else
                                        }//GrabImageData
                                        
                                        DispatchQueue.main.async{
                                            self.bookList = decodedBook
                                        }//main-sync
                                        
                                    }
                                    
                                }else{
                                    print(#function, "No JSON data available.")
                                }//if..else
                                
                            }catch let error{
                                
                                print(#function, "Unable to decode data. Error: \(error)\n")
                                
                            }//do..catch
                            
                        }//dispatchQueue
                        
                        
                    }else{
                        print(#function, "Unable to receive response. httpResponse.statusCode : \(httpResponse.statusCode)\n")
                    }//if-200
                }else{
                    print(#function, "Unable to obtain HTTPResponse\n")
                }//if httpResponse not gotten
                
            }//if-else
        }//task
        task.resume()
    }//getBooks
    
    
    //it will escape once it is completed
    func fetchImageFromAPI(from url: URL, withCompletion completion : @escaping(Data?) -> Void){
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil){
                
                print(#function, "unable to connect to image hosting web server due to error: \(error)")
            }else{
                
                if let httpResponse = response as? HTTPURLResponse{
                    print(#function, "httpResponse: \(httpResponse)")
                    
                    if (httpResponse.statusCode == 200){
                        
                        if (data != nil){
                        
                            completion(data)
                            
                        }else{
                            print(#function, "No data from server response found.")
                        }//if-else data is not nil
                        
                    }else{
                        
                        print(#function, "HTTP response is not OK: \(httpResponse.statusCode).")
                        
                    }//if 200
                    
                }//if let httpResponse
            }//if-else
        })//lambda
        
        task.resume()
        
    }//fetchImageFromApi
    
}//bookManager
