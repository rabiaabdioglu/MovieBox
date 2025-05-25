//
//  ContentView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var tabSelection : Tab = .home
    
    var body: some View {
        TabView(selection: $tabSelection){
            HomeView()
                .tag(Tab.home)
            EmptyResultView(imageName: "heart", message: "There is no favorite movie")
                .tag(Tab.favorite)
            ProfileView()
                .tag(Tab.profile)
            
        }
        .overlay(alignment: .bottom){
            TabBarView(selectedTab: $tabSelection)
        }
    }
}


#Preview {
    ContentView()
}
