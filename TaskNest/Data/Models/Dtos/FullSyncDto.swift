//
//  FullSyncDTO.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation

struct FullSyncDTO: Codable {
    let categories: [CategoryDto]
    let tasks: [TaskItemDto]
    let subtasks: [SubTaskDto]
    let attachments: [PhotoAttachmentDto]
}
