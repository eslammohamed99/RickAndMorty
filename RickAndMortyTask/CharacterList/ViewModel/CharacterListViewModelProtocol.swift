//
//  CharacterListViewModelProtocol.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation


enum CharacterListViewModelCallbackType {
    case back
    case gotoDetail(itemInfo:PresentedDataViewModel)
}

typealias CharacterListViewModelCallback = (CharacterListViewModelCallbackType) -> Void

protocol CharacterListViewModelProtocol: AnyObject {
    var callback: CharacterListViewModelCallback { get set }
    func viewDidLoad()
    func bindActions()
    func toggleLoading(_ bool: Bool)
}
