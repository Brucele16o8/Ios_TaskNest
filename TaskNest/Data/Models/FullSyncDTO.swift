//
//  FullSyncDTO.swift
//  TaskNest
//
//  Created by Tung Le on 25/6/2025.
//

import Foundation

struct FullSyncDTO: Codable {
    let categories: [CategoryDTO]
    let tasks: [TaskItemDTO]
    let subtasks: [SubTaskDTO]
    let attachments: [PhotoAttachmentDTO]
}
