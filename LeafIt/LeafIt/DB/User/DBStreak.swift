//
//  DBStreak.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 02/04/25.
//

import Foundation
import SwiftData

@Model
class DBStreak: Identifiable {
    var streakId: UUID = UUID()
    var streak: Int
    var streakLastDay: Date?

    init(
        streak: Int = 0,
        streakLastDay: Date?
    ) {
        self.streak = streak
        self.streakLastDay = streakLastDay
    } // -> init
} // -> DBStreak
