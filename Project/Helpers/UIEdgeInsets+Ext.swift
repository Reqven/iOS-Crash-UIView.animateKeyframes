//
//  UIEdgeInsets+Ext.swift
//  UIView.animateKeyframes crash
//
//  Created by Reqven on 07/02/2024.
//

import UIKit

extension UIEdgeInsets {
  var horizontal: CGFloat { self.left + self.right }
  var vertical: CGFloat { self.top + self.bottom }
  
  init(insets: CGFloat) {
    self.init(
      top: insets,
      left: insets,
      bottom: insets,
      right: insets
    )
  }
  
  init(insets: [Self]) {
    self.init(
      top: insets.map { $0.top }.reduce(0, +),
      left: insets.map { $0.left }.reduce(0, +),
      bottom: insets.map { $0.bottom }.reduce(0, +),
      right: insets.map { $0.right }.reduce(0, +)
    )
  }
  
  init(verticalInset: CGFloat = 0, horizontalInset: CGFloat = 0) {
    self.init(
      top: verticalInset,
      left: horizontalInset,
      bottom: verticalInset,
      right: horizontalInset
    )
  }
}
