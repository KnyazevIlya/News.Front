//
//  FilterView.swift
//  News.Front
//
//  Created by kniaziev.intern on 27.11.2022.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    
    var body: some View {
        Text("\(viewModel.filters.count)")
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
            .environmentObject(MainViewModel())
    }
}
