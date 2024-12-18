//
//  BookSheetView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 16/12/24.
//

import SwiftUI

//@MainActor
//final class BookModel: ObservableObject {
//    
//    @Published private(set) var user: DBUser? = nil
//    @Published private(set) var lists: [DBList]? = []
//    @Published private(set) var book: DBBook? = nil
//    
//    @Published var pages: String = ""
//    @Published var readPages: String = ""
//    @Published var isOnList: [String] = []
//    @Published var isCompleted: Bool = false
//    
//    func loadCurrentUser() async throws {
//        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//        self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
//    } // -> loadCurrentUser
//    
//    func loadCurrentLists() async throws {
//        guard let user else { return }
//        self.lists = try await ListManager.shared.getLists(forUserId: user.userId)
//    } // -> loadCurrentUser
//    
//    func loadCurrentBook(bookGB: String) async throws {
//        guard let user else { return }
//        self.book = try await BookManager.shared.getBookUser(fromUser: user.userId, fromBookGB: bookGB)
//        guard let book else {
//            print("A new book needs to be created")
//            return
//        } // -> book
//        print("book already exists")
//        guard let readPages = book.readPages else { return }
//        self.readPages = "\(readPages)"
//        guard let pages = book.pages else { return }
//        self.pages = "\(pages)"
//        guard let completed = book.completed else { return }
//        self.isCompleted = completed
//        guard let listsIDs = book.listId else { return }
//        self.isOnList = listsIDs
//    } // -> loadCurrentUser
//    
//    func listSelected(listID: String) -> Bool {
//        return self.isOnList.contains(listID) == true
//    } // -> listSelected
//    
//    func toggleListSelection(listID: String) {
//        if listSelected(listID: listID) {
//            if let index = isOnList.firstIndex(of: listID) {
//                isOnList.remove(at: index)
//            } // -> index
//        } else {
//            isOnList.append(listID)
//        } // -> if-else
//    } // -> toggleListSelection
//    
//    func applyChanges(bookGB: Book) async throws {
//        guard let user else { return }
//        guard let readInt = Int(readPages), let pagesInt = Int(pages), readInt <= pagesInt else { return }
//        guard let book, let bookID = book.bookId else {
//            try await BookManager.shared.createNewBook(user: user.userId, bookGB: bookGB, list: isOnList, pages: pagesInt, readPages: readInt, completed: isCompleted)
//            try await loadCurrentBook(bookGB: bookGB.id)
//            return
//        } // -> book
//        try await BookManager.shared.updateBook(forBookId: bookID, list: isOnList, pages: pagesInt, readPages: readInt, isCompleted: isCompleted)
//        try await loadCurrentBook(bookGB: bookGB.id)
//    }
//    
//} // -> LibraryModel

