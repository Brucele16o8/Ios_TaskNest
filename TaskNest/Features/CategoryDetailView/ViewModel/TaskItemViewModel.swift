//
//  t.swift
//  TaskNest
//
//  Created by Tung Le on 16/7/2025.
//

import Foundation

@Observable
final class TaskItemViewModel {
  let taskItem: TaskItemItem
  
  private(set) var subTaskItemViewModels: [SubTaskItemViewModel] = []
  
  init(taskItem: TaskItemItem) {
    self.taskItem = taskItem
  }
  
  
  
} // 🧱
