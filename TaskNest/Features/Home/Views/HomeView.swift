//
//  HomeView.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct HomeView: View {
  @Bindable private(set) var homeViewModel: HomeViewModel
  private let columns = [GridItem(.adaptive(minimum: 80), spacing: 16)]
  
  var body: some View {
    //    let state = homeViewModel.state
    
    NavigationStack {
      VStack {
        HomeViewTitleComponent()
        Spacer()
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        /// --- Search
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            // TODO: viewmodel.search here
          } label: {
            Image(systemName: "magnifyingglass")
              .imageScale(.large)
          }
        }
        
        /// --- Settings and Profile
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            homeViewModel.openSettings()
          } label: {
            Image(systemName: "person.crop.circle")
              .imageScale(.large)
          }
        }
        
        /// --- Profile
        ToolbarItem(placement: .topBarLeading) {
          Button {
            // TODO:
          } label: {
            Text("Tasknest")
              .font(.headline)
              .fontWeight(.bold)
          }
        }
      }
      .sheet(isPresented: homeViewModel.showSettingsBinding) {
        SettingsPanel(
          onLogout: { homeViewModel.logout() }
        )
      }
      .background(Color.backgroundColor3)
    }
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  HomeView(
    homeViewModel: HomeViewModel(
      authManager: container.resolve(AuthManager.self)!,
      authUseCase: container.resolve(AuthUseCase.self)!,
      appCoordinator: container.resolve(AppCoordinator.self)!
    )
  )
}
