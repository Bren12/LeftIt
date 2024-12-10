//
//  ExploreView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 10/12/24.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var search: String = ""
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
                            
                        }
                    }
                    .onTapGesture {
                        isFocused = true
                    }
                    
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
