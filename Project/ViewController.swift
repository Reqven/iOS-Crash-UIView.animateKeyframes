//
//  ViewController.swift
//  UIView.animateKeyframes crash
//
//  Created by Reqven on 07/02/2024.
//

import UIKit

class ViewController: UICollectionViewController {
  
  // MARK: - Properties
  lazy var searchContainerView = UIStackView()
  lazy var searchBar = CustomSearchBar.loadFromNib()
  lazy var cancelButton = UIButton(type: .system)
  lazy var extendedNavBarContainerView = UIStackView()
  lazy var dataSource = createDataSource(for: collectionView)
  lazy var activityIndicator = UIActivityIndicatorView(style: .large)
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupSearchBar()
    setupNavigationBar()
    setupCollectionView()
    setupActivityIndicator()

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.showExtendedNavBar()
      self.activityIndicator.stopAnimating()
      self.dataSource.apply(self.createSnapshot())
    }
  }
  
  // MARK: - Setup
  private func setupView() {
    view.backgroundColor = .secondarySystemBackground
  }
  
  private func setupSearchBar() {
    searchBar.layoutMargins = .zero
    searchBar.backgroundColor = .clear
    searchBar.searchTextField.autocorrectionType = .no
    searchBar.searchTextField.delegate = self
    searchBar.searchTextField.placeholder = "Search"
    searchBar.searchTextField.font = Layout.searchBarTextFont
    
    cancelButton.alpha = 0
    cancelButton.isHidden = true
    cancelButton.setTitleColor(.secondaryLabel, for: .normal)
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.titleLabel?.font = Layout.searchBarCancelButtonFont
    cancelButton.setContentHuggingPriority(.required, for: .horizontal)
    cancelButton.addTarget(self, action: #selector(cancelSearch), for: .touchUpInside)
    
    searchContainerView.spacing = 10
    searchContainerView.axis = .horizontal
    searchContainerView.alignment = .center
    searchContainerView.distribution = .fill
    searchContainerView.insetsLayoutMarginsFromSafeArea = false
    searchContainerView.isLayoutMarginsRelativeArrangement = true
    searchContainerView.layoutMargins = .init(horizontalInset: Layout.searchBarHorizontalInset)
    
    searchContainerView.addArrangedSubview(searchBar)
    searchContainerView.addArrangedSubview(cancelButton)
  }
  
  private func setupNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemBackground
    
    navigationItem.standardAppearance = appearance
    navigationItem.compactAppearance = appearance
    navigationItem.scrollEdgeAppearance = appearance
    
    extendedNavBarContainerView.isHidden = true
    extendedNavBarContainerView.axis = .vertical
    extendedNavBarContainerView.alignment = .fill
    extendedNavBarContainerView.distribution = .fill
    extendedNavBarContainerView.backgroundColor = .systemBackground
    extendedNavBarContainerView.insetsLayoutMarginsFromSafeArea = false
    extendedNavBarContainerView.isLayoutMarginsRelativeArrangement = true
    extendedNavBarContainerView.spacing = Layout.extendedNavBarItemSpacing
    extendedNavBarContainerView.layoutMargins = .init(verticalInset: Layout.extendedNavBarVerticalInset)
    extendedNavBarContainerView.translatesAutoresizingMaskIntoConstraints = false
    
    extendedNavBarContainerView.addArrangedSubview(searchContainerView)
    view.addSubview(extendedNavBarContainerView)
    
    NSLayoutConstraint.activate([
      extendedNavBarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      extendedNavBarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      extendedNavBarContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    ])
  }
  
  private func setupActivityIndicator() {
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(activityIndicator)
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  // MARK: - Actions
  @objc func cancelSearch() {
    searchBar.searchTextField.resignFirstResponder()
    searchBar.searchTextField.text = .init()
    hideSearchBarCancelButton()
  }
}

// MARK: -
extension ViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    showSearchBarCancelButton()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}
