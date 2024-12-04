//
//  CharacterDetailViewModel.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation
import Combine
class CharacterDetailViewModel: CharacterDetailViewModelProtocol, ObservableObject {

    // MARK: - Published Variables
    
    @Published var displayModel: PresentedDataViewModel
    // MARK: - Variables
    var actionsSubject = PassthroughSubject<CharacterDetailActions, Never>()
    var callback: CharacterDetailViewModelCallback
    private var cancellables = Set<AnyCancellable>()
    init(displayModel: PresentedDataViewModel, callback: @escaping CharacterDetailViewModelCallback) {
        self.displayModel = displayModel
        self.callback = callback
    }
    // MARK: - Functions
    
    func viewDidLoad() {
        
    }
    
    func bindActions() {
        actionsSubject
            .sink { [weak self] action in
                guard let self = self else{return}
                switch action {
                case .back:
                    self.callback(.back)
                }
            }
            .store(in: &cancellables)
    }
}

extension CharacterDetailViewModel {
    enum CharacterDetailActions {
        case back
    }
}
