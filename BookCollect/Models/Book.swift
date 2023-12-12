// Melissa Munoz / Eli - 991642239


import Foundation
import UIKit

struct Books: Identifiable, Codable {
    var id: String?
    var items: [BookItem]

    enum CodingKeys: String, CodingKey {
//        case id
        case items
    }

    init(id: String, items: [BookItem]) {
//        self.id = id
        self.items = items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
        self.items = try container.decode([BookItem].self, forKey: .items)
    }
    
    init() {
        self.id = ""
        self.items = []
    }
}

struct BookItem: Identifiable, Codable {
    var id: String
    var volumeInfo: VolumeInfo

    enum CodingKeys: String, CodingKey {
        case id
        case volumeInfo
    }

    init(id: String, volumeInfo: VolumeInfo) {
        self.id = id
        self.volumeInfo = volumeInfo
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? "NA"
        self.volumeInfo = try container.decodeIfPresent(VolumeInfo.self, forKey: .volumeInfo) ?? VolumeInfo()
    }
    
    init() {
        self.id = ""
        self.volumeInfo = VolumeInfo()
    }
}

struct VolumeInfo: Codable {
    var title: String
    var authors: [String]
    var publisher: String?
    var description: String
    var averageRating: Float?
    var ratingsCount: Int?
    var industryIdentifiers: [IndustryIdentifiers]
    var categories: [String]?
    
    var language: String?
    var pageCount: Int?
    var publishedDate: String?
    
    var imageLinks : ImageLinks?
    var image : UIImage?
    

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case publisher
        case description
        case averageRating
        case ratingsCount
        case industryIdentifiers
        case categories
        case imageLinks
        case language
        case pageCount
        case publishedDate
    }
    
//    init(title: String, authors: [String], publisher: String, description: String, industryIdentifiers: [IndustryIdentifiers], categories: [String]?, averageRating: Float, ratingsCount: Int, imageLinks: ImageLinks) {
//        self.title = title
//        self.authors = authors
//        self.publisher = publisher
//        self.description = description
//        self.ratingsCount = ratingsCount
//        self.averageRating = averageRating
//        self.industryIdentifiers = industryIdentifiers
//        self.categories = categories
//        self.imageLinks = imageLinks
//    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "NA"
        self.authors = try container.decodeIfPresent([String].self, forKey: .authors) ?? []
        self.publisher = try container.decodeIfPresent(String.self, forKey: .publisher) ?? "NA"
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "NA"
        self.averageRating = try container.decodeIfPresent(Float.self, forKey: .averageRating) ?? 0.0
        self.ratingsCount = try container.decodeIfPresent(Int.self, forKey: .ratingsCount) ?? 0
        self.industryIdentifiers = try container.decodeIfPresent([IndustryIdentifiers].self, forKey: .industryIdentifiers) ?? [IndustryIdentifiers]()
        self.categories = try container.decodeIfPresent([String].self, forKey: .categories)
        self.imageLinks = try container.decodeIfPresent(ImageLinks.self, forKey: .imageLinks)
        self.language = try container.decodeIfPresent(String.self, forKey: .language) ?? "NA"
        self.pageCount = try container.decodeIfPresent(Int.self, forKey: .pageCount) ?? 0
        self.publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate) ?? "NA"
    }
    
    init() {
        self.title = ""
        self.authors = []
        self.publisher = ""
        self.description = ""
        self.averageRating = 0.0
        self.ratingsCount = 0
        self.industryIdentifiers = []
        self.categories = []
        self.language = ""
        self.pageCount = 0
        self.publishedDate = ""
    }
}

struct IndustryIdentifiers: Codable {
    var type: String
    var identifier: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case identifier
    }
    
    init(type: String, identifier: String) {
        self.type = type
        self.identifier = identifier
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? "NA"
        self.identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? "NA"
    }
    
    init() {
        self.type = ""
        self.identifier = ""
    }
}

struct ImageLinks: Codable {
    var smallThumbnail: URL?
    var thumbnail: URL?

    enum CodingKeys: String, CodingKey {
        case smallThumbnail
        case thumbnail
    }
    
    init(smallThumbnail: String, thumbnail: String) {
        self.smallThumbnail = URL(string:"")
        self.thumbnail = URL(string:"")
    }
}


