//
//  LeafItApp.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI
import SwiftData

@main
struct LeafItApp: App {
    
//    init() {
//        FirebaseApp.configure()
//    } // -> init
    
    var body: some Scene {
        WindowGroup {
            RootView()
        } // -> WindowGroup
        .modelContainer(for: [DBStreak.self, DBGoal.self, DBBook.self])
    } // -> body
    
} // -> LeafItApp
