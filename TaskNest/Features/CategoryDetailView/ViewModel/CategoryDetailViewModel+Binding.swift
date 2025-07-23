//
//  CategoryDetailViewModel+Binding.swift
//  TaskNest
//
//  Created by Tung Le on 22/7/2025.
//

import SwiftUI

extension CategoryDetailViewModel {
  var newTaskTitleBinding: Binding<String> {
    Binding (
      get: { self.categoryDetailUiState.newTaskTitle },
      set: { self.updateNewTaskItemTitle($0) }
    )
  }
}
