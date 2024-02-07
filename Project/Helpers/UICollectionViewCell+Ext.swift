//
//  UICollectionViewCell+Ext.swift
//  UIView.animateKeyframes crash
//
//  Created by Reqven on 07/02/2024.
//

import UIKit

extension UICollectionViewCell {
  
  func configureWith(text: String) {
    if let label = contentView.subviews.first as? UILabel {
      label.text = text
    } else {
      let label = UILabel()
      label.text = text
      label.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(label)
      
      NSLayoutConstraint.activate([
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
      ])
    }
  }
}
