//
//  ViewController+CollectionView.swift
//  UIView.animateKeyframes crash
//
//  Created by Reqven on 07/02/2024.
//

import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout {
  
  // MARK: - Setup
  func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = dataSource
    collectionView.backgroundColor = nil
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode = .onDrag
    collectionView.contentInset = Layout.contentInset
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    
    setupCollectionViewLayout()
  }
  
  func setupCollectionViewLayout() {
    let collectionViewLayout = collectionView.collectionViewLayout
    guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
    
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = Layout.contentLineSpacing
    layout.minimumInteritemSpacing = Layout.contentItemSpacing
  }
  
  // MARK: - DataSource
  func createDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Int, Int> {
    return .init(collectionView: collectionView) { _, indexPath, item in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
      cell.configureWith(text: .init(describing: indexPath))
      cell.backgroundColor = .systemBackground
      return cell
    }
  }
  
  func createSnapshot() -> NSDiffableDataSourceSnapshot<Int, Int> {
    var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
    snapshot.appendSections([0])
    snapshot.appendItems(Array(0...25))
    return snapshot
  }
  
  // MARK: - Delegate
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let contentWidth = collectionView.bounds.width - collectionView.contentInset.horizontal
    return .init(width: contentWidth, height: 50)
  }
}
