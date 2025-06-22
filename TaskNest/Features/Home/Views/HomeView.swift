//
//  HomeView.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct HomeView: View {
  @Bindable private(set) var homeViewModel: HomeViewModel
  
  var body: some View {
    let state = homeViewModel.state
    
    NavigationStack {
      Group {
        Text("Hello, World!")
      }
      .navigationTitle("Home")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            homeViewModel.openSettings()
          } label: {
            Image(systemName: "gear")
              .imageScale(.large)
          }
        }
      }
      .sheet(isPresented: homeViewModel.showSettingsBinding) {
        SettingsPanel(
          onLogout: { homeViewModel.logout() }
        )
      }
    }
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  HomeView(
    homeViewModel: HomeViewModel(
      authManager: container.resolve(AuthManager.self)!,
      authUseCase: container.resolve(AuthUseCase.self)!
    )
  )
}
