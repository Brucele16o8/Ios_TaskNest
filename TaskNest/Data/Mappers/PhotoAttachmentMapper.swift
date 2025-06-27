//
//  PhotoAttachmentMapper.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation
import SwiftData

enum PhotoAttachmentMapper {
  static func fromDTOs(_ dtos: [PhotoAttachmentDto], subtaskMap: [UUID : SubTask]) -> [PhotoAttachment] {
    dtos.compactMap { dto in
      guard let subtask = subtaskMap[dto.subTaskId] else { return nil }
      return PhotoAttachment(
        id: dto.id,
        localPath: dto.localPath,
        remoteURL: dto.remoteURL,
        subTask: subtask
      )
    }
  }
}
