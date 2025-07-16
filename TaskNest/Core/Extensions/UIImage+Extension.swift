//
//  UIImage+Extension.swift
//  TaskNest
//
//  Created by Tung Le on 16/7/2025.
//

import SwiftUI

extension UIImage {
  func resizeToThumbnail(maxSize: CGFloat = 100) -> UIImage {
    let aspectRatio = size.width / size.height
    let targetSize: CGSize
    if aspectRatio > 1 {
      targetSize = CGSize(width: maxSize, height: maxSize / aspectRatio)
    } else {
      targetSize = CGSize(width: maxSize * aspectRatio, height: maxSize)
    }
    
    let renderer = UIGraphicsImageRenderer(size: targetSize)
    return renderer.image { _ in
      self.draw(in: CGRect(origin: .zero, size: targetSize))
    }
  }
}
