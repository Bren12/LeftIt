//
//  LeafItApp.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI
import Firebase

@main
struct LeafItApp: App {
    
    init() {
        FirebaseApp.configure()
    } // -> init
    
    var body: some Scene {
        WindowGroup {
            RootView2()
        } // -> WindowGroup
    } // -> body
    
} // -> LeafItApp
