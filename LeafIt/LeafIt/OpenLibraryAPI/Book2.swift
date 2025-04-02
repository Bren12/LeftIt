//
//  Book.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 14/12/24.
//

import Foundation

struct BookSearchResponse2: Codable {
    let num_found: Int
    let docs: [Book2]?
} // ->

struct Book2: Codable {
    
    let author_name: [String]?
    let cover_i: Int?
    let key: String
    let title: String
    
    init(
        author_name: [String]? = nil,
        cover_i: Int? = nil,
        key: String,
        title: String
    ) {
        self.author_name = author_name
        self.cover_i = cover_i
        self.key = key
        self.title = title
    } // -> init
    
} // ->
