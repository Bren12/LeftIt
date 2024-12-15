//
//  ExploreView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 10/12/24.
//

import SwiftUI

struct ExploreView: View {
    
    @ObservedObject private var viewModel = BookSearchModel()
    
    @StateObject var storeCarImg = StoreCarImg()
    
    @State private var search: String = ""
    @State private var startSearch: Bool = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.primaryWhite
            
                VStack {
                    
                    Spacer()
                        .frame(height: 62.5)
                    
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
                                
                                TextField("Search...", text: $viewModel.searchQuery)
                                    .foregroundStyle(.primaryBlack)
                                    .focused($isFocused)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .onSubmit {
                                        startSearch = viewModel.searchQuery != ""
                                        if startSearch {
                                            viewModel.searchBook()
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
                            
                            Image(systemName: "line.3.horizontal.decrease")
                                .foregroundStyle(.accent)
                                .frame(width: 12, height: 12)
                            
                        } // -> Button
                        
                    } // -> HStack
                    
                    if !startSearch {
                        
                        Spacer()
                        
                        Image(.searchBook)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .padding()
                        
                        Text("Start discovering new worlds!")
                            .foregroundStyle(.terciaryGray)
                            .font(.system(size: 20, weight: .bold))
                        
                        Text("Search for books.")
                            .foregroundStyle(.terciaryGray)
                            .font(.system(size: 15, weight: .medium))
                        
                        Spacer()
                        
                    } else {
                        
                        HStack {
                            
                            Text("\(viewModel.books.count) results")
                                .foregroundStyle(.primaryGray)
                                .font(.system(size: 10, weight: .regular))
                            
                            Spacer()
                            
                        } // -> HStack
                        .padding(.top, 7.5)
                        
                        SearchResult(books: $viewModel.books, viewModel: viewModel)
                        
                        Spacer()
                            .frame(height: 120)
                        
                    } // -> if-else
                    
                } // -> VStack
                .frame(width: 350)
                
            } // -> ZStack
            .ignoresSafeArea()
            .onAppear {
                isFocused = true
            } // -> onAppear
            .onTapGesture {
                isFocused = false
            } // -> onTapGesture
            
        } // -> NavigationVStack
        
    } // -> body
    
} // -> ExploreView

#Preview {
    ExploreView()
} // -> Preview
