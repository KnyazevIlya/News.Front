//
//  MainView.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI
import SwiftUIFlow

struct MainView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    @State private var isFilterPresented = false
    @State private var isEditorPresented = false
    
    var body: some View {
        NavigationView {
            List {
                if !viewModel.filters.isEmpty {
                    Section {
                        SelectedFiltersView()
                            .buttonStyle(PlainButtonStyle())
                    }
                }
                
                Section {
                    ForEach(viewModel.articles, id:\.id) { article in
                        NavigationLink {
                            DetailedArtileView(article: article)
                        } label: {
                            ArticleView(article: article)
                        }

                    }
                }
            }
            .navigationTitle("News feed")
            .toolbar {
                Button {
                    isFilterPresented.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .scaleEffect(1.2)
                }
                .overlay(
                    VStack {
                        if !viewModel.filters.isEmpty {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 15, height: 15)
                                .offset(x: 10, y: -7)
                                .overlay(
                                    Text("\(viewModel.filters.count)")
                                        .font(.system(size: 10))
                                        .foregroundColor(.white)
                                        .offset(x: 10, y: -7)
                                )
                        }
                    }
                )
                .sheet(isPresented: $isFilterPresented) {
                    FilterView()
                }

                Button {
                    isEditorPresented.toggle()
                } label: {
                    Image(systemName: "square.and.pencil.circle.fill")
                        .scaleEffect(1.2)
                }
                .sheet(isPresented: $isEditorPresented) {
                    Text("Editor here")
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetchArticles()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchArticles()
            }
        }
    }
    
    @ViewBuilder
    private func SelectedFiltersView() -> some View {
        VFlow(alignment: .leading) {
            ForEach(Array(viewModel.filters.enumerated()), id:\.offset) { index, filter in
                Button {
                    viewModel.removeFilter(at: index)
                } label: {
                    HStack {
                        if let icon = filter.icon {
                            icon
                                .renderingMode(.template)
                                .foregroundColor(.white)
                        }
                        
                        TextForFilter(filter)
                            .font(.system(.caption, design: .rounded, weight: .semibold))
                            .foregroundColor(.white)

                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(filter.color)
                    .cornerRadius(15)
                }
            }
        }
    }
    
    private func TextForFilter(_ filter: Filter) -> Text {
        switch filter {
        case .author(_, let name):
            return Text(name)
        case .tag(let tag):
            return Text(tag)
        case .theme(let theme):
            return Text(theme)
        case .fromDate(let date):
            return Text("from: \(date.formatted(.dateTime.day().month().year()))")
        case .toDate(let date):
            return Text("to: \(date.formatted(.dateTime.day().month().year()))")
        }
    }
    
    @ViewBuilder
    private func ArticleView(article: Article) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.title)
                .font(.system(.body, design: .rounded, weight: .semibold))
            
            Text(article.theme.id)
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                .foregroundColor(.blue)
            
            Text(article.content)
                .lineLimit(3)
                .font(.system(.footnote, design: .rounded, weight: .regular))
            
            VFlow(alignment: .leading) {
                ForEach(article.tags, id:\.self) { tag in
                    Text(tag)
                        .font(.system(.caption, design: .rounded, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
            
            HStack {
                Text("By: \(article.user.firstName) \(article.user.secondName)")
                    .font(.system(.footnote, design: .rounded, weight: .semibold))
                
                Spacer()
                
                Text(article.dateCreated.formatted(.dateTime.day().month().year()))
                    .font(.system(.footnote, design: .rounded, weight: .semibold))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel())
    }
}
