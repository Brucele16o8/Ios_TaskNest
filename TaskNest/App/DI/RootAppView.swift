//
//  RootAppView.swift
//  TaskNest
//
//  Created by Tung Le on 16/6/2025.
//

import SwiftUI
import Swinject

struct RootAppView: View {
  @Bindable private(set) var appCoordinator: AppCoordinator
  private let container = AppDIContainer.shared.container
  
  var body: some View {
    NavigationStack(path: $appCoordinator.navigationPath){
      Group {
        switch appCoordinator.currentRootRoute {
        case .loading:
          LoadingView(loadingViewModel: container.resolve(LoadingViewModel.self)!)
            .task {
              Logger.d(tag: "RootAppView", message: "Restore session")
              await appCoordinator.restoreSession(usingAuthUseCase: container.resolve(AuthUseCase.self)!)
            }
            .transition(.opacity)
            .id("loading")
        case .auth:
            LoginView(
              viewModel: container.resolve(LoginViewModel.self)!,
              appCoordinator: appCoordinator
            )
            .transition(.slide)
            .id("auth")
        case .main:
          HomeView(
            homeViewModel: container.resolve(HomeViewModel.self)!,
            appCoordinator: container.resolve(AppCoordinator.self)!
          )
          .transition(.slide)
          .id("main")
        }
      }
      .animation(.easeInOut(duration: 0.3), value: appCoordinator.currentRootRoute)
      
      .navigationDestination(for: AppRoute.self) { appRoute in
        switch appRoute {
        case .auth(let authRoute):
          switch authRoute {
          case .login:
            LoginView(
              viewModel: container.resolve(LoginViewModel.self)!,
              appCoordinator: appCoordinator
            )
          case .signUp:
            SignUpView(
              viewModel: container.resolve(SignUpViewModel.self)!,
              appCoordinator: appCoordinator
            )
          case .forgotPassword:
            ForgotPasswordView(
              viewModel: container.resolve(ForgotPasswordViewModel.self)!
            )
          }
        case .home:
          HomeView(
            homeViewModel: container.resolve(HomeViewModel.self)!,
            appCoordinator: appCoordinator
          )
        case .category(let categoryItem):
          let categoryDetailViewModel = container.resolve(CategoryDetailViewModel.self, argument: categoryItem)!
          CategoryDetailView(
            viewModel: categoryDetailViewModel
          )
        case .taskDetail(taskItem: let taskItem):
          let taskItemDetailViewModel = container.resolve(TaskItemDetailViewModel.self, argument: taskItem)!
          TaskItemDetailView(
            viewModel: taskItemDetailViewModel
          )
          
          
        case .photoViewer(let startingAt, let photoItems):
          PhotoViewerView(startIndex: startingAt, photos: photoItems)
        }
      }
      .transition(.slide)
    }
  }
}

#Preview {
  RootAppView(appCoordinator: AppDIContainer.shared.container.resolve(AppCoordinator.self)!)
}
