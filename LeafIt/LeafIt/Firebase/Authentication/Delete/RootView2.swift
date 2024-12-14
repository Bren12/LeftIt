//
//  RootView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 11/12/24.
//

import SwiftUI

struct RootView2: View {
    
    @State private var showSplashView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            NavigationStack {
                
                ProfileView(showSignInView: $showSplashView)
                
            } // NavigationStack
            
        } // ZStack
        .onAppear {
            
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSplashView = authUser == nil
            
        } // onAppear
        .fullScreenCover(isPresented: $showSplashView) {
            
            NavigationStack {
                
                SplashFakeView(showSignInView: $showSplashView)
                
            } // NavigationStack
            
        } // fullScreenCover
        
    } // body
    
} // RootView

#Preview {
    RootView2()
} // Preview
