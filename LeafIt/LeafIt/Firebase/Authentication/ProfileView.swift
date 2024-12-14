//
//  ProfileView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 13/12/24.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        print(authDataResult)
        self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
    } // -> loadCurrentUser
    
    func togglePremiumStatus() {
        guard var user else { return }
        let currValue = user.isPremium ?? false
        Task {
            try await UserManager.shared.updateUserPremiumStatus(userID: user.userId, isPremium: !currValue)
            self.user = try await UserManager.shared.getUser(userID: user.userId)
        } // -> Task
    } // -> loadCurrentUser
    
} // -> ProfileViewModel

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        
        List {
            
            if let user = viewModel.user {
                
                Text ("UserId: \(user.userId)")
                
                if let isAnonymous = user.isAnonymous {
                    Text ("Is Anonymous: \(isAnonymous.description.capitalized)")
                } // -> ProfileViewModel
                
                Button {
                    viewModel.togglePremiumStatus()
                } label: {
                    Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                }
                
            } // -> ProfileViewModel
            
        } // -> List
        .task {
            try? await viewModel.loadCurrentUser()
            print("HELLOOOOO")
            print(viewModel.user ?? false)
        } // onAppear
        .navigationTitle ("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                } // NavigationLink
            } // ToolbarItem
        } // toolbar
        
    } // -> body
    
} // -> ProfileViewModel

#Preview {
    ProfileView(showSignInView: .constant(false))
}
