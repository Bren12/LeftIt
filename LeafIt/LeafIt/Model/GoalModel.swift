////
////  GoalModel.swift
////  LeafIt
////
////  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
////
//
//import SwiftUI
//
//@MainActor
//final class GoalModel: ObservableObject {
//    
//    @Published private(set) var user: DBUser? = nil
//    @Published private(set) var readGoal: DBReadingGoal? = nil
//    @Published private(set) var books: [DBBook]? = nil
//    @Published private(set) var updatedStreak: Bool = false
//    
//    @Published var periodSelected: String = Period.month.rawValue
//    @Published var readBook: String = ""
//    @Published var goalBook: String = ""
//    
//    func loadCurrentUser() async throws {
//        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//        print(authDataResult)
//        self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
//        guard let user, !updatedStreak else { return }
//        let currentDate = Date()
//        if !isYesterday(lastDate: user.streakLastDay!, currentDate: currentDate) && !isSameDay(lastDate: user.streakLastDay!, currentDate: currentDate) {
//            self.user?.streak = 0
//        } // -> if
//    } // -> loadCurrentUser
//    
//    func getCurrGoal() async throws {
//        guard let user else { return }
//        self.readGoal = try await ReadingGoalManager.shared.getCurrGoal(forUserId: user.userId)
//        guard let readGoal else { return }
//        guard let period = readGoal.period else { return }
//        self.periodSelected = period.rawValue
//        guard let readBook = readGoal.bookRead else { return }
//        self.readBook = "\(readBook)"
//        guard let goalBook = readGoal.bookGoal else { return }
//        self.goalBook = "\(goalBook)"
//    } // -> getCurrGoal
//    
//    func getCurrBooks() async throws {
//        guard let user else { return }
//        Task {
//            self.books = try await BookManager.shared.getBooksDefaultList(forUserID: user.userId)
//        }
//    } // -> getCurrGoal
//    
//    func createGoal() {
//        guard let user else { return }
//        guard let readInt = Int(readBook), let goalInt = Int(goalBook), let periodEnum = Period(rawValue: periodSelected), goalInt != 0, readInt <= goalInt else { return }
//        Task {
//            try await ReadingGoalManager.shared.createGoal(user: user.userId, read: readInt, goal: goalInt, period: periodEnum)
//            self.readGoal = try await ReadingGoalManager.shared.getCurrGoal(forUserId: user.userId)
//        }
//    } // -> createGoal
//    
//    func updateGoal() {
//        guard let readGoal, let goalId = readGoal.goalId else { return }
//        guard let readInt = Int(readBook), let goalInt = Int(goalBook), let periodEnum = Period(rawValue: periodSelected), goalInt != 0, readInt <= goalInt else { return }
//        Task {
//            try await ReadingGoalManager.shared.updateGoal(goalID: goalId, read: readInt, goal: goalInt, period: periodEnum)
//            self.readGoal = try await ReadingGoalManager.shared.getGoal(goalID: goalId)
//        }
//    } // -> updateGoal
//    
//    func deleteGoal() {
//        guard let readGoal, let goalId = readGoal.goalId else { return }
//        Task {
//            try await ReadingGoalManager.shared.deleteGoal(goalID: goalId)
//            self.readGoal = nil
//        }
//    } // -> deleteGoal
//    
//    func registerReading() async throws {
//        Task {
//            try await getCurrBooks()
//        }
//        guard let user, var streak = user.streak, let lastStreak = user.streakLastDay else { return }
//        let currentDate = Date()
//        if isYesterday(lastDate: lastStreak, currentDate: currentDate) {
//            streak += 1
//        } else if isSameDay(lastDate: lastStreak, currentDate: currentDate) {
//            return
//        } else {
//            streak = 1
//        }
//        Task {
//            try await UserManager.shared.registerReading(userID: user.userId, streak: streak)
//            if !self.updatedStreak {
//                self.updatedStreak = true
//                try await loadCurrentUser()
//            }        }
//    } // -> deleteGoal
//    
//    private func isSameDay(lastDate: Date, currentDate: Date) -> Bool {
//        return Calendar.current.isDate(lastDate, inSameDayAs: currentDate)
//    } // -> isSameDay
//
//    private func isYesterday(lastDate: Date, currentDate: Date) -> Bool {
//        return Calendar.current.isDate(lastDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!)
//    } // -> isYesterday
//    
//} // -> GoalModel
