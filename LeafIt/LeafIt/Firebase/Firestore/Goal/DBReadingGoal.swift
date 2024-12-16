//
//  DBGoal.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import Foundation

struct DBReadingGoal: Codable {
    let userId: String
    var goalId: String?
    let bookRead: Int?
    let bookGoal: Int?
    let period: Period?
    let dateCreated: Date?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case goalId = "goal_id"
        case bookRead = "book_read"
        case bookGoal = "book_goal"
        case period = "period"
        case dateCreated = "date_created"
    } // -> CodingKeys
    
    init(
        userId: String,
        goalId: String? = nil,
        bookRead: Int? = nil,
        bookGoal: Int? = nil,
        period: Period? = nil,
        dateCreated: Date? = nil
    ) {
        self.userId = userId
        self.goalId = goalId
        self.bookRead = bookRead
        self.bookGoal = bookGoal
        self.period = period
        self.dateCreated = dateCreated
    } // -> init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.goalId = try container.decodeIfPresent(String.self, forKey: .goalId)
        self.bookRead = try container.decodeIfPresent(Int.self, forKey: .bookRead)
        self.bookGoal = try container.decodeIfPresent(Int.self, forKey: .bookGoal)
        self.period = try container.decodeIfPresent(Period.self, forKey: .period)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
    } // -> Decoder
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.goalId, forKey: .goalId)
        try container.encodeIfPresent(self.bookRead, forKey: .bookRead)
        try container.encodeIfPresent(self.bookGoal, forKey: .bookGoal)
        try container.encodeIfPresent(self.period, forKey: .period)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
    } // -> Encode
    
    func progressPercentage() -> Double {
        return ( Double(bookRead ?? 0) / Double(bookGoal ?? 0) ) * 100
    } // -> progressPercentage
    
} // -> DBReadingGoal

enum Period: String, Decodable, Encodable, CaseIterable {
    case month = "Month"
    case year = "Year"
} // -> Period
