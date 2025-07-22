//
//  TaskItemDetailViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 22/7/2025.
//

import SwiftUI

@MainActor
@Observable
final class TaskItemDetailViewModel {
  let taskItem: TaskItemItem
  let appCoordinatoor: AppCoordinator
  
  init(
    taskItem: TaskItemItem,
    appCoordinatoor: AppCoordinator
  ) {
    self.taskItem = taskItem
    self.appCoordinatoor = appCoordinatoor
  }
  
  
  
} // 🧱
