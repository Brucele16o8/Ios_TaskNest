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
  
  // State
  private(set) var errorPresenter: AlertErrorPresenter
  
  private let appCoordinator: AppCoordinator
  
  init(
    taskItem: TaskItemItem,
    appCoordinator: AppCoordinator,
    errorPresenter: AlertErrorPresenter
  ) {
    self.taskItem = taskItem
    self.appCoordinator = appCoordinator
    self.errorPresenter = errorPresenter
  }  
  
  // ✅
  func goBack() {
    appCoordinator.goBack()
  }
} // 🧱
