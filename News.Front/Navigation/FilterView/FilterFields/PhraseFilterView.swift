//
//  PhraseFilterView.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI

struct PhraseFilterView: View {
    var phrases: [String]
    let placeholder: String
    let field: FilterField

    @Binding var selectedField: FilterField
    @Binding var selectedPhrase: String
    
    @State private var keyword: String = ""
    
    var body: some View {
        VStack {
            TextField("ssdsd", text: $keyword)
                .frame(minHeight: 30)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding()
            
            SearchResultView()
        }
    }
    
    @ViewBuilder
    func SearchResultView() -> some View {
        let filteredTags = phrases
            .filter { $0.contains(keyword.lowercased()) }

        if !filteredTags.isEmpty, field == selectedField {
            List {
                ForEach(filteredTags, id: \.self) { tag in
                    Button {
                        selectedPhrase = tag
                        keyword = tag
                    } label: {
                        Text(tag)
                    }
                }
            }
            .listStyle(.plain)
            .frame(maxHeight: 150)
        }
    }
}

struct PhraseFilterView_Previews: PreviewProvider {
    static var previews: some View {
        PhraseFilterView(phrases: ["Oleg Mongol", "Steve Jobs", "Chin Kong"].map { $0.lowercased() }, placeholder: "Author", field: .author, selectedField: .constant(.author), selectedPhrase: .constant(""))
    }
}
