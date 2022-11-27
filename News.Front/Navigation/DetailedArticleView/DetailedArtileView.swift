//
//  DetailedArtileView.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI
import SwiftUIFlow

struct DetailedArtileView: View {
    
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(article.theme.id)
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .foregroundColor(.blue)
                
                Text(article.content)
                    .font(.system(.body, design: .rounded, weight: .regular))
                
                VFlow(alignment: .leading) {
                    ForEach(article.tags, id:\.self) { tag in
                        Text(tag)
                            .font(.system(.footnote, design: .rounded, weight: .semibold))
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
        .padding()
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailedArtileView_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article(
            id: 0,
            title: "Some sport news",
            content: "OSd najnd fsidjf weijfwenf weifjonwej fijwehfowuenf wefunewj nfjwenf ouwie diuwne fif ei wufn wiejfn we oijw iqj eoiqjew qwe oijqwoi ejoqwije qwoeijqowije qwoejqwoi jeoqwi jeoqwije qwoe qwo neoiqj weoij qwe qweoiq woieoiq jweoqw ijeoqwije qweojqeoi jqweojio qwijeoq wijeqow eij qowiej qow iej qwi oje qwoiejqowj eoqwije oqiwje",
            tags: ["football", "tennis", "swimming"],
            theme: Theme(id: "Sport"),
            user: User(id: 0, firstName: "Oleg", secondName: "Mongol", email: "kkssdwi@gmail.com"),
            dateCreated: Date())
        
        DetailedArtileView(article: article)
    }
}
