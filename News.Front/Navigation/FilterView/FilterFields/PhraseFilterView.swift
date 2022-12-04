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

    @Binding var selectedPhrase: String
    @FocusState private var isEditing: Bool
    @State private var keyword: String = ""
    
    var body: some View {
        VStack {
            Text(String(isEditing))
            TextField("ssdsd", text: $keyword)
                .frame(minHeight: 30)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding()
                .focused($isEditing)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            isEditing = false
                        }
                    }
                }
            
            SearchResultView()
        }
    }
    
    @ViewBuilder
    func SearchResultView() -> some View {
        let filteredTags = phrases
            .filter { $0.lowercased().contains(keyword.lowercased()) }

        if !filteredTags.isEmpty, isEditing {
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
        PhraseFilterView(phrases: ["Oleg Mongol", "Steve Jobs", "Chin Kong"], placeholder: "Author", selectedPhrase: .constant(""))
    }
}
