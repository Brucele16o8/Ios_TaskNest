//
//  Loginview.swift
//  TaskNest
//
//  Created by Tung Le on 15/6/2025.
//

import SwiftUI
import Swinject

struct LoginView: View {
  @ObservedObject private(set) var viewModel: LoginViewModel  
  @ObservedObject private(set) var authManager: AuthManager
  
  var body: some View {
    let loginState = viewModel.state
    
    ZStack {
      BackgroundGridView()
      
      VStack {
        LogoTitleView(title: "TaskNest", showText: loginState.showText)
        
        VStack(spacing: 16) {
          PrimaryButton(
            title: "I'm new to TaskNest",
            icon: GoogleIcon(iconSize: 25),
            action: {
              
            })
        }
        .padding(38)
      }
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


