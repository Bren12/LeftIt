//
//  ListManager.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import Foundation
import FirebaseFirestore

final class ListManager {
    
    // MARK: Constants
    
    static let shared = ListManager()
    
    private init() {}
    
    
    
    // MARK: Collection
    
    private let listCollection = Firestore.firestore().collection("list")
    
    
    
    // MARK: ???
    
    private func listDocument(listID: String) -> DocumentReference {
        return listCollection.document(listID)
    } // -> userDocument
    
    
    
    // MARK: Encoder/Decoder
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        return encoder
    }() // -> encoder

    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        return decoder
    }() // -> decoder
    
    
    
    // MARK: Create List
    
    func createDefaultList(user: String) async throws {
        var list = DBList(userId: user, name: "Now Reading", dateCreated: Date())
        let newDocumentRef = try listCollection.addDocument(from: list)
        list.listId = newDocumentRef.documentID
        try newDocumentRef.setData(from: list, merge: false)
    }
    
    func createNewList(user: String, name: String) async throws {
        var list = DBList(userId: user, name: name, dateCreated: Date())
        let newDocumentRef = try listCollection.addDocument(from: list)
        list.listId = newDocumentRef.documentID
        try newDocumentRef.setData(from: list, merge: false)
    }
    
    
    
    // MARK: Get List
    
    func getDefaultList(forUserId: String) async throws -> DBList {
        let snapshot = try await listCollection
            .whereField(DBList.CodingKeys.userId.rawValue, isEqualTo: forUserId)
            .whereField(DBList.CodingKeys.name.rawValue, isEqualTo: "Now Reading")
            .getDocuments()
        guard let document = snapshot.documents.first else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No document found for the specified criteria"])
        } // -> document
        do {
            let list = try document.data(as: DBList.self, decoder: decoder)
            return list
        } catch {
            throw NSError(domain: "FirestoreError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error decoding document data"])
        } // -> do-catch
    } // -> getDefaultList
    
    func getLists(forUserId: String) async throws -> [DBList] {
        let snapshot = try await listCollection
            .whereField(DBList.CodingKeys.userId.rawValue, isEqualTo: forUserId)
            .getDocuments()
        let lists = snapshot.documents.compactMap { document -> DBList? in
            try? document.data(as: DBList.self, decoder: decoder)
        } // -> lists
        return lists
    } // -> getLists
    
    func getList(listID: String) async throws -> DBList? {
        let document = try await listDocument(listID: listID).getDocument()
        guard let list = try? document.data(as: DBList.self) else {
            return nil
        } // -> list
        return list
    } // -> getList
    
    
} // -> ListManager
