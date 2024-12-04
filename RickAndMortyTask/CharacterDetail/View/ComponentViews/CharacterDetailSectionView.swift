//
//  CharacterDetailSectionView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import SwiftUI

struct CharacterDetailSectionView: View {
    
    let character: PresentedDataViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(character.name)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    HStack {
                        Text(character.species)
                            .foregroundStyle(.black)
                        Circle()
                            .fill(.black)
                            .frame(width: 5,height: 5)
                        Text(character.gender)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                Text(character.status.rawValue)
                    .font(.title2)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background {
                        Capsule()
                            .fill(.blue.opacity(0.5))
                    }
            }
            .padding()
            HStack(alignment: .top){
                Text("Location :")
                    .fontWeight(.bold)
                    .font(.title2)
                Text(character.location.name)
                    .foregroundStyle(.black.opacity(0.7))
                    .font(.title2)
            }
            .padding(.horizontal)
        }
    }
}

