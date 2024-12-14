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
//        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }() // -> encoder



    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }() // -> decoder
    
    
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userID: user.userId).setData(from: user, merge: false)
    } // -> createNewUser
    
    
    
    func getUser(userID: String) async throws -> DBUser {
        try await userDocument(userID: userID).getDocument(as: DBUser.self)
    } // -> getUser
    
    
        
    func updateUserPremiumStatus(userID: String, isPremium: Bool) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.isPremium.rawValue: isPremium,
        ] // -> data
        try await userDocument(userID: userID).updateData(data)
    } // -> updateUserPremiumStatus
    
    
    
    func addUserPreference(userID: String, preference: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.preference.rawValue: FieldValue.arrayUnion([preference]),
        ] // -> data
        try await userDocument(userID: userID).updateData(data)
    } // -> addUserPreference
    
    
    
    func removeUserPreference(userID: String, preference: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.preference.rawValue: FieldValue.arrayRemove([preference]),
        ] // -> data
        try await userDocument(userID: userID).updateData(data)
    } // -> addUserPreference
    
    
    
    func addFavoriteMovie(userID: String, movie: Movie) async throws {
        guard let data = try? encoder.encode(movie) else {
            throw URLError(.badURL)
        }
        let dict: [String: Any] = [
            DBUser.CodingKeys.favoriteMovie.rawValue: data,
        ] // -> data
        try await userDocument(userID: userID).updateData(dict)
    } // -> addUserPreference
    
    
    
    func removeFavoriteMovie(userID: String) async throws {
        let data: [String: Any?] = [
            DBUser.CodingKeys.favoriteMovie.rawValue: nil
        ] // -> data
        try await userDocument(userID: userID).updateData(data as [AnyHashable: Any])
    } // -> addUserPreference
    
} // -> UserManager
