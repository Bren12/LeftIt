//
//  DBList.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import Foundation

struct DBList: Codable {
    let userId: String
    var listId: String?
    var name: String?
    let photoUrl: String?
    let dateCreated: Date?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case listId = "list_id"
        case name = "name"
        case photoUrl = "photo_rl"
        case dateCreated = "date_created"
    } // -> enum
    
//    init(auth: AuthDataResultModel) {
//        self.userId = auth.uid
//        self.listId = auth.uid // CHANGE
//        self.photoUrl = auth.photoUrl // CHANGE
//        self.dateCreated = Date()
//    } // -> init
    
    init(
        userId: String,
        listId: String? = nil,
        name: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil
    ) {
        self.userId = userId
        self.listId = listId
        self.name = name
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
    } // -> init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.listId = try container.decodeIfPresent(String.self, forKey: .listId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.listId, forKey: .listId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
    }
    
} // -> DBList


//struct DBListAux: Codable {
//    let userId: String
//    var listId: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case userId = "user_id"
//        case listId = "list_id"
//    } // -> enum
//    
//    init(
//        userId: String,
//        listId: String? = nil
//    ) {
//        self.userId = userId
//        self.listId = listId
//    } // -> init
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.userId = try container.decode(String.self, forKey: .userId)
//        self.listId = try container.decodeIfPresent(String.self, forKey: .listId)
//    }
//        
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.userId, forKey: .userId)
//        try container.encodeIfPresent(self.listId, forKey: .listId)
//    }
//}
