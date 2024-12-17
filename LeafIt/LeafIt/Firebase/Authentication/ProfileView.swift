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
        guard let user else { return }
        let currValue = user.isPremium ?? false
        Task {
            try await UserManager.shared.updateUserPremiumStatus(userID: user.userId, isPremium: !currValue)
            self.user = try await UserManager.shared.getUser(userID: user.userId)
        } // -> Task
    } // -> loadCurrentUser
    
    func addUserPreference(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.addUserPreference(userID: user.userId, preference: text)
            self.user = try await UserManager.shared.getUser(userID: user.userId)
        } // -> Task
    } // -> addUserPreference
    
    func removeUserPreference(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.removeUserPreference(userID: user.userId, preference: text)
            self.user = try await UserManager.shared.getUser(userID: user.userId)
        } // -> Task
    } // -> removeUserPreference
    
    func addFavoriteMovie() {
        guard let user else { return }
        let movie = Movie(id: "1", title: "Avatar", isPopular: true)
        Task {
            try await UserManager.shared.addFavoriteMovie(userID: user.userId, movie: movie)
            self.user = try await UserManager.shared.getUser(userID: user.userId)
        } // -> Task
    } // -> addFavoriteMovie
    
    func removeFavoriteMovie() {
        guard let user else { return }
        Task {
            try await UserManager.shared.removeFavoriteMovie(userID: user.userId)
            self.user = try await UserManager.shared.getUser(userID: user.userId)
        } // -> Task
    } // -> removeFavoriteMovie
    
} // -> ProfileViewModel

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    @Binding var showSignInView: Bool
    
    let preferenceOptions: [String] = ["Sports", "Movies", "Books"]
    
    private func preferenceSelected(text: String) -> Bool {
        return viewModel.user?.preference?.contains(text) == true
    } // preferenceSelected
    
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
                } // Button
                
                VStack {
                    
                    HStack {
                        
                        ForEach(preferenceOptions, id: \.self) { str in
                            
                            Button(str) {
                                if preferenceSelected(text: str) {
                                    viewModel.removeUserPreference(text: str)
                                } else {
                                    viewModel.addUserPreference(text: str)
                                }
                            } // Button
                            .font(.headline)
                            .buttonStyle(.borderedProminent)
                            .tint(preferenceSelected(text: str) ? .green : .red)
                            
                        }
                        
                    } // -> HStack
                    
                } // -> VStack
                
                Text("User preferences: \((user.preference ?? []).joined(separator: ", "))")
                
                Button {
                    if user.favoriteMovie == nil {
                        viewModel.addFavoriteMovie()
                    } else {
                        viewModel.removeFavoriteMovie()
                    }
                } label: {
                    Text("Favorite Movie: \((user.favoriteMovie?.title ?? ""))")
                }
                
            } // -> if
            
        } // -> List
        .task {
//            try? await viewModel.loadCurrentUser()
//            print("HELLOOOOO")
//            print(viewModel.user ?? false)
        } // task
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
    RootView2()
}
