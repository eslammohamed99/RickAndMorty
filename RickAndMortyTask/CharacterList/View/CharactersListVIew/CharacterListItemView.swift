//
//  characterListItemView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//


import UIKit
import SwiftUI
import Kingfisher


struct CharacterCellView: View {
    let character: PresentedDataViewModel
    
    var body: some View {
        HStack(spacing: 15) {
            KFImage(URL(string: character.image))
                            .resizable()
                            .placeholder {
                                ProgressView()
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Text(character.species)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.lightGray).opacity(0.5), lineWidth: 1)
        )
       // .padding(.horizontal, 8)
      //  .padding(.vertical, 8)
    }
}

class CharacterListItemView: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with character: PresentedDataViewModel) {
        contentConfiguration = UIHostingConfiguration {
            CharacterCellView(character: character)
        }
    }
}


struct CachedAsyncImage: View {
    let url: URL?
    
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.gray.opacity(0.3)
            }
        }
        .onAppear {
            imageLoader.load(url: url)
        }
        .frame(width: 90, height: 90)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private static var cache = NSCache<NSString, UIImage>()
    
    func load(url: URL?) {
        guard let url = url else { return }
        let key = url.absoluteString as NSString
        
        if let cachedImage = Self.cache.object(forKey: key) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                Self.cache.setObject(image, forKey: key)
                self.image = image
            }
        }.resume()
    }
}
