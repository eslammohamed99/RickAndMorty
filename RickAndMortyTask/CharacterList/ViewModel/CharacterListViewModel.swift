//
//  CharacterListViewModel.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation
import Combine
class CharacterListViewModel: CharacterListViewModelProtocol, ObservableObject {
    // MARK: - Published Variables
    
    @Published var displayModel = [PresentedDataViewModel]()
    @Published var isLoading = false
     var isFetching = false
    // MARK: - Variables
    private(set) var selectedFilter: String? = nil
    private var charactertListPagination = PaginationModel(pageCount: 1, count: 0, pages: 0)
    var actionsSubject = PassthroughSubject<CharacterListActions, Never>()
    var callback: CharacterListViewModelCallback
    private var cancellables = Set<AnyCancellable>()
    private var useCase: CharacterListUseCaseProtocol
    
    init(callback: @escaping CharacterListViewModelCallback, useCase: CharacterListUseCaseProtocol) {
        self.callback = callback
        self.useCase = useCase
    }
    // MARK: - Functions
    
    func viewDidLoad() {
        Task {
            await fetchCharacters()
        }
    }
    
    func bindActions() {
        actionsSubject
            .sink { [weak self] action in
                guard let self = self else{return}
                switch action {
                case .back:
                    self.callback(.back)
                case let  .gotoDetail(item):
                    self.callback(.gotoDetail(itemInfo: item))
                case .fetchMore:
                    Task {
                        await self.paginate()
                    }
                case let .fetchStatus(status):
                    Task {
                        await self.filterSelected(filter:status)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func filterSelected(filter: String) async {
        self.selectedFilter = filter
        displayModel.removeAll()
        charactertListPagination.pageCount = 1
        await fetchCharacters()
    }
    
    @MainActor
    private func fetchCharacters() async {
        do {
            if !isFetching {
                toggleLoading(true)
            }
            let charactersResult = try await useCase.getCharacterList(page: currentPage, status: selectedFilter)
             toggleLoading(false)
             toggleFetching(false)
            displayModel.append(contentsOf: charactersResult.results?.toModels() ?? [])
            charactertListPagination = charactersResult.info ?? PaginationModel()
        } catch {
            //  dataStatus = .failure(.invalidData)
        }
    }
    
    @MainActor
    func toggleFetching(_ bool: Bool) {
        isFetching = bool
    }
    
    var currentPage: Int {
        return charactertListPagination.pageCount ?? 1
    }
    var charachtersTotalCount: Int {
        return charactertListPagination.count ?? 1
    }
    
    
    func paginate() async {
        guard !isFetching else { return }
        guard let next = charactertListPagination.next, displayModel.count < charachtersTotalCount else { return }
        isFetching = true
        charactertListPagination.pageCount = (charactertListPagination.pageCount ?? 1) + 1

        await fetchCharacters()

        isFetching = false
    }

    
    @MainActor
    func toggleLoading(_ bool: Bool) {
        isLoading = bool
    }
}

extension CharacterListViewModel {
    enum CharacterListActions {
        case back
        case gotoDetail(info:PresentedDataViewModel)
        case fetchMore
        case fetchStatus(status:String)
    }
}
