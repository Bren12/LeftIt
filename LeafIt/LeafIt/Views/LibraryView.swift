//
//  LibraryView.swift
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

struct LibraryView: View {
    
    @State private var search: String = ""
    @State private var startSearch: Bool = false
    @State private var inputText: String = ""
    @State private var showBookView: Bool = false
    @State private var showSheet: Bool = false
    
    @StateObject private var viewModel = LibraryModel()
    
    @FocusState private var isFocused: Bool
    
    let rows = [
        GridItem(.flexible(), spacing: 50),
        GridItem(.flexible(), spacing: 50)
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.primaryWhite
            
                VStack {
                    
                    Spacer()
                        .frame(height: 62.5)
                    
                    // MARK: SEARCH BAR
                    
                    HStack {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                                .frame(height: 32.5)
                            
                            HStack {
                                
                                Spacer()
                                    .frame(width: 10)
                                
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.terciaryGray)
                                    .frame(width: 12, height: 12)
                                
                                TextField("Search...", text: $search)
                                    .foregroundStyle(.primaryBlack)
                                    .focused($isFocused)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .onSubmit {
                                        startSearch = search != ""
                                        if startSearch {
                                            //
                                        } // -> if
                                    } // -> onSubmit
                                
                            } // -> HStack
                            
                        } // -> ZStack
                        .onTapGesture {
                            isFocused = true
                        } // -> onTapGesture
                        
                        Spacer()
                            .frame(width: 20)
                        
                        Button {
                            
                            // Action
                            
                        } label: {
                            
                            Image(systemName: "book.closed.fill")
                                .foregroundStyle(.accent)
                                .frame(width: 12, height: 12)
                            
                        } // -> Button
                        
                    } // -> HStack
                    
                    // MARK: SEARCH Function
                    
                    if !startSearch {
                        
                        Spacer()
                        
                        HStack {
                            
                            Text("\((viewModel.lists ?? []).count) lists")
                                .foregroundStyle(.primaryGray)
                                .font(.system(size: 10, weight: .regular))
                            
                            Spacer()
                            
                        } // -> HStack
                        .padding(.top, 7.5)
                        
                        if let lists = viewModel.lists {
                            
                            ScrollView {
                                
                                LazyVGrid(columns: rows, spacing: 20) {
                                    
                                    // MARK: LISTS
                                    
                                    ForEach(lists, id: \.listId) { list in
                                        
                                        NavigationLink {
                                            
                                            BookListView(listID: list.listId!, listName: list.name!)
                                            
                                        } label: {
                                            
                                            ZStack {
                                                
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 160, height: 160)
                                                    .foregroundStyle(.accent)
                                                
                                                VStack {
                                                    
                                                    Text("\(list.name ?? "Loading...")")
                                                        .foregroundStyle(.primaryWhite)
                                                        .font(.system(size: 20, weight: .bold))
                                                    
                                                } // -> VStack
                                                
                                            } // -> ZStack
                                            
                                        } // -> NavigationLink
                                        
                                    } // -> ForEach
                                    
                                } // -> LazyVGrid
                                .padding(.horizontal)
                                
                            } // -> ScrollView
                            .scrollIndicators(.hidden)
                            
                        }
                        
                    } else {
                        
                        
                        Spacer()
                        
                        
                    } // -> if-else
                    
                } // -> VStack
                .frame(width: 350)
                
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.accentColor)
                                .background(.primaryWhite)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .padding(.trailing, 20)
                                .padding(.bottom, 100)
                        } // -> Button
                        
                    } // -> HStack
                    
                } // -> VStack
                .zIndex(1)
                
            } // -> ZStack
            .ignoresSafeArea()
            .onAppear {
                isFocused = true
            } // -> onAppear
            .onTapGesture {
                isFocused = false
            } // -> onTapGesture
            
        } // -> NavigationVStack
        .task {
            try? await viewModel.loadCurrentUser()
            try? await viewModel.loadCurrentLists()
        } // task
        .sheet(isPresented: $showSheet) {
            ListSheetView(observedModel: viewModel, showSheet: $showSheet)
                .presentationDetents([.fraction(0.3)])
        }
        
    } // -> body
    
} // -> LibraryView

#Preview {
    LibraryView()
} // -> Preview
