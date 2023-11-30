// Melissa Munoz / Eli - 991642239


import Foundation

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
    var id: String // Assuming BookItem has its own ID
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
    var industryIdentifiers: [IndustryIdentifiers]
    var categories: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case publisher
        case description
        case industryIdentifiers
        case categories
    }
    
    init(title: String, authors: [String], publisher: String, description: String, industryIdentifiers: [IndustryIdentifiers], categories: [String]?) {
        self.title = title
        self.authors = authors
        self.publisher = publisher
        self.description = description
        self.industryIdentifiers = industryIdentifiers
        self.categories = categories
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "NA"
        self.authors = try container.decodeIfPresent([String].self, forKey: .authors) ?? []
        self.publisher = try container.decodeIfPresent(String.self, forKey: .publisher) ?? "NA"
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "NA"
        self.industryIdentifiers = try container.decodeIfPresent([IndustryIdentifiers].self, forKey: .industryIdentifiers) ?? [IndustryIdentifiers]()
        self.categories = try container.decodeIfPresent([String].self, forKey: .categories)
    }
    
    init() {
        self.title = ""
        self.authors = []
        self.publisher = ""
        self.description = ""
        self.industryIdentifiers = []
        self.categories = []
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


