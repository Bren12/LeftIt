//
//  HomeView.swift
//  LeftIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = GoalModel()
    
    @ObservedObject private var viewRecentBook = RecentBooksModel()
    
    @State var showSheet = false
    @State var showContinueSheet = false
    @State var bookGB = ""
    
    @Binding var selectedTab: Int
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.primaryWhite
                
                ScrollView {
                    
                    VStack {
                        
                        // MARK: Header
                        
                        Spacer()
                            .frame(height: 62.5)
                        
                        VStack {
                            
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
                            
                        } // -> VStack
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isHeader)
                        
                        GoalCard(viewModel: viewModel, showSheet: $showSheet)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        // MARK: Reading
                        
                        if viewModel.books == nil {
                            
                            VStack {
                                
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
                                
                            } // -> VStack
                            .accessibilityElement(children: .combine)
                            
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
                            .accessibilityLabel("Add book")
                            .accessibilityHint("Tap to add a new book that you are currently reading")
                            
                            Spacer()
                                .frame(height: 10)
                            
                        } else {
                            
                            HStack {
                                
                                Text("You are reading...")
                                    .foregroundStyle(.primaryBlack)
                                    .font(.system(size: 20, weight: .semibold))
                                    .accessibilityAddTraits(.isHeader)
                                
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
                                .accessibilityAddTraits(.isHeader)
                            
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
