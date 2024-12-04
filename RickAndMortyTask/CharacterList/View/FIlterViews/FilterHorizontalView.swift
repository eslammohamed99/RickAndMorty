//
//  FilterHorizontalView.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import UIKit
import Combine


class FilterHorizontalView: UIView {
    var filteredArray = RemoteFilterStatus.allCases
    var collectionView: UICollectionView
    var cellId = "Cell"
    private var cancellables = Set<AnyCancellable>()
    
    weak var viewModel: CharacterListViewModel!

    init(frame: CGRect, viewModel: CharacterListViewModel) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        super.init(frame: frame)
        self.viewModel = viewModel
        setupCollectionView()
        bindViewModel()
    }
    
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
    }
    
    private func bindViewModel() {
        viewModel.$displayModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension FilterHorizontalView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell()}
        cell.configure(
            with: filteredArray[indexPath.item].rawValue,
            selectedFilter: viewModel.selectedFilter ?? ""
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.actionsSubject.send(.fetchStatus(status: filteredArray[indexPath.item].rawValue))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellText = filteredArray[indexPath.item].rawValue
        
        let cellWidth = cellText.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]).width + 20
        return CGSize(width: cellWidth, height: collectionView.frame.height)
    }
}
