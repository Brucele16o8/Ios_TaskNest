//
//  CategoryDetailUiState.swift
//  TaskNest
//
//  Created by Tung Le on 16/7/2025.
//

struct CategoryDetailUiState: Equatable {
  var isLoading: Bool = false
  var errorMessage: String = ""
  var taskItems: [TaskItemItem] = []
  var newTaskTitle: String = ""
}
