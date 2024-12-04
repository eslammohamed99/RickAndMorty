//
//  CharacterDetailUIView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import SwiftUI
import Kingfisher

struct CharacterDetailUIView: View {
    let viewModel: CharacterDetailViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    CharacterImageSectionView(
                        size: geometry.size,
                        image: URL(string: viewModel.displayModel.image)
                    )
                    
                    CharacterDetailSectionView(character: viewModel.displayModel)
                }
                
                CustomNavigationBar {
                    viewModel.actionsSubject.send(.back)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct CustomNavigationBar: View {
    let onBackTap: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onBackTap) {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 40)
                        .shadow(radius: 2)
                    
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .frame(width: 20, height: 15)
                        .foregroundStyle(.black)
                }
            }
            .padding(.leading, 16)
            
            Spacer()
        }
        .frame(height: 90)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
    }
}
