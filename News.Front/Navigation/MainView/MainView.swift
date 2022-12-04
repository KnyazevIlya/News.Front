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
                if viewModel.isFilterShown {
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
            if let author = viewModel.filter.author {
                FilterComponentView(forFilter: .author, withText: author.1)
            }
            
            if let theme = viewModel.filter.theme {
                FilterComponentView(forFilter: .theme, withText: theme)
            }
            
            ForEach(viewModel.filter.tags, id:\.self) { tag in
                FilterComponentView(forFilter: .tag(tag), withText: tag)
            }
            
            if let formDate = viewModel.filter.fromDate {
                FilterComponentView(forFilter: .fromDate, withText: "from: \(formDate.formatted(.dateTime.day().month().year()))")
            }
            
            if let toDate = viewModel.filter.toDate {
                FilterComponentView(forFilter: .toDate, withText: "to: \(toDate.formatted(.dateTime.day().month().year()))")
            }
        }
    }
    
    @ViewBuilder
    private func FilterComponentView(forFilter filter: Filter, withText text: String) -> some View {
        Button {
            viewModel.remove(filter: filter)
        } label: {
            HStack {
                if let iconName = filter.icon {
                    Image(systemName: iconName)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
                
                Text(text)
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
