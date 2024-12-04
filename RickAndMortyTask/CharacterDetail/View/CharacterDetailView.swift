//
//  CharacterDetailView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import UIKit


class CharacterDetailView: UIViewController, CharacterDetailViewProtocol {
    var viewModel: CharacterDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.bindActions()
        configureNavigation()
    }
    
    private func configureNavigation() {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

private extension CharacterDetailView {
    func setupUI() {
        if let viewModel = viewModel as? CharacterDetailViewModel {
            let swiftuiView = CharacterDetailUIView(viewModel: viewModel)
            addSubSwiftUIView(swiftuiView, to: view, backgroundColor: .white)
        }
    }
}

