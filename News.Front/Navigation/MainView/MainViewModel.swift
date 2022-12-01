//
//  MainViewModel.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var users: [User] = []
    @Published var themes: [Theme] = []
    @Published var tags: [String] = []
    // TODO: - subscribe on updates
    // debounce
    // await URLSession
    // mapToLatest
    // animate list change
    @Published var filters: [Filter] = []
    
    @MainActor
    func fetchArticles() async {
        articles = [
            Article(id: 0,
                    title: "Some sport news",
                    content: "OSd najnd fsidjf weijfwenf weifjonwej fijwehfowuenf wefunewj nfjwenf ouwie diuwne fif ei wufn wiejfn we oijw iqj eoiqjew qwe oijqwoi ejoqwije qwoeijqowije qwoejqwoi jeoqwi jeoqwije qwoe qwo neoiqj weoij qwe qweoiq woieoiq jweoqw ijeoqwije qweojqeoi jqweojio qwijeoq wijeqow eij qowiej qow iej qwi oje qwoiejqowj eoqwije oqiwje",
                    tags: ["football", "tennis", "swimming"],
                    theme: Theme(id: "Sport"),
                    user: User(id: 0, firstName: "Oleg", secondName: "Mongol", email: "kkssdwi@gmail.com"),
                    dateCreated: Date()),
            Article(id: 1,
                    title: "Some more news",
                    content: "OSd najnd fsidjf weijfwenf weifjonwej fijwehfowuenf wefunewj nfjwenf ouwie diuwne fif ei wufn wiejfn we oijw iqj eoiqjew qwe oijqwoi ejoqwije qwoeijqowije qwoejqwoi jeoqwi jeoqwije qwoe qwo neoiqj weoij qwe qweoiq woieoiq jweoqw ijeoqwije qweojqeoi jqweojio qwijeoq wijeqow eij qowiej qow iej qwi oje qwoiejqowj eoqwije oqiwje",
                    tags: ["usa", "democrates", "biden"],
                    theme: Theme(id: "Politics"),
                    user: User(id: 0, firstName: "Sven", secondName: "Svon", email: "kkssdwi@gmail.com"),
                    dateCreated: Date()),
            Article(id: 2,
                    title: "Rumors about the new MacBook M2",
                    content: "OSd najnd fsidjf weijfwenf weifjonwej fijwehfowuenf wefunewj nfjwenf ouwie diuwne fif ei wufn wiejfn we oijw iqj eoiqjew qwe oijqwoi ejoqwije qwoeijqowije qwoejqwoi jeoqwi jeoqwije qwoe qwo neoiqj weoij qwe qweoiq woieoiq jweoqw ijeoqwije qweojqeoi jqweojio qwijeoq wijeqow eij qowiej qow iej qwi oje qwoiejqowj eoqwije oqiwje",
                    tags: ["apple", "macbook", "rumors"],
                    theme: Theme(id: "Tech"),
                    user: User(id: 0, firstName: "Steve", secondName: "Jobs", email: "kkssdwi@gmail.com"),
                    dateCreated: Date()),
            Article(id: 3,
                    title: "Some MORE sport news",
                    content: "OSd najnd fsidjf weijfwenf weifjonwej fijwehfowuenf wefunewj nfjwenf ouwie diuwne fif ei wufn wiejfn we oijw iqj eoiqjew qwe oijqwoi ejoqwije qwoeijqowije qwoejqwoi jeoqwi jeoqwije qwoe qwo neoiqj weoij qwe qweoiq woieoiq jweoqw ijeoqwije qweojqeoi jqweojio qwijeoq wijeqow eij qowiej qow iej qwi oje qwoiejqowj eoqwije oqiwje",
                    tags: ["football", "tennis", "swimming"],
                    theme: Theme(id: "Sport"),
                    user: User(id: 0, firstName: "Oleg", secondName: "Mongol", email: "kkssdwi@gmail.com"),
                    dateCreated: Date())
        ]
        
        filters = [
            .tag("football"),
            .theme("Sport"),
            .tag("swimming"),
            .author(10, "Oleg Mongol"),
            .toDate(Date().addingTimeInterval(.dayDuration)),
            .fromDate(Date().addingTimeInterval(-(.dayDuration))),
        ]
        filters.sort { $0.order < $1.order }
    }
    
    func removeFilter(at index: Int) {
        filters.remove(at: index)
    }
    
}
