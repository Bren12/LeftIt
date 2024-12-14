//
//  UserManager.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 13/12/24.
//

import Foundation
import FirebaseFirestore

final class UserManager {
    
    static let shared = UserManager()
    
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("user")
    
    
    
    private func userDocument(userID: String) -> DocumentReference {
        return userCollection.document(userID)
    } // -> userDocument
    
    
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }() // -> encoder
    
    
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }() // -> decoder
    
    
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userID: user.userId).setData(from: user, merge: false, encoder: encoder)
    } // -> createNewUser
    
    
    
//    func createNewUser(auth: AuthDataResultModel) async throws {
//        
//        var userData: [String: Any] = [
//            "user_id": auth.uid,
//            "is_anonymous": auth.isAnonymous,
//            "date_created": Timestamp()
//        ] // -> userData
//        
//        if let email = auth.email {
//            userData["email"] = email
//        } // -> if
//        
//        if let photoUrl = auth.photoUrl {
//            userData["photo_url"] = photoUrl
//        } // -> if
//        
//        try await userDocument(userID: auth.uid).setData(userData, merge: false)
//    } // -> createNewUser
    
    
    
    func getUser(userID: String) async throws -> DBUser {
        try await userDocument(userID: userID).getDocument(as: DBUser.self, decoder: decoder)
    } // -> getUser
    
    
    
//    func getUser(userID: String) async throws -> DBUser {
//        
//        let snapshot = try await userDocument(userID: userID).getDocument()
//        
//        guard let data = snapshot.data(), let user_id = data["user_id"] as? String else {
//            throw URLError(.badServerResponse)
//        } // -> guard
//        
//        let isAnonymous = data["is_anonymous"] as? Bool
//        let email = data["email"] as? String
//        let photoUrl = data["photo_url"] as? String
//        let dateCreated = data["date_created"] as? Date
//        
//        return DBUser(userID: user_id, isAnonymous: isAnonymous, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
//    } // -> getUser
    
    
    
//    func updateUserPremiumStatus(user: DBUser) async throws {
//        try userDocument(userID: user.userId).setData(from: user, merge: true, encoder: encoder)
//    } // -> updateUserPremiumStatus
    
    
    
    func updateUserPremiumStatus(userID: String, isPremium: Bool) async throws {
        let data: [String: Any] = [
            "is_premium": isPremium
        ] // -> data
        try await userDocument(userID: userID).updateData(data)
    } // -> updateUserPremiumStatus
    
} // -> UserManager
