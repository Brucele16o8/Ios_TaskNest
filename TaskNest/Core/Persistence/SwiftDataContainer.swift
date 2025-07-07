//
//  SwiftDataContainer.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataContainer {
  static let shared = SwiftDataContainer()
  
  let container: ModelContainer
  
  private init() {
    do {
      Logger.d(tag: "SwiftDataContainer", message: "Inside SwiftDataContainer Initializer...")
      
      container = try ModelContainer(
        for: Category.self, TaskItem.self, SubTask.self, PhotoAttachment.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: false)
      )
      
      Logger.d(tag: "SwiftDataContainer", message: "SwiftDataContainer created successfully.")
    } catch {
      fatalError("❌ Failed to create SwiftData container: \(error)")
    }
  }
}
 
