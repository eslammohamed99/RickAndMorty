//
//  CharacterListViewProtocol.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation


protocol CharacterListViewProtocol: AnyObject {
    var viewModel: CharacterListViewModelProtocol? { get set }
}
