//
//  Loginview.swift
//  TaskNest
//
//  Created by Tung Le on 15/6/2025.
//

import SwiftUI
import Swinject

struct LoginView: View {
  @Bindable private(set) var viewModel: LoginViewModel
  @Bindable private(set) var appCoordinator: AppCoordinator
  @State private var showfForgotPasswordView: Bool = false
  
  var body: some View {
    let loginState = viewModel.state
    
    ZStack {
      BackgroundGridView()
      
      VStack {
        Spacer()
        LogoTitleView(title: "TaskNest", showText: loginState.showText)
        Spacer()
        Spacer()
        VStack(spacing: 16) {
          TextFieldFormGeneral(
            title: "Email",
            bindingText: viewModel.emailBinding,
            keyboardType: .emailAddress
          )
          TextFieldFormPassword(
            title: "Password",
            bindingPassword: viewModel.passwordBinding,
          )
          Spacer()
            .frame(height: 10)
          PrimaryButton<Image>(
            title: "Sign in",
            icon: nil,
            action: {
              viewModel.loginWithEmailAndPassword()
            })
          
          HStack {
            Divider()
              .frame(height: 1)
              .frame(maxWidth: .infinity)
              .background(.gray)
            Text("Or")
              .foregroundStyle(.white)
            Divider()
              .frame(height: 1)
              .frame(maxWidth: .infinity)
              .background(.gray)
          }
          .padding(.vertical, 32)
          
          PrimaryButton(
            title: "Sign in with Google",
            icon: GoogleIcon(iconSize: 25),
            action: {
              viewModel.loginWithGoogle()
            })
        }
        .padding(.horizontal, 32)
      }
    }
    .task {
      viewModel.startAnimation()
    }
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  LoginView(
    viewModel: container.resolve(LoginViewModel.self)!,
//    authManager: container.resolve(AuthManager.self)!,
    appCoordinator: container.resolve(AppCoordinator.self)!
  )
}


