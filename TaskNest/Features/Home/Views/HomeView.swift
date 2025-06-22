//
//  HomeView.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct HomeView: View {
  @Bindable private(set) var appCoordinator: AppCoordinator
  @State private var showSettings: Bool = false
  
  var body: some View {
    NavigationStack {
      Group {
        Text("Hello, World!")
      }
      .navigationTitle("Home")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            
          } label: {
            Image(systemName: "gear")
              .imageScale(.large)
          }
        }
      }
      .sheet(isPresented: $showSettings) {
        SettingPanel()
      }
    }
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  HomeView(appCoordinator: container.resolve(AppCoordinator.self)!)
} 
