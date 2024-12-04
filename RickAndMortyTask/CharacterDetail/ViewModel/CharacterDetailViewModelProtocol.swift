//
//  CharacterDetailViewModelProtocol.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import UIKit
enum CharacterDetailViewModelCallbackType {
    case back
}

typealias CharacterDetailViewModelCallback = (CharacterDetailViewModelCallbackType) -> Void

protocol CharacterDetailViewModelProtocol: AnyObject {
    var callback: CharacterDetailViewModelCallback { get set }
    func viewDidLoad()
    func bindActions()
}
