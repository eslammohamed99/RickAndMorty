//
//  CharacterListView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import UIKit


class CharacterListView: UIViewController, CharacterListViewProtocol {
    var viewModel: CharacterListViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel?.bindActions()
    }
}

private extension CharacterListView {
    func setupUI() {
        if let viewModel = viewModel as? CharacterListViewModel {
            let swiftuiView = CharacterListUIView(viewModel: viewModel)
            addSubSwiftUIView(swiftuiView, to: view, backgroundColor: .white)
        }
    }
}
