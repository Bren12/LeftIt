//
//  AuthenticationManager.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 11/12/24.
//

import Foundation
import FirebaseAuth

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
} // -> AuthProviderOption

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init() {}
    
    
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        } // -> guard
        return AuthDataResultModel(user: user)
    } // -> getAuthenticatedUser
    
    
    
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        } // -> guard
        
        var providers: [AuthProviderOption] = []
        
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            } // -> if-else
        } // -> for
        
        print(providers)
        
        return providers
    } // -> getProviders
    
    
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    } // -> createUser
    
    
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    } // -> signOut
    
    
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    } // -> resetPassword
    
    
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        } // -> guard
        try await user.updatePassword(to: password)
    } // -> updatePassword
    
    
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        } // -> guard
        try await user.updateEmail(to: email)
    } // -> updateEmail
    
    
    
    func signOut() throws {
        try Auth.auth().signOut()
    } // -> signOut
    
    
    
    func deleteUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        } // -> guard
        try await user.delete()
    } // -> signOut
    
} // -> AuthenticationManager

// MARK: SIGN IN ANONYMOUS

extension AuthenticationManager {
    
    @discardableResult
    func signInAnonymous() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    } // -> signInAnonymous
    
    func linkEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        return try await linkCredential(credential: credential)
    } // -> linkEmail
    
    private func linkCredential(credential: AuthCredential) async throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        } // -> guard
        let authDataResult = try await user.link(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    } // -> linkCredential
    
} // -> extension
