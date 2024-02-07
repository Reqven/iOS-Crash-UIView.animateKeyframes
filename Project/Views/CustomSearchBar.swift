//
//  CustomSearchBar.swift
//  UIView.animateKeyframes crash
//
//  Created by Reqven on 07/02/2024.
//

import UIKit

class CustomSearchBar: UIView {
  
  // MARK: - IBOutlets
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var searchTextField: UITextField!
  
  // MARK: - Properties
  override var intrinsicContentSize: CGSize {
    let inset = UIEdgeInsets(insets: [layoutMargins, backgroundView.layoutMargins])
    let height = inset.vertical + searchTextField.intrinsicContentSize.height
    return .init(width: UIView.noIntrinsicMetric, height: height)
  }
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  // MARK: - Setup
  private func setupView() {
    backgroundView.layer.cornerRadius = 10
  }
  
  // MARK: - Actions
  @IBAction func onSearchBarTap(_ sender: Any) {
    searchTextField.becomeFirstResponder()
  }
}

extension CustomSearchBar: NibLoadedView {}
