//
//  SplashView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 10/12/24.
//

import SwiftUI

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInAnonymous() async throws {
        try await AuthenticationManager.shared.signInAnonymous()
//        let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
//        let user = DBUser(auth: authDataResult)
//        try await UserManager.shared.createNewUser(user: user)
    } // -> signInAnonymous

} // -> AuthenticationViewModel

struct SplashView: View {
    
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
        SplashView(showSignInView: .constant(false))
    } // NavigationStack
} // -> Preview
