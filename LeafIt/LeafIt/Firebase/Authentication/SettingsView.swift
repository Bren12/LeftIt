//
//  SettingsView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 11/12/24.
//

import SwiftUI

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
            
            Button(role: .destructive) {
                
                Task {
                    
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                    
                } // Task
                
            } label: {
                
                Text("Delete Account")
                
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
