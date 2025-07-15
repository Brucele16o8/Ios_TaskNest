//
//  ForgotPasswordView.swift
//  TaskNest
//
//  Created by Tung Le on 18/6/2025.
//

// Features/Auth/ForgotPassword/ForgotPasswordView.swift

import SwiftUI

struct ForgotPasswordView: View {
  @Bindable var viewModel: ForgotPasswordViewModel

  var body: some View {
    let forgotPasswordUIState = viewModel.uitState
    
    ZStack {
      BackgroundGridView()
      
      
      VStack(spacing: 32) {
        Spacer()
        LogoTitleView(title: "TaskNest", size: 68, showText: forgotPasswordUIState.showText)
        Spacer()
        
        VStack(spacing: 16) {
          Text("Enter your email below and we’ll send you a link to reset your password.")
            .font(.body)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
          
          TextFieldFormGeneral(
            title: "Email",
            bindingText: viewModel.emailBinding,
            keyboardType: .emailAddress)
        }
        
        if let errorMessage = forgotPasswordUIState.errorMessage {
          Text(errorMessage)
            .font(.caption)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
        }
        
        if let success = forgotPasswordUIState.successMessage {
          Text(success)
            .font(.caption)
            .foregroundColor(.green)
            .multilineTextAlignment(.center)
        }
        
        
        PrimaryButton(
          title: "Send Reset Link",
          icon: forgotPasswordUIState.isSubmitting ? ProgressViewComponent() : nil,
          isDisabled: viewModel.isButtonDisabled,
          action: {
            Task {
              await viewModel.submit()
            }
          })
        
        Spacer()
        Spacer()
        Spacer()
      }
      .padding()
    }
    .task {
      viewModel.startAnimation()
    }
  }
}


#Preview {
  let container = AppDIContainer.shared.container
  ForgotPasswordView(
    viewModel: ForgotPasswordViewModel(
      authUseCase: container.resolve(AuthUseCase.self)!
    )
  )
}
