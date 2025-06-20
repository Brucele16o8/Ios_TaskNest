//
//  RootAppView.swift
//  TaskNest
//
//  Created by Tung Le on 16/6/2025.
//

import SwiftUI
import Swinject

struct RootAppView: View {
  @State private var authManager = AppDIContainer.shared.container.resolve(AuthManager.self)!
  let container = AppDIContainer.shared.container
  
  var body: some View {
    switch authManager.authState {
    case .checking, .authenticating:
      LoadingView(loadingViewModel: container.resolve(LoadingViewModel.self)!)
    case .authenticated:
      HomeView()
    case .unauthenticated:
      LoginView(
        viewModel: container.resolve(LoginViewModel.self)!,
        authManager: container.resolve(AuthManager.self)!
      )
    }
  }
}

#Preview {
  RootAppView()
}
