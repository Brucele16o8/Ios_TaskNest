//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation

struct PhotoAttachmentDto: Codable, Identifiable {
  let id: UUID
  let localPath: String?
  let remoteURL: URL?
  let subTaskId: UUID // foreign key to SubTask
}
