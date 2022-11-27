//
//  Article.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import Foundation

struct Article {
    let id: Int
    let title: String
    let content: String
    let tags: [String]
    let theme: Theme
    let user: User
    let dateCreated: Date
}
