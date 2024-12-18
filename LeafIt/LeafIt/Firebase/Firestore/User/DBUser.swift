//
//  DBUser.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 13/12/24.
//

import Foundation

struct Movie: Codable {
    let id: String
    let title: String
    let isPopular: Bool
} // Movie

struct DBUser: Codable {
    let userId: String
    let nickname: String?
    let isAnonymous: Bool?
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    var streak: Int?
    let streakLastDay: Date?
    let readToday: Bool?
    let isPremium: Bool?
    let preference: [String]?
    let favoriteMovie: Movie?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nickname = "nickname"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case streak = "streak"
        case streakLastDay = "streak_last_day"
        case readToday = "read_today"
        case isPremium = "is_premium"
        case preference = "preference"
        case favoriteMovie = "favorete_movie"
    } // -> enum
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.nickname = "Leaf Reader"
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.streak = 0
        self.streakLastDay = Date()
        self.readToday = false
        self.isPremium = false
        self.preference = nil
        self.favoriteMovie = nil
    } // -> init
    
    init(
        userId: String,
        nickname: String? = nil,
        isAnonymous: Bool? = nil,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        streak: Int? = nil,
        streakLastDay: Date? = nil,
        readToday: Bool? = nil,
        isPremium: Bool? = nil,
        preference: [String]? = nil,
        favoriteMovie: Movie? = nil
    ) {
        self.userId = userId
        self.nickname = nickname
        self.isAnonymous = isAnonymous
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.streak = streak
        self.streakLastDay = streakLastDay
        self.readToday = readToday
        self.isPremium = isPremium
        self.preference = preference
        self.favoriteMovie = favoriteMovie
    } // -> init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.streak = try container.decodeIfPresent(Int.self, forKey: .streak)
        self.streakLastDay = try container.decodeIfPresent(Date.self, forKey: .streakLastDay)
        self.readToday = try container.decodeIfPresent(Bool.self, forKey: .readToday)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.preference = try container.decodeIfPresent([String].self, forKey: .preference)
        self.favoriteMovie = try container.decodeIfPresent(Movie.self, forKey: .favoriteMovie)
    } // -> Decoder
    
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.nickname, forKey: .nickname)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.streak, forKey: .streak)
        try container.encodeIfPresent(self.streakLastDay, forKey: .streakLastDay)
        try container.encodeIfPresent(self.readToday, forKey: .readToday)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.preference, forKey: .preference)
        try container.encodeIfPresent(self.favoriteMovie, forKey: .favoriteMovie)
    } // -> Encoder
    
    
    
} // -> DBUser
