//
//  TaskModelActor.swift
//  TaskNest
//
//  Created by Tung Le on 3/7/2025.
//

import Foundation
import SwiftData

protocol TaskItemLocalDb {

    func getAllTaskEntities() async throws -> [TaskItemEntity]
    func getTaskItemEntity(byId id: UUID) async throws -> TaskItemEntity
    func saveTaskItemEntity(_ taskItemEntity: TaskItemEntity) async throws
    func updateTaskItemEntity(_ taskItemEntity: TaskItemEntity) async throws
    func deleteTaskItemEntity(id: UUID) async throws
    func getTaskItemEntities(byCategoryEntityId id: UUID) async throws -> [TaskItemEntity]

} // 🧱
