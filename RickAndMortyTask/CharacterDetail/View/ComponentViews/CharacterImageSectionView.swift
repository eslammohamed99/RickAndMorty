//
//  CharacterImageSectionView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import SwiftUI
import Kingfisher

struct CharacterImageSectionView: View {
    let size: CGSize
    let image: URL?
    var body: some View {
        KFImage(image)
            .resizable()
            .scaledToFill()
            .frame(width: size.width, height: size.height * 0.4)
            .cornerRadius(25)
        
    }
}
