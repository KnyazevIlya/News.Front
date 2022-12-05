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

    @Binding var selectedPhrase: String?
    @FocusState private var isEditing: Bool
    @State private var keyword: String
    
    init(phrases: [String], placeholder: String, selectedPhrase: Binding<String?>) {
        self.phrases = phrases
        self.placeholder = placeholder
        self._selectedPhrase = selectedPhrase
        
        keyword = selectedPhrase.wrappedValue ?? ""
    }
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $keyword)
                .frame(minHeight: 30)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .focused($isEditing)
                .toolbar {
                    if isEditing {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("Done") {
                                isEditing = false
                            }
                        }
                    }
                }
                .overlay(
                    HStack {
                        Spacer()
                        
                        if !keyword.isEmpty {
                            Button {
                                keyword = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .padding(.trailing)
                        }
                    }
                )
            
            SearchResultView()
        }
        .onChange(of: keyword) { newValue in
            if newValue.isEmpty {
                selectedPhrase = nil
            }
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
