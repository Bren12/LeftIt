//
//  SplashView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 10/12/24.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        
            VStack {
                
                NavigationLink {
                    
                    SignInEmailView(showSignInView: $showSignInView)
                    
                } label: {
                
                    Text("Sign In With Email")
                        .font(.headline)
                        .foregroundColor (.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                    
                } // -> NavigationLink
                
                Spacer()
                
            } // -> VStack
            .padding()
            .navigationTitle("Sign In")
        
    } // -> body
    
} // -> SplashView

#Preview {
    NavigationStack {
        SplashView(showSignInView: .constant(false))
    } // NavigationStack
} // -> Preview
