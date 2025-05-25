//
//  UIScreen.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//
 
import SwiftUI

extension UIScreen {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
}
