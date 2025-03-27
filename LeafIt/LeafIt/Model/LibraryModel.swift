//
//  LibraryModel.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 13/12/24.
//

import SwiftUI

@MainActor
final class LibraryModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var lists: [DBList]? = []
    @Published private(set) var books: [DBBook]? = nil
    @Published private(set) var booksGB: [Book]? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
    } // -> loadCurrentUser
    
    func loadCurrentLists() async throws {
        guard let user else { return }
        self.lists = try await ListManager.shared.getLists(forUserId: user.userId)
    } // -> loadCurrentUser
    
    func createList(name: String) {
        guard let user else { return }
        Task {
            try await ListManager.shared.createNewList(user: user.userId, name: name)
            self.lists = try await ListManager.shared.getLists(forUserId: user.userId)
        }
    } // -> createList
    
} // -> LibraryModel
