//
//  TabBarView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Tab
    @Namespace private var animationCapsule
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                tabButton(for: tab)
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 60)
        .background(Color.background)
        .overlay(
            EdgeBorder(width: 0.2, edges: [.top])
                .foregroundColor(Color.gray.opacity(0.5))
        )
    }

    @ViewBuilder
    private func tabButton(for tab: Tab) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        }) {
            VStack {
                Image(tab.icon)
                    .renderingMode(.template)
                    .font(.system(size: 20))
                    
                Text(tab.rawValue)
                    .font(selectedTab == tab ? Fonts.Caption.semibold : Fonts.Caption.light)
                    .offset(y: 3)
                
                if tab == selectedTab {
                    selectionIndicator()
                }
            }
            .padding(.top, 15)
            .foregroundColor(selectedTab == tab ? .main : .gray.opacity(0.8))
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }

    private func selectionIndicator() -> some View {
        Capsule()
            .frame(width: 3, height: 3)
            .foregroundColor(.main)
            .matchedGeometryEffect(id: "selectedTabID", in: animationCapsule)
            .offset(y: 3)
    }
}
