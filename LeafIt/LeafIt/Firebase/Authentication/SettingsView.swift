//
//  SettingsView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 11/12/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadAuthProviders() {
        
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        } // if
        
    } // loadAuthProviders
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    } // loadAuthProviders
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    } // signOut
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    } // signOut
    
    func updateEmail() async throws {
        let email = "test123@hotmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    } // updateEmail
    
    func updatePassword() async throws {
        let password = "test123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    } // updatePassword
    
    func linkEmailAccount() async throws {
        let email = "test123@hotmail.com"
        let password = "test123"
        self.authUser = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    } // updatePassword
    
} // SettingsViewModel

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        
        List {
            
            Button("Log Out") {
                Task {
                    
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                    
                } // Task
                
            } // Button
            
            if viewModel.authProviders.contains(.email) {
                emailSection
            } // if
            
            if viewModel.authUser?.isAnonymous == true {
                anonymousSection
            } // if
            
        } // List
        .onAppear {
            viewModel.loadAuthUser()
        }
        .navigationBarTitle("Settings")
        
    } // body
    
} // SettingsView



extension SettingsView {
    
    private var emailSection: some View {
        
        Section {
            
            Button("Reset password") {
                Task {
                    
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                    
                } // Task
                
            } // Button
            
            Button("Update password") {
                Task {
                    
                    do {
                        try await viewModel.updatePassword()
                        print("Password Updated")
                    } catch {
                        print(error)
                    }
                    
                } // Task
                
            } // Button
            
            Button("Update email") {
                Task {
                    
                    do {
                        try await viewModel.updateEmail()
                        print("Email Updated")
                    } catch {
                        print(error)
                    }
                    
                } // Task
                
            } // Button
            
        } header: {
            Text("Email Functions")
        } // Section
        
    } // emailSection
    
    private var anonymousSection: some View {
        
        Section {
            
            Button("Link Email Account") {
                Task {
                    
                    do {
                        try await viewModel.linkEmailAccount()
                        print("Email Updated")
                    } catch {
                        print(error)
                    }
                    
                } // Task
                
            } // Button
            
        } header: {
            Text("Create Account")
        } // Section
        
    } // emailSection
    
} // SettingsView

#Preview {
    SettingsView(showSignInView: .constant(false))
} // Preview
