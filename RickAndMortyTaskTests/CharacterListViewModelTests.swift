//
//  CharacterListViewModelTests.swift
//  RickAndMortyTaskTests
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import XCTest
import Combine
@testable import RickAndMortyTask

enum MockData {
    static let characters = CharacterListModel(
        info: PaginationModel(pageCount: 1, count: 826, next: "https://rickandmortyapi.com/api/character?page=2", pages: 42),
        results: [
            CharacterInfo(
                gender: "Male",
                id: 1,
                image: "rick-url",
                location: LocationModel(name: "Earth", url: "earth-url"),
                name: "Rick",
                species: "Human",
                status: .Alive,
                type: "",
                url: "rick-character-url"
            ),
            CharacterInfo(
                gender: "Male",
                id: 2,
                image: "morty-url",
                location: LocationModel(name: "Earth", url: "earth-url"),
                name: "Morty",
                species: "Human",
                status: .Alive,
                type: "",
                url: "morty-character-url"
            )
        ]
    )
    
    static let moreCharacters = CharacterListModel(
        info: PaginationModel(pageCount: 2, count: 4, next: nil, pages: 2),
        results: [
            CharacterInfo(
                gender: "Female",
                id: 3,
                image: "summer-url",
                location: LocationModel(name: "Earth", url: "earth-url"),
                name: "Summer",
                species: "Human",
                status: .Alive,
                type: "",
                url: "summer-character-url"
            ),
            CharacterInfo(
                gender: "Female",
                id: 4,
                image: "beth-url",
                location: LocationModel(name: "Earth", url: "earth-url"),
                name: "Beth",
                species: "Human",
                status: .Alive,
                type: "",
                url: "beth-character-url"
            )
        ]
    )
}

class MockCharacterListUseCase: CharacterListUseCaseProtocol {
    var mockResult: Result<CharacterListModel, Error>?
    var getCharacterListCallCount = 0
    var lastPageRequested: Int?
    var lastStatusRequested: String?
    
    func getCharacterList(page: Int, status: String?) async throws -> CharacterListModel {
        getCharacterListCallCount += 1
        lastPageRequested = page
        lastStatusRequested = status
        
        guard let mockResult else {
            throw NSError(domain: "MockUseCase", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock result set"])
        }
        
        switch mockResult {
        case .success(let model):
            return model
            
        case .failure(let error):
            throw error
        }
    }
}

final class CharacterListViewModelTests: XCTestCase {
    private var sut: CharacterListViewModel!
    private var mockUseCase: MockCharacterListUseCase!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockCharacterListUseCase()
        sut = CharacterListViewModel(callback: { _ in }, useCase: mockUseCase)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_fetchesCharacters() async {
        let expectedCharacters = MockData.characters
        mockUseCase.mockResult = .success(expectedCharacters)
        let expectation = XCTestExpectation(description: "Characters loaded")
        
        sut.$displayModel
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await sut.viewDidLoad()
        await fulfillment(of: [expectation], timeout: 1)
        
        XCTAssertEqual(sut.displayModel.count, expectedCharacters.results?.count)
    }
    
    func test_filterSelected_resetsAndFetchesNewCharacters() async {
        let filter = "Alive"
        let expectedCharacters = MockData.characters
        mockUseCase.mockResult = .success(expectedCharacters)
        
        await sut.filterSelected(filter: filter)
        
        XCTAssertEqual(sut.selectedFilter, filter)
        XCTAssertEqual(sut.displayModel.count, expectedCharacters.results?.count)
    }
    
    func test_paginate_fetchesMoreCharacters() async {
        let initialCharacters = MockData.characters
        let moreCharacters = MockData.moreCharacters
        let expectation1 = XCTestExpectation(description: "Initial characters loaded")
        let expectation2 = XCTestExpectation(description: "More characters loaded")
        
        var updateCount = 0
        sut.$displayModel
            .dropFirst()
            .sink { _ in
                updateCount += 1
                if updateCount == 1 {
                    expectation1.fulfill()
                } else if updateCount == 2 {
                    expectation2.fulfill()
                }
            }
            .store(in: &cancellables)
        
        mockUseCase.mockResult = .success(initialCharacters)
        await sut.viewDidLoad()
        await fulfillment(of: [expectation1], timeout: 1)
        
        mockUseCase.mockResult = .success(moreCharacters)
        await sut.paginate()
        await fulfillment(of: [expectation2], timeout: 1)
        
        let expectedTotal = (initialCharacters.results?.count ?? 0) + (moreCharacters.results?.count ?? 0)
        XCTAssertEqual(sut.displayModel.count, expectedTotal)
    }
    
    func test_actionsSubject_handlesGotoDetailAction() {
       
        let mockCharacter = PresentedDataViewModel(model: CharacterInfo(gender: "male",
                                                                               id: 0,
                                                                               image: "url1",
                                                                               name: "Rick",
                                                                               species: "Human",
                                                                               status: .Alive,
                                                                               url: "url1"))
        var receivedCallback: CharacterListViewModelCallbackType?
            
            sut = CharacterListViewModel(callback: { callbackType in
                receivedCallback = callbackType
            }, useCase: mockUseCase)
            
            sut.bindActions()
            sut.actionsSubject.send(.gotoDetail(info: mockCharacter))
            
            if case let .gotoDetail(itemInfo) = receivedCallback {
                XCTAssertEqual(itemInfo.id, mockCharacter.id)
                XCTAssertEqual(itemInfo.name, mockCharacter.name)
            } else {
                XCTFail("Expected .gotoDetail callback")
            }
        }
}
