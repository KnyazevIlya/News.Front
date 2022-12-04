//
//  FilterContainer.swift
//  News.Front
//
//  Created by kniaziev.intern on 04.12.2022.
//

import Foundation

struct FilterContainer {
    var author: (Int, String)?
    var theme: String?
    var tags: [String] = []
    var fromDate: Date?
    var toDate: Date?
}
