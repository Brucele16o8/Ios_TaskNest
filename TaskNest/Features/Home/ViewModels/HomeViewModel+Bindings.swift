//
//  HomeViewModel+Binding.swift
//  TaskNest
//
//  Created by Tung Le on 1/7/2025.
//

import SwiftUI

// MARK: - Binding
extension HomeViewModel {
  var showSettingsBinding: Binding<Bool> {
    Binding (
      get: { self.homeViewState.showSetting },
      set: { self.updateShowSetting($0) }
    )
  }

  var searchTextBinding: Binding<String> {
    Binding (
      get: { self.homeViewState.searchText },
      set: { self.updateSearchText($0)}
    )
  }
}
