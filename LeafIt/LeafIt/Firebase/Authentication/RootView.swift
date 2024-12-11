//
//  RootView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 11/12/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            NavigationStack {
                
                SettingsView(showSignInView: $showSignInView)
                
            } // NavigationStack
            
        } // ZStack
        .onAppear {
            
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
            
        } // onAppear
        .fullScreenCover(isPresented: $showSignInView) {
            
            NavigationStack {
                
                SplashView(showSignInView: $showSignInView)
                
            } // NavigationStack
            
        } // fullScreenCover
        
    } // body
    
} // RootView

#Preview {
    RootView()
} // Preview
