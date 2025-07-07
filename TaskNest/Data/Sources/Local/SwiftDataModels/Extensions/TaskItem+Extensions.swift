//
//  TaskItem+Extensions.swift
//  TaskNest
//
//  Created by Tung Le on 4/7/2025.
//

extension TaskItem {
  // ✅
  func applyIfChanged(fromTaskItemEntity taskItemEntity: TaskItemEntity, newCategory: Category? = nil) -> Bool {
    var didChange = false
    
    if self.title != taskItemEntity.title {
      self.title = taskItemEntity.title
      didChange = true
    }
    
    if self.isCompleted != taskItemEntity.isCompleted {
      self.isCompleted = taskItemEntity.isCompleted
      didChange = true
    }
    
    if self.createdAt != taskItemEntity.createdAt {
      self.createdAt = taskItemEntity.createdAt
      didChange = true
    }
    
    if newCategory != nil {
      self.category = newCategory
      didChange = true
    }
    
    return didChange
  }
  
} // 🧱

// MARK: - Preview Data
extension TaskItem {
  static var empty: TaskItem {
    .init(title: "", userId: "")
  }
}

extension TaskItem {
  static let taskItem1 = TaskItem(title: "Task 1", isCompleted: false, category: .work, userId: "116688")
  static let taskItem2 = TaskItem(title: "Task 2", isCompleted: false, category: .work, userId: "116688")
  static let taskItem3 = TaskItem(title: "Task 3", isCompleted: false, category: .work, userId: "116688")
  static let taskItem4 = TaskItem(title: "Task 1", isCompleted: false, category: .personal, userId: "116688")
  static let taskItem5 = TaskItem(title: "Task 2", isCompleted: false, category: .personal, userId: "116688")
  
  static var all: [TaskItem] = [taskItem1, taskItem2, taskItem3, taskItem4, taskItem5]
}
