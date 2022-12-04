//
//  FilterView.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    @State private var phrase = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Search by users")
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                PhraseFilterView(phrases: ["Oleg Mongol", "Steve Jobs", "Chin Kong"], placeholder: "placeholder", selectedPhrase: $phrase)
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
            .environmentObject(MainViewModel())
    }
}
