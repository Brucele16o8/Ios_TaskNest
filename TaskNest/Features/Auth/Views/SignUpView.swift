//
//  SignUpView.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftUI
import Swinject

struct SignUpView: View {
  @Bindable private(set) var viewModel: SignUpViewModel
  @Bindable private(set) var appCoordinator: AppCoordinator
  
  var body: some View {
    let state = viewModel.state
    
    ZStack {
      BackgroundGridView()
      
      VStack {
        Spacer()
        
        LogoTitleView(title: "Create Account", size: 38, showText: state.showText)
        
        VStack(spacing: 16) {
          
          // ✅ Email field + error
          TextFieldFormGeneral(
            title: "Email",
            bindingText: viewModel.emailBinding,
            keyboardType: .emailAddress
          )
          
          if !state.emailError.isEmpty {
            Text(state.emailError)
              .foregroundColor(.red)
              .font(.caption)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          // ✅ Password field + error
          TextFieldFormPassword(
            title: "Password",
            bindingPassword: viewModel.passwordBinding
          )
          
          if !state.passwordError.isEmpty {
            Text(state.passwordError)
              .foregroundColor(.red)
              .font(.caption)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          // ✅ Confirm password + error
          TextFieldFormPassword(
            title: "Confirm Password",
            bindingPassword: viewModel.confirmPasswordBinding
          )
          
          if !state.confirmPasswordError.isEmpty {
            Text(state.confirmPasswordError)
              .foregroundColor(.red)
              .font(.caption)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          // ✅ Primary Button – only enabled if form is valid
          PrimaryButton<Image>(
            title: "Sign Up",
            icon: nil,
            isDisabled: state.isSignUpDisabled
          ) {
            Task {
              await viewModel.signUpWithEmailAndPassword()
            }
          }
          
          SignUpLoginText {
            Logger.d(tag: "SignUpView", message: "Navigating to login")
            viewModel.navigateToLogin()
          }
          
        } // VStack
        .padding(.horizontal, 32)
        Spacer()
        Spacer()
      }
    }
    .task {
      viewModel.startAnimation()
    }
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  SignUpView(
    viewModel: container.resolve(SignUpViewModel.self)!,
    appCoordinator: container.resolve(AppCoordinator.self)!
  )
}
