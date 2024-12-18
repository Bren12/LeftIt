//
//  BookSheetView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 16/12/24.
//

import SwiftUI

@MainActor
final class ContinueReadingModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var book: DBBook? = nil
    
    @Published var pages: String = ""
    @Published var readPages: String = ""
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
    } // -> loadCurrentUser
    
    func loadCurrentBook(bookGB: String) async throws {
        guard let user else { return }
        self.book = try await BookManager.shared.getBookUser(fromUser: user.userId, fromBookGB: bookGB)
        guard let book else { return }
        guard let readPages = book.readPages else { return }
        self.readPages = "\(readPages)"
        guard let pages = book.pages else { return }
        self.pages = "\(pages)"
    } // -> loadCurrentUser
    
    func applyChanges(bookGB: String) async throws {
        guard let readInt = Int(readPages), let pagesInt = Int(pages), readInt <= pagesInt else { return }
        guard let book, let bookID = book.bookId else { return }
        try await BookManager.shared.updateReadingBook(forBookId: bookID, pages: pagesInt, readPages: readInt)
        try await loadCurrentBook(bookGB: bookGB)
    }
    
} // -> ContinueReadingModel

struct ContinueReadingSheetView: View {
    
    @ObservedObject private var viewModel = ContinueReadingModel()
    
    @ObservedObject var observedModel: GoalModel
    
    @Binding var showSheet: Bool
    @Binding var bookGB: String
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                    .frame(height: 30)
                
                // MARK: TITLE
                
                if let title = viewModel.book?.title {
                    Text("📚 \(title) 📚")
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 25, weight: .bold))
                } else {
                    Text("📚 Update Progress 📚")
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 25, weight: .bold))
                }
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                // MARK: PAGES
                
                HStack {
                    
                    Text("Number of pages")
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
                        
                        TextField("Ex. 420", text: $viewModel.pages)
                            .foregroundStyle(.primaryBlack)
                            .keyboardType(.numberPad)
                            .onChange(of: viewModel.pages) { newValue in
                                viewModel.pages = newValue.filter { $0.isNumber }
                            } // -> onChange
                        
                    } // -> HStack
                    
                } // -> ZStack
                
                Spacer()
                    .frame(height: 20)
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                // MARK: PAGES READ
                
                HStack {
                    
                    Text("Number of pages read")
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
                        
                        TextField("Ex. 2", text: $viewModel.readPages)
                            .foregroundStyle(.primaryBlack)
                            .keyboardType(.numberPad)
                            .onChange(of: viewModel.readPages) { newValue in
                                viewModel.readPages = newValue.filter { $0.isNumber }
                            } // -> onChange
                        
                    } // -> HStack
                    
                } // -> ZStack
                
                Spacer()
                    .frame(height: 20)
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                // MARK: BUTTON
                
                HStack {
                
                    Button {
                        
                        if let pagesInt = Int(viewModel.pages), let pagesReadInt = Int(viewModel.readPages), pagesReadInt <= pagesInt {
                            Task {
                                try await viewModel.applyChanges(bookGB: bookGB)
                                try await observedModel.registerReading()
                            } // --> Task
                            showSheet.toggle()
                        } // -> if
                        
                    } label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.accent)
                                .frame(height: 40)
                            
                            Text("Update")
                                .foregroundStyle(.primaryWhite)
                                .font(.system(size: 15, weight: .semibold))
                            
                        } // -> ZStack
                        
                    } // -> Button
                    
                } // -> HStack
                
                Spacer()
                
            } // -> VStack
            .frame(width: 350)
            
        } // -> ZStack
        .task {
            try? await viewModel.loadCurrentUser()
            try? await viewModel.loadCurrentBook(bookGB: bookGB)
        }
        
    } // -> body
    
} // -> ContinueReadingSheetView

#Preview {
    ContinueReadingSheetView(observedModel: GoalModel(), showSheet: .constant(true), bookGB: .constant(""))
} // -> Preview
