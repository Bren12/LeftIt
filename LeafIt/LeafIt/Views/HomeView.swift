//
//  HomeView.swift
//  LeftIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewRecentBook = RecentBooksModel()
    
    @State var showSheet = false
    @State var showContinueSheet = false
    @State var bookGB = ""
    
    @State var bookSaved = false // HARDCORE
    
    @Binding var selectedTab: Int
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.primaryWhite
                
                ScrollView {
                    
                    VStack {
                        
                        Spacer()
                            .frame(height: 62.5)
                        
                        // MARK: DEFAULT GREETING
                        HStack {
                            
                            Text("It's great to see you,")
                                .foregroundStyle(.primaryGray)
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                        } // -> HStack
                        
                        // MARK: GREETING USER
                        HStack {
                            
                            Text("\(readerUser)")
                                .foregroundStyle(.primaryBlack)
                                .font(.system(size: 20, weight: .semibold))
                            
                            Spacer()
                            
                        } // -> HStack
                        
                        // MARK: GOALCARD
                        GoalCard(showSheet: $showSheet)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        // MARK: READING
                        if !bookSaved {

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
                                    .accessibilityAddTraits(.isHeader)
                                
                                Spacer()
                                
                            }
                            .frame(width: 350)
                            
                            HStack {
                                
                                Spacer()
                                
//                                Carousel(viewModel: CarouselStoreModel(bookList: viewModel.books ?? []), observedModel: viewModel, showSheet: $showContinueSheet, bookGB: $bookGB)
                                
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
        
                                            } // -> NavigationLink

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
                    .padding(.horizontal)
                    
                } // -> ScrollView
                .scrollIndicators(.hidden)
                
            } // -> ZStack
            .ignoresSafeArea()
            .sheet(isPresented: $showSheet) { // MARK: SHEET
                GoalSheetView(showSheet: $showSheet)
                    .presentationDetents([.medium])
            } // -> sheet
            .sheet(isPresented: $showContinueSheet) { // MARK: SHEET
                ContinueReadingSheetView(showSheet: $showContinueSheet, bookGB: $bookGB)
                    .presentationDetents([.medium])
            } // -> sheet
            
        } // -> NavigationStack
        
    } // -> body
    
} // -> HomeView

#Preview {
    HomeView(selectedTab: .constant(0))
} // -> Preview
