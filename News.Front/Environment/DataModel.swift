//
//  DataModel.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import Foundation

final class DataModel: ObservableObject {
    @Published var filers: [Filter] = []
    
    @Published var articles: [Article] = []
    @Published var users: [User] = []
    @Published var themes: [Theme] = []
    @Published var tags: [String] = []
}
