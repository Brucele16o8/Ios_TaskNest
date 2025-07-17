//
//  HomeViewUIState.swift
//  TaskNest
//
//  Created by Tung Le on 22/6/2025.
//

import Foundation


struct HomeViewUIState: Equatable {
  var isLoading: Bool = false
  var errorMessage: String = ""
  
  var categoryItems: [CategoryItem] = []
  var taskItemItems: [TaskItemItem] = []
  
  var searchText: String = ""
  var showSetting: Bool = false
  var showAddCategory: Bool = false
}


extension HomeViewUIState{
  func copy(
    isLoading: Bool? = nil,
    errorMessage: String? = nil,
    categories: [CategoryItem]? = nil,
    taskItems: [TaskItemItem]? = nil,
    searchText: String? = nil,
    showSetting: Bool? = nil
  ) -> HomeViewUIState
  {
    HomeViewUIState(
      isLoading: isLoading ?? self.isLoading,
      errorMessage: errorMessage ?? self.errorMessage,
      categoryItems: categories ?? self.categoryItems,
      taskItemItems: taskItems ?? self.taskItemItems,
      searchText: searchText ?? self.searchText,
      showSetting: showSetting ?? self.showSetting,
    )
  }
}
