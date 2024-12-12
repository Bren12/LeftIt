//
//  SignInEmailView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 11/12/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        
        guard !email.isEmpty, !password.isEmpty else {
            
            print("No email or password found.")
            return
            
        } // guard
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
        
    } // signUp
    
    func signIn() async throws {
        
        guard !email.isEmpty, !password.isEmpty else {
            
            print("No email or password found.")
            return
            
        } // guard
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
        
    } // signIn
    
    func signInAnonymous() async throws {
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    } // signInAnonymous
    
} // SignInEmailViewModel

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        
        VStack {
            
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(.secondaryGray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(.secondaryGray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                
                Task {
                    
                    do {
                        
                        try await viewModel.signUp()
                        print("Account Created")
                        showSignInView = false
                        return
                        
                    } catch {
                        
                        print(error)
                        
                    } // do-catch
                    
                    do {
                        
                        try await viewModel.signIn()
                        print("Signed In")
                        showSignInView = false
                        return
                    } catch {
                        
                        print(error)
                        
                    } // do-catch
                    
                } // Task
                
            } label: {
                
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor (.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            } // Button
            
            Spacer()
            
        } // VStack
        .padding()
        .navigationTitle("Sign In With Email")
        
    } // body
    
} // SignInEmailView

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    } // NavigationStack
} // Preview
