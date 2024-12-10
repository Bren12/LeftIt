//
//  ExploreView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 10/12/24.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var storeCarImg = StoreCarImg()
    
    let rows = [
        GridItem(.flexible(), spacing: 50),
        GridItem(.flexible(), spacing: 50),
        GridItem(.flexible(), spacing: 50)
    ]
    
    @State private var search: String = ""
    @State private var startSearch: Bool = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
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
                            
                            TextField("Search...", text: $search)
                                .focused($isFocused)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .onSubmit {
                                    startSearch = search == "" ? false : true
                                }
                            
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
                    
                    Text("Search for books or authors.")
                        .foregroundStyle(.terciaryGray)
                        .font(.system(size: 15, weight: .medium))
                    
                    Spacer()
                    
                } else {
                    
                    HStack {
                        
                        Text("10 results")
                            .foregroundStyle(.primaryGray)
                            .font(.system(size: 10, weight: .regular))
                        
                        Spacer()
                        
                    } // -> HStack
                    .padding(.top, 7.5)
                    
                    ScrollView {
                                        
                        LazyVGrid(columns: rows, spacing: 20) {
                            /////////////////////////////////////////////////////// CHANGE LOGIC HERE ///////////////////////////////////////////////////////
                            ForEach(storeCarImg.img, id: \.id) { book in
                                
                                Image(book.image)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 10)
                                    ) // -> clipShape
                                    .frame(width: 100, height: 150)
                                
                            } // -> ForEach
                            
                        } // -> LazyVGrid
                        .padding(.horizontal)
                        
                    } // -> ScrollView
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                    
                } // -> if-else
                
            } // -> VStack
            .frame(width: 350)
            
        } // -> ZStack
        .ignoresSafeArea()
        .onAppear {
            isFocused = true
        }
        .onTapGesture {
            isFocused = false
        }
        
    } // -> body
    
} // -> ExploreView

#Preview {
    ExploreView()
} // -> Preview
