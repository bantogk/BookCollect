// Melissa Munoz / Eli - 991642239


import Foundation

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
                                        
                                        dump(decodedBook)
                                        
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
    }
}
