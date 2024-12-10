//
//  HomeView.swift
//  LeftIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var storeCarImg = StoreCarImg()
    
    var imgSet = ["book1", "book2", "book3"]
    
    var body: some View {
        
        ZStack {
            
            Color.primaryWhite
            
            ScrollView {
                
                VStack {
                    
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
                        
                        Text("Dmitriy Smoljaninov")
                            .foregroundStyle(.primaryBlack)
                            .font(.system(size: 20, weight: .semibold))
                        
                        Spacer()
                        
                    } // -> HStack
                    .frame(width: 350)
                    
                    GoalCard()
                    
                    Spacer()
                        .frame(height: 30)
                    
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
                    
                    Spacer()
                        .frame(height: 30)
                    
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
                    
                    Spacer()
                        .frame(height: 100)
                    
                } // -> VStack
                
            } // -> ScrollView
            
        } // -> ZStack
        .ignoresSafeArea()
        
    } // -> body
    
} // -> HomeView

#Preview {
    HomeView()
} // -> Preview
