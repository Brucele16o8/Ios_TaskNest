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
  @State private var appCoordinator = AppDIContainer.shared.container.resolve(AppCoordinator.self)!
  let container = AppDIContainer.shared.container
  
  var body: some View {
    NavigationStack(path: $appCoordinator.path) {
      Group {
        switch authManager.authState {
        case .checking, .authenticating:
          LoadingView(loadingViewModel: container.resolve(LoadingViewModel.self)!)
          
        case .authenticated:
          HomeView(
            homeViewModel: HomeViewModel(
              authManager: container.resolve(AuthManager.self)!,
              authUseCase: container.resolve(AuthUseCase.self)!,
              appCoordinator: container.resolve(AppCoordinator.self)!,
              getAllCategoriesUseCase: container.resolve(GetAllCategoryEntitiesUseCase.self)!,
              deleteCategoryUseCase: container.resolve(DeleteCategoryEntityUseCase.self)!
            )
          )
          
        case .unauthenticated:
          LoginView(
            viewModel: container.resolve(LoginViewModel.self)!,
            appCoordinator: container.resolve(AppCoordinator.self)!
          )
        }
      }
      
      .navigationDestination(for: AppRoute.self) { route in
        switch route {
        case .auth(let authRoute):
          switch authRoute {
          case .login:
            LoginView(
              viewModel: container.resolve(LoginViewModel.self)!,
              appCoordinator: container.resolve(AppCoordinator.self)!
            )
          case .forgotPassword:
            ForgotPasswordView()
          case .signUp:
            SignUpView()
          }
        case .home:
          HomeView(
            homeViewModel: HomeViewModel(
              authManager: container.resolve(AuthManager.self)!,
              authUseCase: container.resolve(AuthUseCase.self)!,
              appCoordinator: container.resolve(AppCoordinator.self)!,
              getAllCategoriesUseCase: container.resolve(GetAllCategoryEntitiesUseCase.self)!,
              deleteCategoryUseCase: container.resolve(DeleteCategoryEntityUseCase.self)!
            )
          )
        case .category(categoryItem: let categoryItem):
          CategoryDetailView(category: categoryItem)
        case .photoViewer(startingAt: let index, photos: let photos):
          PhotoViewerView(startingIndex: index, photos: photos)
        }
      }
    }
  }
}

#Preview {
  RootAppView()
}
