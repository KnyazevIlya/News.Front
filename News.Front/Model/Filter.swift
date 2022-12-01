//
//  Filter.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import Foundation
import SwiftUI

enum Filter {
    case author(Int, String)
    case tag(String)
    case theme(String)
    case fromDate(Date)
    case toDate(Date)
    
    var icon: Image? {
        switch self {
        case .author(_, _):
            return Image(systemName: "person.circle.fill")
        case .tag(_):
            return Image(systemName: "tag.fill")
        case .theme(_):
            return Image(systemName: "newspaper.fill")
        default:
            return nil
        }
    }
    
    var color: Color {
        switch self {
        case .author(_, _):
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
        case .author(_, _):
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
