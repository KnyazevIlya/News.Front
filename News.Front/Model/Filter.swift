//
//  Filter.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import Foundation
import SwiftUI

enum Filter {
    case user(Int, String)
    case tag(String)
    case theme(String)
    case fromDate(Date)
    case toDate(Date)
    
    var color: Color {
        switch self {
        case .user(_, _):
            return .purple
        case .tag(_):
            return .green
        case .theme(_):
            return .orange
        case .fromDate(_):
            return .pink
        case .toDate(_):
            return .pink
        }
    }
    
    var order: Int {
        switch self {
        case .user(_, _):
            return 0
        case .tag(_):
            return 1
        case .theme(_):
            return 2
        case .fromDate(_):
            return 3
        case .toDate(_):
            return 4
        }
    }
}
