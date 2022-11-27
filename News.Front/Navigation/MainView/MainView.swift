//
//  MainView.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI
import SwiftUIFlow

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles, id:\.id) { article in
                    NavigationLink {
                        DetailedArtileView(article: article)
                    } label: {
                        ArticleView(article: article)
                    }

                }
            }
            .navigationTitle("News feed")
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
        MainView(viewModel: MainViewModel())
    }
}
