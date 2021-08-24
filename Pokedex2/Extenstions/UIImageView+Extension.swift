//
//  UIImageView+Extension.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 08/07/2021.
//

import Foundation
import UIKit
extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
