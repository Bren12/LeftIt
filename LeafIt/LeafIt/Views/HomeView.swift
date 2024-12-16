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
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        print(authDataResult)
        self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
    } // -> loadCurrentUser
    
    func getCurrGoal() async throws {
        guard let user else { return }
        Task {
            self.readGoal = try await ReadingGoalManager.shared.getCurrGoal(forUserId: user.userId)
        }
    } // -> getCurrGoal
    
    func createGoal(read: Int, goal: Int, period: Period) {
        guard let user else { return }
        Task {
            try await ReadingGoalManager.shared.createGoal(user: user.userId, read: read, goal: goal, period: period)
            self.readGoal = try await ReadingGoalManager.shared.getCurrGoal(forUserId: user.userId)
        }
    } // -> createGoal
    
    func updateGoal(read: Int, goal: Int, period: Period) {
        guard let readGoal, let goalId = readGoal.goalId else { return }
        Task {
            try await ReadingGoalManager.shared.updateGoal(goalID: goalId, read: read, goal: goal, period: period)
            self.readGoal = try await ReadingGoalManager.shared.getGoal(goalID: goalId)
        }
    } // -> updateGoal
    
    func deleteGoal(read: Int, goal: Int, period: Period) {
        guard let readGoal, let goalId = readGoal.goalId else { return }
        Task {
            try await ReadingGoalManager.shared.deleteGoal(goalID: goalId)
            self.readGoal = nil
        }
    } // -> deleteGoal
    
} // -> LibraryModel

// MARK: HomeView

struct HomeView: View {
    
    @StateObject private var viewModel = GoalModel()
    
    @State private var periodSelected: String = Period.month.rawValue
    @State private var readBook: String = ""
    @State private var goalBook: String = ""
    @State var showSheet = false
    
    
    @StateObject var storeCarImg = StoreCarImg()
    var imgSet = ["book1", "book2", "book3"]
    
    var body: some View {
        
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
                    
                    HStack {
                        
                        Text("You are reading...")
                            .foregroundStyle(.primaryBlack)
                            .font(.system(size: 20, weight: .semibold))
                        
                        Spacer()
                        
                    }
                    .frame(width: 350)
                    
                    HStack {
                        
                        Spacer()
                        
                        Carousel()
                        
                        Spacer()
                        
                    } // -> HStack
                    
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
                            
                            ForEach(storeCarImg.img) { img in
                                
                                VStack {
                                    
                                    Button {
                                        // ACTION
                                    } label: {
                                        
                                        Image(img.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 150)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                            ) // -> clipShape
                                        
                                    } // -> Button
                                    
                                    Text("Name of book \(img.id)")
                                        .foregroundStyle(.primaryBlack)
                                        .font(.system(size: 15, weight: .medium))
                                        .frame(width: 100)
                                    
                                    Text("Author of book \(img.id)")
                                        .foregroundStyle(.primaryBlack)
                                        .font(.system(size: 10, weight: .regular))
                                        .frame(width: 100)
                                    
                                } // -> VStack
                                
                            } // -> ForEach
                            
                        } // -> HStack
                        
                    } // -> ScrollView
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    // MARK: Recommendations 2
                    
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
                            
                            ForEach(storeCarImg.img) { img in
                                
                                VStack {
                                    
                                    Button {
                                        //
                                    } label: {
                                        
                                        Image(img.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 150)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                            ) // -> clipShape
                                        
                                    } // -> Button
                                    
                                    Text("Name of book \(img.id)")
                                        .foregroundStyle(.primaryBlack)
                                        .font(.system(size: 15, weight: .medium))
                                        .frame(width: 100)
                                    
                                    Text("Author of book \(img.id)")
                                        .foregroundStyle(.primaryBlack)
                                        .font(.system(size: 10, weight: .regular))
                                        .frame(width: 100)
                                    
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
        .task {
            try? await viewModel.loadCurrentUser()
            try? await viewModel.getCurrGoal()
        }
        .sheet(isPresented: $showSheet) {
            
            // MARK: SHEET
            
            ZStack {
                
                VStack {
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("📚 Goal Progress 📚")
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 25, weight: .bold))
                    
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        
                        Text("Time lapse")
                            .foregroundStyle(.primaryBlack)
                            .font(.system(size: 15, weight: .bold))
                        
                        Spacer()
                        
                    } // -> HStack
                    
                    HStack {
                        
                        ForEach(Period.allCases, id: \.self) { period in
                            
                            Button {
                                periodSelected = period.rawValue
                            } label: {
                                
                                ZStack {
                                    
                                    if periodSelected == period.rawValue {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundStyle(.accent)
                                            .frame(width: 100, height: 27)
                                    } else {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.accent, lineWidth: 1)
                                            .frame(width: 100, height: 27)
                                    }
                                    
                                    Text("\(period.rawValue)")
                                        .foregroundStyle(periodSelected == period.rawValue ? .primaryWhite : .accent)
                                        .font(.system(size: 12, weight: .regular))
                                    
                                } // -> ZStack
                                
                            } // -> Button
                            
                        } // -> ForEach
                        
                        Spacer()
                        
                    } // -> HStack
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        
                        Text("Books read this year")
                            .foregroundStyle(.primaryBlack)
                            .font(.system(size: 15, weight: .bold))
                        
                        Spacer()
                        
                    } // -> HStack
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondaryGray, lineWidth: 1)
                            .frame(height: 27)
                        
                        HStack {
                            
                            Spacer()
                                .frame(width: 10)
                            
                            TextField("Ex. 2", text: $readBook)
                                .foregroundStyle(.primaryBlack)
                                .keyboardType(.numberPad)
                                .onChange(of: readBook) { newValue in
                                    readBook = newValue.filter { $0.isNumber }
                                } // -> onChange
                            
                        } // -> HStack
                        
                    } // -> ZStack
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        
                        Text("Year goal of books to read")
                            .foregroundStyle(.primaryBlack)
                            .font(.system(size: 15, weight: .bold))
                        
                        Spacer()
                        
                    } // -> HStack
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondaryGray, lineWidth: 1)
                            .frame(height: 27)
                        
                        HStack {
                            
                            Spacer()
                                .frame(width: 10)
                            
                            TextField("Ex. 9", text: $goalBook)
                                .foregroundStyle(.primaryBlack)
                                .keyboardType(.numberPad)
                                .onChange(of: goalBook) { newValue in
                                    goalBook = newValue.filter { $0.isNumber }
                                } // -> onChange
                            
                        } // -> HStack
                        
                    } // -> ZStack
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        
                        if let readInt = Int(readBook), let goalInt = Int(goalBook), let periodEnum = Period(rawValue: periodSelected), goalInt != 0, readInt <= goalInt {
                            
                            if viewModel.readGoal == nil {
                                viewModel.createGoal(read: readInt, goal: goalInt, period: periodEnum)
                            } else {
                                viewModel.updateGoal(read: readInt, goal: goalInt, period: periodEnum)
                            } // -> if-else
                            
                        } // -> if
                        
                    } label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.accent)
                                .frame(height: 40)
                            
                            Text("Set Goal")
                                .foregroundStyle(.primaryWhite)
                                .font(.system(size: 15, weight: .semibold))
                            
                        } // -> ZStack
                        
                    } // -> Button
                    
                    Spacer()
                    
                } // -> VStack
                .frame(width: 350)
                
            } // -> ZStack
            .presentationDetents([.medium,.large])
            
        } // -> sheet
        
    } // -> body
    
} // -> HomeView

#Preview {
    HomeView()
} // -> Preview
