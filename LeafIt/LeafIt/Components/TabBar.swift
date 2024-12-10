//
//  TabBar.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 10/12/24.
//

import SwiftUI

struct TabBar: View {
    
    var body: some View {
        
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            
            HomeView()
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            
        } // -> TabView
        
    } // -> body
    
} // -> TabBar

#Preview {
    TabBar()
} // -> Preview
