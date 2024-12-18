//
//  HomeView.swift
//  LeftIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

// MARK: GoalModel

@MainActor
final class GoalModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var readGoal: DBReadingGoal? = nil
    @Published private(set) var books: [DBBook]? = nil
    @Published private(set) var updatedStreak: Bool = false
    
    @Published var periodSelected: String = Period.month.rawValue
    @Published var readBook: String = ""
    @Published var goalBook: String = ""
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        print(authDataResult)
        self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
        guard let user, !updatedStreak else { return }
        let currentDate = Date()
        if !isYesterday(lastDate: user.streakLastDay!, currentDate: currentDate) && !isSameDay(lastDate: user.streakLastDay!, currentDate: currentDate) {
            print(currentDate)
            self.user?.streak = 0
        } // -> if
    } // -> loadCurrentUser
    
    func getCurrGoal() async throws {
        guard let user else { return }
        self.readGoal = try await ReadingGoalManager.shared.getCurrGoal(forUserId: user.userId)
        guard let readGoal else { return }
        guard let period = readGoal.period else { return }
        self.periodSelected = period.rawValue
        guard let readBook = readGoal.bookRead else { return }
        self.readBook = "\(readBook)"
        guard let goalBook = readGoal.bookGoal else { return }
        self.goalBook = "\(goalBook)"
    } // -> getCurrGoal
    
    func getCurrBooks() async throws {
        guard let user else { return }
        Task {
            self.books = try await BookManager.shared.getBooksDefaultList(forUserID: user.userId)
        }
    } // -> getCurrGoal
    
    func createGoal() {
        guard let user else { return }
        guard let readInt = Int(readBook), let goalInt = Int(goalBook), let periodEnum = Period(rawValue: periodSelected), goalInt != 0, readInt <= goalInt else { return }
        Task {
            try await ReadingGoalManager.shared.createGoal(user: user.userId, read: readInt, goal: goalInt, period: periodEnum)
            self.readGoal = try await ReadingGoalManager.shared.getCurrGoal(forUserId: user.userId)
        }
    } // -> createGoal
    
    func updateGoal() {
        guard let readGoal, let goalId = readGoal.goalId else { return }
        guard let readInt = Int(readBook), let goalInt = Int(goalBook), let periodEnum = Period(rawValue: periodSelected), goalInt != 0, readInt <= goalInt else { return }
        Task {
            try await ReadingGoalManager.shared.updateGoal(goalID: goalId, read: readInt, goal: goalInt, period: periodEnum)
            self.readGoal = try await ReadingGoalManager.shared.getGoal(goalID: goalId)
        }
    } // -> updateGoal
    
    func deleteGoal() {
        guard let readGoal, let goalId = readGoal.goalId else { return }
        Task {
            try await ReadingGoalManager.shared.deleteGoal(goalID: goalId)
            self.readGoal = nil
        }
    } // -> deleteGoal
    
    func registerReading() async throws {
        Task {
            try await getCurrBooks()
        }
        guard let user, var streak = user.streak, let lastStreak = user.streakLastDay else { return }
        let currentDate = Date()
        if isYesterday(lastDate: lastStreak, currentDate: currentDate) {
            streak += 1
        } else if isSameDay(lastDate: lastStreak, currentDate: currentDate) {
            return
        } else {
            streak = 1
        }
        Task {
            try await UserManager.shared.registerReading(userID: user.userId, streak: streak)
            if !self.updatedStreak {
                self.updatedStreak = true
                try await loadCurrentUser()
            }        }
    } // -> deleteGoal
    
    private func isSameDay(lastDate: Date, currentDate: Date) -> Bool {
        return Calendar.current.isDate(lastDate, inSameDayAs: currentDate)
    } // -> isSameDay

    private func isYesterday(lastDate: Date, currentDate: Date) -> Bool {
        return Calendar.current.isDate(lastDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!)
    } // -> isYesterday
    
} // -> LibraryModel

// MARK: HomeView

struct HomeView: View {
    
    @StateObject private var viewModel = GoalModel()
    
    @ObservedObject private var viewRecentBook = RecentBooksModel()
    
    @State var showSheet = false
    @State var showContinueSheet = false
    @State var bookGB = ""
    
    @Binding var selectedTab: Int
    
    var imgSet = ["book1", "book2", "book3"]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.primaryWhite
                
