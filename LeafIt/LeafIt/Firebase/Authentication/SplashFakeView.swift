//
//  SplashFakeView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 10/12/24.
//

import SwiftUI

struct SplashFakeView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        
            VStack {
                
                Button {
                    
                    Task {
                        
                        do {
                            try await viewModel.signInAnonymous()
                            showSignInView = false
                        } catch {
                            print(error)
                        } // do-catch
                        
                    } // Task
                    
                } label: {
                
                    Text("Sign In Anonimously")
                        .font(.headline)
                        .foregroundColor (.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.accent)
                        .cornerRadius(10)
                    
                } // -> NavigationLink
                
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
        SplashFakeView(showSignInView: .constant(false))
    } // NavigationStack
} // -> Preview
