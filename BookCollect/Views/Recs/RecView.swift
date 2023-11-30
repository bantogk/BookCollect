// Melissa Munoz / Eli - 991642239


import SwiftUI

struct RecView: View {
    
    @State private var category : String = "adventure"
    @EnvironmentObject var bookManager : BookManager

    @State private var bookList : [Books] = [Books]()
    
    var body: some View {
        
        ZStack{
            VStack{
                Text("I heard you like \(category)")
                    .font(.title)
                Text("Here are some recommendations you might like...")
                    .font(.caption)
                
                if(self.bookManager.bookList.items.isEmpty){
                    Text("No data received from API")
                }else{
                    
                    List(self.bookManager.bookList.items){book in
                        VStack(){
                            
                            LabeledContent{
                                Text("\(book.volumeInfo.title)")
                                    .font(.caption)
                            }label:{
                                Text("Title:")
                            }
                            
                            LabeledContent{
                                
                                Text("\(book.volumeInfo.authors.joined(separator: ", "))")
                                    .font(.caption)
                            }label:{
                                Text("Author:")
                            }
                            
                            LabeledContent{
                                
                                if let categories = book.volumeInfo.categories {
                                    Text("\(categories.joined(separator: ", "))")
                                } else {
                                    Text("No categories available")
                                }

                            }label:{
                                Text("Categories:")
                            }
                            
                            
                            LabeledContent{
                                if let firstIndustryIdentifier = book.volumeInfo.industryIdentifiers.first {
                                    Text("\(firstIndustryIdentifier.identifier)")
                                } else {
                                    Text("No identifier available")
                                }
                            }label:{
                                Text("ISBN:")
                            }
                            
                            LabeledContent{
                                Text("\(book.volumeInfo.description)")
                                    .font(.caption)
                            }label:{
                                Text("Description")
                            }
                        }//VStack
                    }//List
                }//if-else
            }//VStack
            .onAppear(){
                
                bookManager.getBooks(category: category)
                
            }//OnAppear
            
//            Button(action: <#T##() -> Void#>, label: <#T##() -> View#>)
            
        }//ZStack
    }//body
}//View

//#Preview {
//    RecView()
//}