                ScrollView {
                    
                    VStack {
                        
                        // MARK: Header
                        
                        Spacer()
                            .frame(height: 62.5)
                        
                        HStack {
                            
                            Text("It's great to see you,")
                                .foregroundStyle(.primaryGray)
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                        } // -> HStack
                        .frame(width: 350)
                        
                        HStack {
                            
                            Text("\(viewModel.user?.nickname ?? readerUser)")
                                .foregroundStyle(.primaryBlack)
                                .font(.system(size: 20, weight: .semibold))
                            
                            Spacer()
                            
                        } // -> HStack
                        .frame(width: 350)
                        
                        GoalCard(viewModel: viewModel, showSheet: $showSheet)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        // MARK: Reading
                        
                        if viewModel.books == nil {
                            
                            Image(.magicBook)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                            
                            Spacer()
                                .frame(height: 15)
                            
                            Text("Let's start a new journey!")
                                .foregroundStyle(.gray)
                                .font(.system(size: 15, weight: .medium))
                            
                            Spacer()
                                .frame(height: 30)
                            
                            Button {
                                selectedTab =  1
                            } label: {
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(.accent)
                                        .frame(width: 120, height: 40)
                                    
                                    Text("Add book")
                                        .foregroundStyle(.primaryWhite)
                                        .font(.system(size: 15, weight: .semibold))
                                    
                                } // -> ZStack
                                
                            } // -> Button
                            
                            Spacer()
                                .frame(height: 10)
                            
                        } else {
                            
                            HStack {
                                
                                Text("You are reading...")
                                    .foregroundStyle(.primaryBlack)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Spacer()
                                
                            }
                            .frame(width: 350)
                            
                            HStack {
                                
                                Spacer()
                                
                                Carousel(viewModel: CarouselStoreModel(bookList: viewModel.books ?? []), observedModel: viewModel, showSheet: $showContinueSheet, bookGB: $bookGB)
                                
                                Spacer()
                                
                            } // -> HStack
                            
                        } // -> if-else
                        
                        Spacer()
                            .frame(height: 20)
                        
                        // MARK: Recommendations 1
                        
                        HStack {
                            
                            Text("Recently published")
                                .foregroundStyle(.primaryBlack)
                                .font(.system(size: 20, weight: .semibold))
                            
                            Spacer()
                            
                        }
                        .frame(width: 350)
                        
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 15) {
                                
                                Spacer()
                                
                                ForEach(viewRecentBook.books) { book in
        
                                        VStack {
        
                                            NavigationLink {
                                                BookView(book: book)
                                            } label: {
                                                
                                                ZStack {
                                                    
                                                    AsyncImage(url: URL(string: (book.volumeInfo?.imageLinks?.thumbnail ?? "").replacingOccurrences(of: "http://", with: "https://"))) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .clipShape(
                                                                RoundedRectangle(cornerRadius: 10)
                                                            ) // -> clipShape
                                                    } placeholder: {
                                                        ProgressView()
                                                    } // -> AsyncImage
                                                    
                                                }
                                                .frame(width: 100, height: 150)
        
                                            } // -> Button
        
                                            Text("\(book.volumeInfo?.title ?? "")")
                                                .foregroundStyle(.primaryBlack)
                                                .font(.system(size: 15, weight: .medium))
                                                .frame(width: 100, height: 19)
        
                                            Text("\((book.volumeInfo?.authors ?? []).joined(separator: ", "))")
                                                .foregroundStyle(.primaryBlack)
                                                .font(.system(size: 10, weight: .regular))
                                                .frame(width: 100, height: 25)
        
                                        } // -> VStack
                                
                                    } // -> ForEach
                                
                            } // -> HStack
                            
                        } // -> ScrollView
                        .scrollIndicators(.hidden)
                        
                        Spacer()
                            .frame(height: 100)
                        
                    } // -> VStack
                    
                } // -> ScrollView
                .scrollIndicators(.hidden)
                
            } // -> ZStack
            .ignoresSafeArea()
            .task { // MARK: TASK
                try? await viewModel.loadCurrentUser()
                try? await viewModel.getCurrGoal()
                try? await viewModel.getCurrBooks()
            }
            .sheet(isPresented: $showSheet) { // MARK: SHEET
                GoalSheetView(viewModel: viewModel, showSheet: $showSheet)
                    .presentationDetents([.medium])
            } // -> sheet
            .sheet(isPresented: $showContinueSheet) { // MARK: SHEET
                ContinueReadingSheetView(observedModel: viewModel, showSheet: $showContinueSheet, bookGB: $bookGB)
                    .presentationDetents([.medium])
            } // -> sheet
            
        } // -> NavigationStack
        
    } // -> body
    
} // -> HomeView

#Preview {
    HomeView(selectedTab: .constant(0))
} // -> Preview
