//
//  PhotoAttachmentItem.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

import Foundation

struct PhotoAttachmentItem: Identifiable, Equatable, Sendable, Hashable {
  let id: UUID
  let localPath: String?
  let remoteURL: String?
  let subTaskID: UUID
}
