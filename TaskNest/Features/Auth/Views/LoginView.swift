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
  
  var body: some View {
//    let loginState = viewModel.state
    
    VStack {
      Text("Testing Login")
//      if loginState.isAuthenticated {
//        Text("✅ Logged in as \(loginState.email)")
//      }
      
    }
  }
}

//#Preview {
//  LoginView(viewModel: resolver.resolve(LoginViewModel.self)!)
//}


