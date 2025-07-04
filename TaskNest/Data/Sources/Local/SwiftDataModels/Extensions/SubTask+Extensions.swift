//
//  SubTask+Extensions.swift
//  TaskNest
//
//  Created by Tung Le on 2/7/2025.
//

/*
 @Model
 class SubTask: Identifiable {
   @Attribute(.unique) var id: UUID
   var title: String
   var isCompleted: Bool
   var createdAt: Date
   @Relationship(inverse: \TaskItem.subTasks) var task: TaskItem? /// for inverse relationship
   @Relationship(deleteRule: .cascade) var photoAttachments: [PhotoAttachment] = []
 
*/

extension SubTask {
  
  // ✅
  func applyIfChanged(fromSubTaskEntity subTaskEntity: SubTaskEntity, newTaskItem: TaskItem? = nil) -> Bool {
    var didChange = false
    
    if self.title != subTaskEntity.title {
      self.title = subTaskEntity.title
      didChange = true
    }
    
    if self.isCompleted != subTaskEntity.isCompleted {
      self.isCompleted = subTaskEntity.isCompleted
      didChange = true
    }
    
    if self.createdAt != subTaskEntity.createdAt {
      self.createdAt = subTaskEntity.createdAt
      didChange = true
    }
    
    if newTaskItem != nil {
      self.taskItem = newTaskItem
      didChange = true
    }
    
    return didChange
  }
  
} // 🧱

// MARK: - Preview Data
extension SubTask {
  static let subTask1 = SubTask(title: "SubTask 1", isCompleted: false, taskItem: .taskItem1)
  static let subTask2 = SubTask(title: "SubTask 2", isCompleted: true, taskItem: .taskItem1)
  static let subTask3 = SubTask(title: "SubTask 1", isCompleted: true, taskItem: .taskItem2)
  
  static var all: [SubTask] = [subTask1, subTask2, subTask3]
}
