//
//  ViewController+Layout.swift
//  UIView.animateKeyframes crash
//
//  Created by Reqven on 07/02/2024.
//

import UIKit

extension ViewController {
  
  enum Layout {
    // MARK: - Constants
    static let animationDuration: CGFloat = 0.3
    static let contentLineSpacing: CGFloat = 10
    static let contentItemSpacing: CGFloat = 10
    static let contentInset: UIEdgeInsets = .init(insets: 20)
    static let searchBarHorizontalInset: CGFloat = 20
    static let searchBarTextFont: UIFont = .systemFont(ofSize: 14, weight: .medium)
    static let searchBarCancelButtonFont: UIFont = .systemFont(ofSize: 14, weight: .semibold)
    static let extendedNavBarItemSpacing: CGFloat = 10
    static let extendedNavBarVerticalInset: CGFloat = 15
    
    static var cancelButtonAnimationOptions: UIView.KeyframeAnimationOptions {
      .init(animationOptions: .init([.curveEaseInOut, .beginFromCurrentState, .allowUserInteraction]))
    }
  }
}

// MARK: -
extension ViewController {
  var searchContainerHeight: CGFloat {
    let searchContainerVerticalMargin = searchContainerView.layoutMargins.vertical
    let searchBarHeight = searchBar.intrinsicContentSize.height
    return searchContainerVerticalMargin + searchBarHeight
  }
  
  func extendedNavBarHeight(with itemsHeight: [CGFloat]) -> CGFloat {
    let verticalMargin = extendedNavBarContainerView.layoutMargins.vertical
    let itemSpacing = extendedNavBarContainerView.spacing * CGFloat(max(0, itemsHeight.count - 1))
    return (itemsHeight + [itemSpacing, verticalMargin]).reduce(0, +)
  }
}

// MARK: -
extension ViewController {
  func showExtendedNavBar() {
    let itemsHeight = [/*adContainerHeight,*/ searchContainerHeight]
    let extendedNavBarHeight = extendedNavBarHeight(with: itemsHeight)
    extendedNavBarContainerView.isHidden = false
    
    UIView.animate(withDuration: Layout.animationDuration) {
      self.additionalSafeAreaInsets.top = extendedNavBarHeight
      self.view.layoutIfNeeded()
    }
  }
  
  func hideExtendedNavBar() {
    UIView.animate(withDuration: Layout.animationDuration) {
      self.additionalSafeAreaInsets.top = 0
      self.view.layoutIfNeeded()
    } completion: { _ in
      self.extendedNavBarContainerView.isHidden = true
    }
  }
  
  func showSearchBarCancelButton() {
    let duration = Layout.animationDuration
    let options = Layout.cancelButtonAnimationOptions
    
    UIView.animateKeyframes(withDuration: duration, delay: 0, options: options, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
        self.cancelButton.isHidden = false
        self.cancelButton.superview?.layoutIfNeeded()
      })
      UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
        self.cancelButton.alpha = 1
      })
    })
  }
  
  func hideSearchBarCancelButton() {
    let duration = Layout.animationDuration
    let options = Layout.cancelButtonAnimationOptions
    
    UIView.animateKeyframes(withDuration: duration, delay: 0, options: options, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
        self.cancelButton.isHidden = true
        self.cancelButton.superview?.layoutIfNeeded()
      })
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {
        self.cancelButton.alpha = 0
      })
    })
  }
}

