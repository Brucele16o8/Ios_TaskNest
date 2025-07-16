//
//  PhotoAttachmentItem.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

import SwiftUI

struct PhotoAttachmentItem: Identifiable, Equatable, Sendable, Hashable {
  let id: UUID
  let localPath: String?
  let remoteURL: String?
  let subTaskID: UUID
}

// MARK: - Extensions
extension PhotoAttachmentItem {
  var fullImage: UIImage? {
    guard let localPath else { return nil }
    return UIImage(contentsOfFile: localPath)
  }
  
  var thumbnail: UIImage? {
    guard let fullImage else { return nil }
    return fullImage.resizeToThumbnail()
  }
}

