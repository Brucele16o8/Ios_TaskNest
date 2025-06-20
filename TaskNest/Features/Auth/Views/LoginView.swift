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
  @Bindable private(set) var authManager: AuthManager
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
          PrimaryButton(
            title: "I'm new to TaskNest",
            icon: GoogleIcon(iconSize: 25),
            action: {
              
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
    authManager: container.resolve(AuthManager.self)!
  )
}


