//
//  TagFilterView.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI

struct TagFilterView: View {
    var tags: [String] = []
    let placeholder: String
    let field: FilterField

    @Binding var selectedField: FilterField
    @Binding var selectedTags: [String]
    
    @State private var keyword: String = ""
        
    var body: some View {
        VStack {
            SearchView()
            
            SearchResultView()
        }
    }
    
    @ViewBuilder
    func SearchView() -> some View {
        HStack(alignment: .top, spacing: 10) {
            TagTextField(tags: $selectedTags, keyword: $keyword, placeholder: placeholder) { _ in
                return tags
                    .filter{ $0.contains(keyword.lowercased()) }
                    .first
            }
            .frame(minHeight: 30)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
        }
        .padding()
    }
    
    @ViewBuilder
    func SearchResultView() -> some View {
        let filteredTags = tags
            .filter { !selectedTags.contains($0) }
            .filter { $0.contains(keyword.lowercased()) }
        
        if !filteredTags.isEmpty, field == selectedField {
            List {
                ForEach(filteredTags, id: \.self) { tag in
                    Button {
                        if !selectedTags.contains(tag) {
                            selectedTags.append(tag)
                        }
                        keyword.removeAll()
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

struct TagFilterView_Previews: PreviewProvider {
    static let tags = ["Java", "Python", "JavaScript", "Php", "Swift", "SQL", "Ruby", "Objective-C", "Go", "Assembly", "Basic", "Html", "React", "Kotlin", "C++", "C#"].map { $0.lowercased() }
    static var previews: some View {
        TagFilterView(tags: tags, placeholder: "Tags", field: .tag, selectedField: .constant(.tag), selectedTags: .constant([]))
    }
}
