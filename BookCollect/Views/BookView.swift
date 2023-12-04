//
//  BookView.swift
//  BookCollect
//
//  Created by Kyelle on 2023-12-04.
//

import SwiftUI

struct BookView: View {
    
    let book : Book
    
    var body: some View {
        VStack {
            
            if let bookImage = book.volumeInfo.image {
                Image(uiImage: bookImage)
                //                                            .resizable()
                //                                            .aspectRatio(contentMode: .fit)
                //                                            .frame(width: 300, height: 100)
                //                                            .padding()
            } else {
                Text("No image available")
                    .padding()
            }
            
            LabeledContent {
                Text("\(book.volumeInfo.title)")
            } label: {
                Text("Title:")
            }
            
            LabeledContent {
                Text("\(book.volumeInfo.authors.joined(separator: ", "))")
            } label: {
                Text("Author:")
            }
            
            LabeledContent {
                if let categories = book.volumeInfo.categories {
                    Text("\(categories.joined(separator: ", "))")
                } else {
                    Text("No categories available")
                }
            } label: {
                Text("Categories:")
            }
            
            LabeledContent {
                if let firstIndustryIdentifier = book.volumeInfo.industryIdentifiers.first {
                    Text("\(firstIndustryIdentifier.identifier)")
                        .font(.caption)
                } else {
                    Text("No identifier available")
                }
            } label: {
                Text("ISBN:")
            }
            
            LabeledContent {
                Text("\(book.volumeInfo.averageRating?.description ?? "??") / 5 stars")
            } label: {
                Text("Rating")
            }
            
            Text("\(book.volumeInfo.description)")
                .lineLimit(3)
            
        }//VStack
    }
}

//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookView()
//    }
//}
