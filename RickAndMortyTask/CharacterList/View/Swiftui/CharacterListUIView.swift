//
//  CharacterListUIView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import SwiftUI

struct CharacterListUIView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FilterUIView(viewModel: viewModel)
            CharacterListTableViewUI(viewModel: viewModel)
            if viewModel.isFetching {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        }
        }
        .padding(.top, 20)
        .loadingOverlay(isLoading: viewModel.isLoading)
        .onAppear { Task { viewModel.viewDidLoad() } }
    }
}

private struct FilterUIView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        FilterRepresentableView(viewModel: viewModel)
            .frame(height: 40)
            .padding(.leading,20)
    }
}

private struct CharacterListTableViewUI: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        CharactersListRepresentableView(viewModel: viewModel) { character in
            self.viewModel.callback(.gotoDetail(itemInfo: character))
            // router.openDetails(character: character, presentAs: .push)
        }
    }
}
