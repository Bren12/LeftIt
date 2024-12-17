//
//  ListManager.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import Foundation
import FirebaseFirestore

final class BookManager {
    
    // MARK: Constants
    
    static let shared = BookManager()
    
    private init() {}
    
    
    
    // MARK: Collection
    
    private let bookCollection = Firestore.firestore().collection("book")
    
    
    
    // MARK: Spcecific Book Document
    
    private func bookDocument(bookID: String) -> DocumentReference {
        return bookCollection.document(bookID)
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
    
    
    
    // MARK: Create Book
    
    func createNewBook(user: String, bookGB: Book, list: [String], pages: Int, readPages: Int, completed: Bool) async throws {
        guard let volume = bookGB.volumeInfo else { return }
        var book = DBBook(
            userId: user,
            bookGb: bookGB.id,
            listId: list,
            title: volume.title,
            authors: volume.authors,
            pages: volume.pageCount,
            readPages: readPages,
            progress: (readPages*100)/pages,
            completed: completed,
            dateCreated: Date(),
            photoUrl: volume.imageLinks?.thumbnail?.replacingOccurrences(of: "http://", with: "https://")
        ) // -> book
        let newDocumentRef = try bookCollection.addDocument(from: book)
        book.bookId = newDocumentRef.documentID
        try newDocumentRef.setData(from: book, merge: false)
    } // -> createNewBook
    
    
    
    // MARK: Get Book
    
    func getBook(bookID: String) async throws -> DBBook? {
        let document = try await bookDocument(bookID: bookID).getDocument()
        guard let book = try? document.data(as: DBBook.self) else {
            return nil
        } // -> guard
        return book
    } // -> getBook
    
    
    
    // MARK: Get Books from List

    func getBooksDefaultList(forUserID: String) async throws -> [DBBook] {
        let listID = try await ListManager.shared.getDefaultList(forUserId: forUserID)
        let snapshot = try await bookCollection
            .whereField(DBList.CodingKeys.userId.rawValue, isEqualTo: forUserID)
            .whereField(DBList.CodingKeys.listId.rawValue, isEqualTo: listID)
            .getDocuments()
        let books = snapshot.documents.compactMap { document -> DBBook? in
            try? document.data(as: DBBook.self, decoder: decoder)
        } // -> book
        return books
    } // -> getBookDefaultList
    
    
    
    // MARK: Get Books from List

    func getBooksList(forListId: String) async throws -> [DBBook] {
        let snapshot = try await bookCollection
            .whereField(DBList.CodingKeys.listId.rawValue, isEqualTo: forListId)
            .getDocuments()
        let books = snapshot.documents.compactMap { document -> DBBook? in
            try? document.data(as: DBBook.self, decoder: decoder)
        } // -> book
        return books
    } // -> getBookList
    
    
    
    // MARK: Update Book List

    func addBookList(forBookId: String, list: String) async throws {
        let data: [String: Any] = [
            DBBook.CodingKeys.listId.rawValue: FieldValue.arrayUnion([list]),
        ] // -> data
        try await bookDocument(bookID: forBookId).updateData(data)
    } // -> addBookList
    
    func removeBookList(forBookId: String, list: String) async throws {
        let data: [String: Any] = [
            DBBook.CodingKeys.listId.rawValue: FieldValue.arrayRemove([list]),
        ] // -> data
        try await bookDocument(bookID: forBookId).updateData(data)
    } // -> removeBookList
    
    
    
    // MARK: Update Book Completed
    
    func updateBookCompleted(forBookId: String, isCompleted: Bool) async throws {
        let data: [String: Any] = [
            DBBook.CodingKeys.completed.rawValue: isCompleted,
        ] // -> data
        try await bookDocument(bookID: forBookId).updateData(data)
    } // -> updateBookCompleted
    
    
    
    // MARK: Update Book Read Pages
    
    func updateBookReadPages(forBookId: String, readPages: Int) async throws {
        guard let book = try await getBook(bookID: forBookId), let pages = book.pages else { return }
        let data: [String: Any] = [
            DBBook.CodingKeys.readPages.rawValue: readPages,
            DBBook.CodingKeys.progress.rawValue: (readPages*100)/(pages),
        ] // -> data
        try await bookDocument(bookID: forBookId).updateData(data)
    } // -> updateBookCompleted
    
} // -> ListManager




















// MARK: VIEW Book Array

//    private func preferenceSelected(text: String) -> Bool {
//        return viewModel.user?.preference?.contains(text) == true
//    } // preferenceSelected

//    ForEach(preferenceOptions, id: \.self) { str in
//
//        Button(str) {
//            if preferenceSelected(text: str) {
//                viewModel.removeUserPreference(text: str)
//            } else {
//                viewModel.addUserPreference(text: str)
//            }
//        } // Button
//        .font(.headline)
//        .buttonStyle(.borderedProminent)
//        .tint(preferenceSelected(text: str) ? .green : .red)
//
//    }

// MARK: MODEL Book Array

//    func addUserPreference(text: String) {
//        guard let user else { return }
//        Task {
//            try await UserManager.shared.addUserPreference(userID: user.userId, preference: text)
//            self.user = try await UserManager.shared.getUser(userID: user.userId)
//        } // -> Task
//    } // -> addUserPreference
//
//    func removeUserPreference(text: String) {
//        guard let user else { return }
//        Task {
//            try await UserManager.shared.removeUserPreference(userID: user.userId, preference: text)
//            self.user = try await UserManager.shared.getUser(userID: user.userId)
//        } // -> Task
//    } // -> removeUserPreference

// MARK: MODEL Book Bool

//    func togglePremiumStatus() {
//        guard let user else { return }
//        let currValue = user.isPremium ?? false
//        Task {
//            try await UserManager.shared.updateUserPremiumStatus(userID: user.userId, isPremium: !currValue)
//            self.user = try await UserManager.shared.getUser(userID: user.userId)
//        } // -> Task
//    } // -> loadCurrentUser