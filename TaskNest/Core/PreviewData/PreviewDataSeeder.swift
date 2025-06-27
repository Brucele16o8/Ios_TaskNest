//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation
import SwiftData

struct PreviewDataSeeder {
  static func seed() async throws {
    let context = await ModelContext(SwiftDataContainer.shared.container)
    
    // Clear existing data (for fresh start)
    try await context.deleteAll(TaskItem.self)
    try await context.deleteAll(Category.self)
    try await context.deleteAll(SubTask.self)
    try await context.deleteAll(PhotoAttachment.self)
    
    // Insert preview categories
    let categories = Category.all
    for category in categories {
      context.insert(category)
    }
    
    // Insert tasks and link them to categories
    let tasks = TaskItem.all
    for task in tasks {
      context.insert(task)
    }
    
    // Insert subtasks
    let subtasks = SubTask.all
    for sub in subtasks {
      context.insert(sub)
    }
    
    // Insert photos
    let photos = PhotoAttachment.all
    for photo in photos {
      context.insert(photo)
    }
    
    try context.save()
  }
}
