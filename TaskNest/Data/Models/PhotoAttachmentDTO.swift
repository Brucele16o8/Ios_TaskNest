//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 24/6/2025.
//

import Foundation

struct PhotoAttachmentDTO: Codable, Identifiable {
  let id: UUID
  let localPath: String?
  let remoteURL: URL?
  let subTaskId: UUID // foreign key to SubTask
}
