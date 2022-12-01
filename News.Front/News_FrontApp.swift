//
//  News_FrontApp.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI

@main
struct News_FrontApp: App {
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(mainViewModel)
        }
    }
}
