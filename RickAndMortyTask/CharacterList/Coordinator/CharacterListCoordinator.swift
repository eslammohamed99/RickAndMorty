//
//  CharacterListCoordinator.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import UIKit

class CharacterListCoordinator: BaseCoordinator, CharacterListCoordinatorProtocol {
    private var callback: CharacterListCoordinatorCall?
    private var viewModel: CharacterListViewModelProtocol?
    private weak var window: UIWindow?
    required init(useCase: CharacterListCoordinatorUseCaseProtocol) {
        window = useCase.window
        super.init()
        viewModel = CharacterListViewModel(callback: processViewModelCallback(), useCase: CharacterListUseCase())
    }

    func start() {
        let view: CharacterListViewProtocol & UIViewController = CharacterListView()
        view.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: view)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        self.navigationController = navigationController
    }
    
    func gotoDetailCharacter(character: PresentedDataViewModel){
        struct UseCase: CharacterDetailCoordinatorUseCaseProtocol {
            var navigationController: UINavigationController
            var characterInfo: PresentedDataViewModel
        }
        guard let navigationController = navigationController else {
            return
        }
        let coordinator = CharacterDetailCoordinator(
            useCase: UseCase(navigationController: navigationController,
                             characterInfo: character))
        addChild(coordinator)
        coordinator.start(
            callback: { [weak self] type in
                guard let self = self else {
                    return
                }
                switch type {
                case.back:
                    self.navigationController?.popViewController(animated: true)
                }
            })
    }
}

private extension CharacterListCoordinator {
    func processViewModelCallback() -> CharacterListViewModelCallback {
        return { [weak self] type in
            switch type {
            case .back:
                break
            case let .gotoDetail(itemInfo):
                self?.gotoDetailCharacter(character: itemInfo)
            }
        }
    }
}