//struct ListSheetView: View {
//    
//    @ObservedObject private var viewModel = BookModel()
//    
//    @Binding var showSheet: Bool
//    
//    var book: Book
//    
//    private var pages: Int { book.volumeInfo?.pageCount ?? 0}
//    private var bookID: String { book.id }
//    
//    let completedList: [String] = ["Uncompleted", "Completed"]
//    
//    var body: some View {
//        
//        ZStack {
//            
//            VStack {
//                
//                Spacer()
//                    .frame(height: 30)
//                
//                // MARK: TITLE
//                
//                Text("📚 Book to be saved 📚")
//                    .foregroundStyle(.primaryBlack)
//                    .font(.system(size: 25, weight: .bold))
//                
//                Divider()
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                // MARK: LISTS
//                
//                HStack {
//                    
//                    Text("Lists")
//                        .foregroundStyle(.primaryBlack)
//                        .font(.system(size: 15, weight: .bold))
//                    
//                    Spacer()
//                    
//                } // -> HStack
//                    
//                ForEach(viewModel.lists ?? [], id: \.listId) { list in
//                    
//                    HStack {
//                        
//                        if let listName = list.name, let listID = list.listId {
//                            
//                            Button {
//                                viewModel.toggleListSelection(listID: listID)
//                            } label: {
//                                
//                                ZStack {
//                                    
//                                    RoundedRectangle(cornerRadius: 5)
//                                        .fill(viewModel.listSelected(listID: listID) ? .accent : Color.secondaryGray)
//                                        .frame(width: 30, height: 30)
//                                    
//                                    if viewModel.listSelected(listID: listID) {
//                                        Image(systemName: "checkmark")
//                                            .foregroundColor(.primaryWhite)
//                                            .font(.title3)
//                                    } // -> if
//                                    
//                                } // -> ZStack
//                                
//                            } // -> Button
//                            .buttonStyle(PlainButtonStyle())
//                            
//                            Text("\(listName)")
//                                .foregroundStyle(.primaryBlack)
//                                .font(.system(size: 15, weight: .regular))
//                            
//                            Spacer()
//                            
//                        } // if
//                        
//                    } // -> HStack
//                    
//                } // -> ForEach
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                Divider()
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                // MARK: PAGES
//                
//                HStack {
//                    
//                    Text("Number of pages")
//                        .foregroundStyle(.primaryBlack)
//                        .font(.system(size: 15, weight: .bold))
//                    
//                    Spacer()
//                    
//                } // -> HStack
//                
//                ZStack {
//                    
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke(.secondaryGray, lineWidth: 1)
//                        .frame(height: 27)
//                    
//                    HStack {
//                        
//                        Spacer()
//                            .frame(width: 10)
//                        
//                        TextField("Ex. 420", text: $viewModel.pages)
//                            .foregroundStyle(.primaryBlack)
//                            .keyboardType(.numberPad)
//                            .onChange(of: viewModel.pages) { newValue in
//                                viewModel.pages = newValue.filter { $0.isNumber }
//                            } // -> onChange
//                        
//                    } // -> HStack
//                    
//                } // -> ZStack
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                Divider()
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                // MARK: PAGES READ
//                
//                HStack {
//                    
//                    Text("Number of pages read")
//                        .foregroundStyle(.primaryBlack)
//                        .font(.system(size: 15, weight: .bold))
//                    
//                    Spacer()
//                    
//                } // -> HStack
//                
//                ZStack {
//                    
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke(.secondaryGray, lineWidth: 1)
//                        .frame(height: 27)
//                    
//                    HStack {
//                        
//                        Spacer()
//                            .frame(width: 10)
//                        
//                        TextField("Ex. 2", text: $viewModel.readPages)
//                            .foregroundStyle(.primaryBlack)
//                            .keyboardType(.numberPad)
//                            .onChange(of: viewModel.readPages) { newValue in
//                                viewModel.readPages = newValue.filter { $0.isNumber }
//                            } // -> onChange
//                        
//                    } // -> HStack
//                    
//                } // -> ZStack
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                Divider()
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                // MARK: COMPLETED
//                
//                HStack {
//                    
//                    Text("Read before")
//                        .foregroundStyle(.primaryBlack)
//                        .font(.system(size: 15, weight: .bold))
//                    
//                    Spacer()
//                    
//                } // -> HStack
//                
//                HStack {
//                    
//                    ForEach(completedList, id: \.self) { compText in
//                        
//                        Button {
//                            if (viewModel.isCompleted && compText == "Uncompleted") || (!viewModel.isCompleted && compText == "Completed") {
//                                viewModel.isCompleted.toggle()
//                            }
//                        } label: {
//                            
//                            ZStack {
//                                
//                                if (viewModel.isCompleted && compText == "Completed") || (!viewModel.isCompleted && compText == "Uncompleted") {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .foregroundStyle(.accent)
//                                        .frame(width: 100, height: 27)
//                                } else {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(.accent, lineWidth: 1)
//                                        .frame(width: 100, height: 27)
//                                }
//                                
//                                Text(compText)
//                                    .foregroundStyle((viewModel.isCompleted && compText == "Completed") || (!viewModel.isCompleted && compText == "Uncompleted") ? .primaryWhite : .accent)
//                                    .font(.system(size: 12, weight: .regular))
//                                
//                            } // -> ZStack
//                            
//                        } // -> Button
//                        
//                    }
//                    
//                    Spacer()
//                    
//                } // -> HStack
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                Divider()
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                // MARK: BUTTON
//                
//                HStack {
//                
//                    Button {
//                        
//                        if let pagesInt = Int(viewModel.pages), let pagesReadInt = Int(viewModel.readPages), pagesReadInt <= pagesInt {
//                            Task {
//                                print("Pages Read Int: \(pagesReadInt)")
//                                try await viewModel.applyChanges(bookGB: book)
//                            } // --> Task
//                            showSheet.toggle()
//                        } // -> if
//                        
//                    } label: {
//                        
//                        ZStack {
//                            
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundStyle(.accent)
//                                .frame(height: 40)
//                            
//                            Text("Apply")
//                                .foregroundStyle(.primaryWhite)
//                                .font(.system(size: 15, weight: .semibold))
//                            
//                        } // -> ZStack
//                        
//                    } // -> Button
//                    
//                } // -> HStack
//                
//                Spacer()
//                
//            } // -> VStack
//            .frame(width: 350)
//            
//        } // -> ZStack
//        .task {
//            try? await viewModel.loadCurrentUser()
//            try? await viewModel.loadCurrentLists()
//            try? await viewModel.loadCurrentBook(bookGB: book.id)
//            viewModel.pages = "\(pages)"
//        }
//        
//    } // -> body
//    
//} // -> GoalSheetView
//
//#Preview {
//    ListSheetView(showSheet: .constant(true), book: SampleBook().sampleBook)
//} // -> Preview
