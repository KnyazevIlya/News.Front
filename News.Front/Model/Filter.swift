//
//  Filter.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import Foundation
import SwiftUI

enum Filter {
    case author
    case tag(String)
    case theme
    case fromDate
    case toDate
    
    var icon: String? {
        switch self {
        case .author:
            return "person.circle.fill"
        case .tag(_):
            return "tag.fill"
        case .theme:
            return "newspaper.fill"
        default:
            return nil
        }
    }
    
    var color: Color {
        switch self {
        case .author:
            return .purple
        case .tag(_):
            return .green
        case .theme:
            return .orange
        case .fromDate:
            return .pink
        case .toDate:
            return .pink
        }
    }
}
