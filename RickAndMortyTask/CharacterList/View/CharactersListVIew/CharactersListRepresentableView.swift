//
//  CharactersListRepresentableView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation
import UIKit
import SwiftUI

struct CharactersListRepresentableView: UIViewRepresentable {
    var viewModel: CharacterListViewModel
    var actionCallback: ((PresentedDataViewModel) -> Void)?
    
    func makeUIView(context: Context) -> UIView {
        let uiView = CharacterListTableView(
            frame: .zero,
            viewModel: viewModel
        )
        uiView.backgroundColor = .clear
        uiView.didTap = actionCallback
        return uiView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
