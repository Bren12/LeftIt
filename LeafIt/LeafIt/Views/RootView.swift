//
//  RootView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 13/12/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showHomeView: Bool = false
    @State private var isTransitioning: Bool = false
    
    var body: some View {
        
        ZStack {
            
            CoverView()
                .opacity(isTransitioning ? 0 : 1)
            
            if showHomeView {
                TabBar()
                    .transition(.opacity)
                    .opacity(isTransitioning ? 1 : 0)
            } // -> if
            
        } // -> ZStack
        .ignoresSafeArea()
        .onAppear {
            
            // After a brief delay, start the fading effect
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isTransitioning = true
                } // -> withAnimation
            } // -> DispatchQueue
            
            // After the fading effect, show the second view
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    showHomeView = true
                } // -> withAnimation
            } // -> DispatchQueue
            
        } // -> onAppear
        
    } // -> body
    
} // -> RootView

#Preview {
    RootView()
} // -> Preview
