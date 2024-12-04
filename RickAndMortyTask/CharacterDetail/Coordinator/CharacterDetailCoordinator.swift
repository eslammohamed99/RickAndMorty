//
//  CharacterDetailCoordinator.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation
import UIKit

class CharacterDetailCoordinator: BaseCoordinator, CharacterDetailCoordinatorProtocol {
    
    
    private var callback: CharacterDetailCoordinatorCall?
    private var viewModel: CharacterDetailViewModelProtocol?
    required init(useCase: CharacterDetailCoordinatorUseCaseProtocol) {
        super.init(navigationController: useCase.navigationController)
        viewModel = CharacterDetailViewModel(displayModel: useCase.characterInfo, callback: processViewModelCallback())
    }

    func start(callback: @escaping CharacterDetailCoordinatorCall) {
        self.callback = callback
        let view: CharacterDetailViewProtocol & UIViewController = CharacterDetailView()
        view.viewModel = viewModel
        navigationController?.pushViewController(view, animated: true)
    }

}

private extension CharacterDetailCoordinator {
    func processViewModelCallback() -> CharacterDetailViewModelCallback {
        return { [weak self] type in
            switch type {
            case .back:
                self?.callback?(.back)
            }
        }
    }
}
