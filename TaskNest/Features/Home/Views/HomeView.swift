//
//  HomeView.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct HomeView: View {
  @Bindable private(set) var appCoordinator: AppCoordinator
  
  var body: some View {
    Text("Hello, World!")
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  HomeView(appCoordinator: container.resolve(AppCoordinator.self)!)
} 
