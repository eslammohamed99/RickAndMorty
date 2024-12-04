//
//  CharacterListCoordinator.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation
import UIKit
enum CharacterListCoordinatorCallbackType {
    case back
}
typealias CharacterListCoordinatorCall = ((CharacterListCoordinatorCallbackType) -> Void)
protocol CharacterListCoordinatorUseCaseProtocol {
    var window: UIWindow { get set }
}
protocol CharacterListCoordinatorProtocol: AnyObject {
    init(useCase: CharacterListCoordinatorUseCaseProtocol)
    func start()
}
