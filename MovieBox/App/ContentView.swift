//
//  ContentView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection: Tab = .home
    @StateObject private var session = SessionManager.shared
    // for endless invocation loop between pages. Login -> Register 
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack {
            if session.isLoggedIn {
                // MARK: - Main TabView if user is logged in
                TabView(selection: $tabSelection) {
                    HomeView()
                        .tag(Tab.home)
                    FavoritesView()
                        .tag(Tab.favorite)
                    ProfileView()
                        .tag(Tab.profile)
                }
                .overlay(alignment: .bottom) {
                    TabBarView(selectedTab: $tabSelection)
                }
            } else {
                // MARK: - Show Login or Register View if not logged in
                LoginView()
            }
        }
        .onAppear {
            // MARK: - Load session when app launches
            session.loadUserSession()
        }
    }
}


#Preview {
    ContentView()
}
