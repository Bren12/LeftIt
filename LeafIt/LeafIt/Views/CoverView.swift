//
//  CoverView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 13/12/24.
//

import SwiftUI

struct CoverView: View {
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.accent, .primaryPink]), startPoint: .top, endPoint: .bottom)
            
            VStack {
                
                Spacer()
                
                Image(.logoApp)
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                Text("Leaf It")
                    .foregroundStyle(.primaryWhite)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 50)
                
            } // -> VStack
            .frame(width: 200)
            
        } // -> ZStack
        .ignoresSafeArea()
        
    } // -> body
    
} // -> CoverView

#Preview {
    CoverView()
} // -> Preview
