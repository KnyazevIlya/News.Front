//
//  FilterView.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    @State private var selectedAuthor: String?
    
    @State private var fromDate: Date = Date()
    @State private var toDate: Date = Date()
    
    @State private var isFromDateEnabled = false
    @State private var isToDateEnabled = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 30)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Find by author")
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                    PhraseFilterView(
                        phrases: viewModel.users.map({ "\($0.firstName) \($0.secondName)" }),
                        placeholder: "Name Namy",
                        selectedPhrase: $selectedAuthor)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Select theme")
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                    PhraseFilterView(
                        phrases: viewModel.themes.map({ $0.id }),
                        placeholder: "Sport or cooking or whatever",
                        selectedPhrase: $viewModel.filter.theme)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Select tags")
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                    TagFilterView(tags: viewModel.tags,
                                  placeholder: "Tag",
                                  selectedTags: $viewModel.filter.tags)
                }
                
                Spacer()
                    .frame(height: 30)
                
                VStack(alignment: .leading) {
                    Button {
                        isFromDateEnabled.toggle()
                    } label: {
                        HStack {
                            Image(systemName: isFromDateEnabled ? "minus" : "plus")
                            
                            Text(isFromDateEnabled ? "Remove from date filter" : "Add from date filter")
                        }
                        .foregroundColor(.blue)
                    }

                    DatePicker("From:",
                               selection: $fromDate,
                               in: ...toDate,
                               displayedComponents: .date)
                        .fixedSize()
                        .opacity(isFromDateEnabled ? 1 : 0)
                        .frame(height: isFromDateEnabled ? 30 : 0)
                }
                
                VStack(alignment: .leading) {
                    Button {
                        isToDateEnabled.toggle()
                    } label: {
                        HStack {
                            Image(systemName: isToDateEnabled ? "minus" : "plus")
                            
                            Text(isToDateEnabled ? "Remove to date filter" : "Add to date filter")
                        }
                        .foregroundColor(.blue)
                    }

                    DatePicker("To:",
                               selection: $toDate,
                               in: fromDate...,
                               displayedComponents: .date)
                        .fixedSize()
                        .opacity(isToDateEnabled ? 1 : 0)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .onAppear {
            selectedAuthor = viewModel.filter.author?.1 ?? ""
            
            if let fromDate = viewModel.filter.fromDate {
                isFromDateEnabled = true
                self.fromDate = fromDate
            }
            
            if let toDate = viewModel.filter.toDate {
                isToDateEnabled = true
                self.toDate = toDate
            }
        }
        .onChange(of: selectedAuthor) { newValue in
            guard let newValue else {
                viewModel.filter.author = nil
                return
            }
            if let currentValue = viewModel.filter.author?.1, newValue == currentValue {
                return
            }
            
            guard let associatedUserId = viewModel.users
                    .first(where: { "\($0.firstName) \($0.secondName)" == newValue })?.id
            else { return }

            viewModel.filter.author = (associatedUserId, newValue)
        }
        .onChange(of: isFromDateEnabled) { newValue in
            if !newValue {
                viewModel.filter.fromDate = nil
            }
        }
        .onChange(of: fromDate) { newValue in
            viewModel.filter.fromDate = newValue
        }
        .onChange(of: isToDateEnabled) { newValue in
            if !newValue {
                viewModel.filter.toDate = nil
            }
        }
        .onChange(of: toDate) { newValue in
            viewModel.filter.toDate = newValue
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
            .environmentObject(MainViewModel())
    }
}
