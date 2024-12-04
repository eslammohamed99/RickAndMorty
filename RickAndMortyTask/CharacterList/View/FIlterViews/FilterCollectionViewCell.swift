//
//  FilterCollectionViewCell.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation
import UIKit
import SwiftUI

struct FilterCellView: View {
    let text: String
    let isSelected: Bool
    
    var body: some View {
        Text(text).fixedSize()
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .foregroundColor(isSelected ? .orange : .black)
            .background(
                Capsule()
                    .stroke(Color(isSelected ? .orange : .lightGray), lineWidth: 1)
            )
    }
}

class FilterCollectionViewCell: UICollectionViewCell {
    static let reuseId = "FilterCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String, selectedFilter: String?) {
        contentConfiguration = UIHostingConfiguration {
            FilterCellView(text: text, isSelected: selectedFilter == text)
        }
    }
}
