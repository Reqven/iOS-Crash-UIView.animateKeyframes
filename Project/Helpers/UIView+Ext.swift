//
//  UIView+Ext.swift
//  UIView.animateKeyframes crash
//
//  Created by Reqven on 07/02/2024.
//

import UIKit

extension UIView.KeyframeAnimationOptions {
  init(animationOptions: UIView.AnimationOptions) {
    self.init(rawValue: animationOptions.rawValue)
  }
}
