//
//  DBGoal.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 02/04/25.
//

import Foundation
import SwiftData

@Model
class DBGoal: Identifiable {
    var goalId: UUID = UUID()
    var dateCreated: Date
    var bookRead: Int
    var bookGoal: Int
    var period: Period

    init(
        dateCreated: Date = .now,
        bookRead: Int,
        bookGoal: Int,
        period: Period
    ) {
        self.dateCreated = dateCreated
        self.bookRead = bookRead
        self.bookGoal = bookGoal
        self.period = period
    } // -> inist
} // -> DBGoal
