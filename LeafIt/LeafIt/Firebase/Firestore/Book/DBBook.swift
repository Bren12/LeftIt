//
//  DBList.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import Foundation

struct DBBook: Codable {
    let userId: String
    var bookId: String?
    let bookGb: String
    var listId: [String]
    let title: String?
    let authors: [String]?
    let pages: Int?
    let readPages: Int?
    let progress: Int?
    let completed: Bool?
    let dateCreated: Date?
    let photoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case bookId = "book_id"
        case bookGb = "book_gb"
        case listId = "list_id"
        case title = "title"
        case authors = "authors"
        case pages = "pages"
        case readPages = "read_pages"
        case progress = "progress"
        case completed = "completed"
        case dateCreated = "date_created"
        case photoUrl = "photo_url"
    } // -> enum
    
    init(
        userId: String,
        bookId: String? = nil,
        bookGb: String,
        listId: [String],
        title: String? = nil,
        authors: [String]? = nil,
        pages: Int? = nil,
        readPages: Int? = nil,
        progress: Int? = nil,
        completed: Bool? = nil,
        dateCreated: Date? = nil,
        photoUrl: String? = nil
    ) {
        self.userId = userId
        self.bookId = bookId
        self.bookGb = bookGb
        self.listId = listId
        self.title = title
        self.authors = authors
        self.pages = pages
        self.readPages = readPages
        self.progress = progress
        self.completed = completed
        self.dateCreated = dateCreated
        self.photoUrl = photoUrl
    } // -> init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.bookId = try container.decodeIfPresent(String.self, forKey: .bookId)
        self.bookGb = try container.decode(String.self, forKey: .bookGb)
        self.listId = try container.decode([String].self, forKey: .listId)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.authors = try container.decodeIfPresent([String].self, forKey: .authors)
        self.pages = try container.decodeIfPresent(Int.self, forKey: .pages)
        self.readPages = try container.decodeIfPresent(Int.self, forKey: .readPages)
        self.progress = try container.decodeIfPresent(Int.self, forKey: .progress)
        self.completed = try container.decodeIfPresent(Bool.self, forKey: .completed)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
    } // -> Decoder
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.bookId, forKey: .bookId)
        try container.encode(self.bookGb, forKey: .bookGb)
        try container.encode(self.listId, forKey: .listId)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.authors, forKey: .authors)
        try container.encodeIfPresent(self.pages, forKey: .pages)
        try container.encodeIfPresent(self.readPages, forKey: .readPages)
        try container.encodeIfPresent(self.progress, forKey: .progress)
        try container.encodeIfPresent(self.completed, forKey: .completed)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
    } // -> Encoder
    
} // -> DBList
