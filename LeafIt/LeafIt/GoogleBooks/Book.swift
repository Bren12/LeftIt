//
//  Book.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 14/12/24.
//

import Foundation

struct BookSearchResponse: Codable {
    let totalItems: Int
    let items: [Book]?
}

struct Book: Codable, Identifiable {
    let id: String
    let volumeInfo: VolumeInfo?
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let averageRating: Float?
    let ratingsCount: Int?
    let categories: [String]?
    let maturityRating: String?
    let imageLinks: ImageLinks?
    let language: String?
    
    init(title: String,
         subtitle: String? = nil,
         authors: [String]? = nil,
         publisher: String? = nil,
         publishedDate: String? = nil,
         description: String? = nil,
         pageCount: Int? = nil,
         averageRating: Float? = nil,
         ratingsCount: Int? = nil,
         categories: [String]? = nil,
         maturityRating: String? = nil,
         imageLinks: ImageLinks? = nil,
         language: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.description = description
        self.pageCount = pageCount
        self.averageRating = averageRating
        self.ratingsCount = ratingsCount
        self.categories = categories
        self.maturityRating = maturityRating
        self.imageLinks = imageLinks
        self.language = language
    }
}

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
    
    init(
        smallThumbnail: String? = nil,
         thumbnail: String? = nil
    ) {
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
    }
}

struct SampleBook {
    let sampleBook = Book(id: "LkaYzQEACAAJ", volumeInfo: VolumeInfo(title: "Meghan and Harry - The Real Story", subtitle: "The Real Story", authors: ["Lady Colin Campbell","Jack Boss Reacher"], publisher: nil, publishedDate: "2020-06-25", description: "The fall from popular grace of the previously adulated brother of the heir to the British throne as a consequence of his marriage to a beautiful and dynamic Hollywood starlet of colour makes for fascinating reading in best-selling royal author Lady Colin Campbell's balanced account. Lady Colin knows her royal history and psychology, and as the first seven years of her adult life were spent in the USA she has a foot in both the American and British camps. With unique breadth of insight she goes behind the scenes, speaking to friends, relations, courtiers, and colleagues on both sides of the Atlantic to reveal the most unexpected royal story since the Abdication. She highlights the dilemmas involved and the issues that lurk beneath the surface, as to why the couple decided to step down as senior royals. She analyses the implications of the actions of a young and ambitious couple, in love with each other and with the empowering lure of fame and fortune. She leads the reader through the maze of contradictions, revealing how Californian culture has influenced the couple's conduct. She exposes how they tried and failed to change the royal system by adapting it to their own needs and ambitions, and, upon failing, how they decided to create a new system altogether.", pageCount: 411, averageRating: 3, ratingsCount: 2, categories: nil, maturityRating: nil, imageLinks: ImageLinks(smallThumbnail: "http://books.google.com/books/content?id=_68eEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api", thumbnail: "https://books.google.com/books?id=zyTCAlFPjgYC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"), language: "en"))
    
}
