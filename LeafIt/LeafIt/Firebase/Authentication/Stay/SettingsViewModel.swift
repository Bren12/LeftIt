//
//  SettingsViewModel.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 13/12/24.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadAuthProviders() {
        
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        } // -> if
        
    } // -> loadAuthProviders
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    } // -> loadAuthProviders
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    } // -> signOut
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.deleteUser()
    } // -> signOut
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        } // -> guard
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    } // -> signOut
    
    func updateEmail() async throws {
        let email = "test123@hotmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    } // -> updateEmail
    
    func updatePassword() async throws {
        let password = "test123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    } // -> updatePassword
    
    func linkEmailAccount() async throws {
        let email = "test123@hotmail.com"
        let password = "test123"
        self.authUser = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    } // -> updatePassword
    
} // -> SettingsViewModel
