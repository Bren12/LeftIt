//
//  ListManager.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import Foundation
import FirebaseFirestore

final class ReadingGoalManager {
    
    // MARK: Constants
    
    static let shared = ReadingGoalManager()
    
    private init() {}
    
    
    
    // MARK: Collection
    
    private let goalCollection = Firestore.firestore().collection("reading_goal")
    
    
    
    // MARK: Spcecific Reading Goal Document
    
    private func goalDocument(goalID: String) -> DocumentReference {
        return goalCollection.document(goalID)
    } // -> goalDocument
    
    
    
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
    
    func createGoal(user: String, read: Int, goal: Int, period: Period) async throws {
        var goal = DBReadingGoal(userId: user, bookRead: read, bookGoal: goal, period: period, dateCreated: Date())
        let newDocumentRef = try goalCollection.addDocument(from: goal)
        goal.goalId = newDocumentRef.documentID
        try newDocumentRef.setData(from: goal, merge: false)
    } // -> createGoal
    
    
    
    // MARK: Get Goal
    
    func getGoal(goalID: String) async throws -> DBReadingGoal? {
        try await goalDocument(goalID: goalID).getDocument(as: DBReadingGoal.self)
    } // -> getGoal
    
    func getCurrGoal(forUserId: String) async throws -> DBReadingGoal? {
        
        let currDate = Date()
        let calendar = Calendar.current
        
        let currYear = calendar.component(.year, from: currDate)
        let currMonth = calendar.component(.month, from: currDate)
        
        let snapshot = try await goalCollection
            .whereField(DBReadingGoal.CodingKeys.userId.rawValue, isEqualTo: forUserId)
            .getDocuments()
        
        let goals = snapshot.documents.compactMap { document -> DBReadingGoal? in
            
            guard let goal = try? document.data(as: DBReadingGoal.self) else {
                return nil
            } // -> goal
            
            guard let dateCreated = goal.dateCreated else {
                return nil
            } // -> dateCreated
            
            let goalYear = calendar.component(.year, from: dateCreated)
            let goalMonth = calendar.component(.month, from: dateCreated)
            
            if (goalYear == currYear) && (goalMonth == currMonth) {
                return goal
            } // -> if
            
            return nil
            
        } // -> goals
        
        return goals.sorted { $0.dateCreated ?? Date.distantPast > $1.dateCreated ?? Date.distantPast }.first
                
    } // -> getCurrGoal
    
    
    
    // MARK: Update Goal
    
    func updateGoal(goalID: String, read: Int, goal: Int, period: Period) async throws {
        let data: [String: Any] = [
            DBReadingGoal.CodingKeys.bookGoal.rawValue: goal,
            DBReadingGoal.CodingKeys.bookRead.rawValue: read,
            DBReadingGoal.CodingKeys.period.rawValue: period.rawValue,
        ] // -> data
        try await goalDocument(goalID: goalID).updateData(data)
    } // -> updateGoal
    
    
    
    // MARK: Delete Goal
    
    func deleteGoal(goalID: String) async throws {
        try await goalDocument(goalID: goalID).delete()
    } // -> deleteGoal
    
} // -> ReadingGoalManager
