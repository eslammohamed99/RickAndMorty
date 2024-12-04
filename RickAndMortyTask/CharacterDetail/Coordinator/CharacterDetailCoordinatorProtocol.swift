//
//  CharacterDetailCoordinatorProtocol.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//



import Foundation
import UIKit
enum CharacterDetailCoordinatorCallbackType {
    case back
}
typealias CharacterDetailCoordinatorCall = ((CharacterDetailCoordinatorCallbackType) -> Void)
protocol CharacterDetailCoordinatorUseCaseProtocol {
    var navigationController: UINavigationController { get set }
    var characterInfo: PresentedDataViewModel { get }
}
protocol CharacterDetailCoordinatorProtocol: AnyObject {
    init(useCase: CharacterDetailCoordinatorUseCaseProtocol)
    func start(callback: @escaping CharacterDetailCoordinatorCall)
}

