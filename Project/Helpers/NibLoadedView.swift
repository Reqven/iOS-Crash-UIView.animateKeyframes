//
//  NibLoadedView.swift
//  UIView.animateKeyframes crash
//
//  Created by Reqven on 07/02/2024.
//

import UIKit

protocol NibLoadedView: AnyObject {
  static var nibName: String { get }
  static var bundle: Bundle { get }
}

extension NibLoadedView {
  static var nibName: String { String(describing: self) }
  static var bundle: Bundle { Bundle(for: self) }
  
  static var nib: UINib {
    UINib(nibName: nibName, bundle: bundle)
  }
}

extension NibLoadedView {
  static func loadFromNib() -> Self {
    Self.nib.instantiate(withOwner: nil, options: nil).first as! Self
  }
}
