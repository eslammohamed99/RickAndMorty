//
//  FilterRepresentableView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation
import UIKit
import SwiftUI

struct FilterRepresentableView: UIViewRepresentable {
    var viewModel: CharacterListViewModel
    var height: CGFloat = 40
    
    func makeUIView(context: Context) -> UIView {
        let uiView = FilterHorizontalView(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height),
            viewModel: viewModel
        )
        uiView.backgroundColor = .clear
        return uiView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        uiView.backgroundColor = .clear
    }
}
