//
//  HomeView.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct HomeView: View {
  @Bindable private(set) var homeViewModel: HomeViewModel
  @Bindable private(set) var appCoordinator: AppCoordinator
  private let columns = [GridItem(.adaptive(minimum: 80), spacing: 16)]
  
  var body: some View {
    let state = homeViewModel.homeViewState
    
    NavigationStack {
      VStack {
        HomeViewTitleComponent()
        SearchableBar(searchText: homeViewModel.searchTextBinding)
        
        VStack(alignment: .leading, spacing: 10) {
          Text("Categories")
            .font(.title3.bold())
          
          let column = [GridItem(.adaptive(minimum: 68))]
          ScrollView {
            LazyVGrid(columns: column) {
              ForEach(state.categoryItems, id: \.id) { categoryItem in
                CategoryItemView(categoryItem: categoryItem) {
                  Task {
                    await homeViewModel.deleteCategory(ofId: categoryItem.id)
                  }
                }
              }
              NavigationLink(destination: CategoryDetailView(categoryItem: CategoryItem(id: UUID(), title: "123", createdAt: .now, userId: "12345"))) {
                AddCategoryIcon(iconSize: 25, action: {
                  // TODO: ADD new category
                  
                })
              }
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
      }
      .task {
          await homeViewModel.startLoading()
      }
      .padding()
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
          onLogout: {
            Task {
              await homeViewModel.logout()
            }
          }
        )
      }
      .background(Color.backgroundColor3)
      .onAppear {
        Logger.d(tag: "HomeView", message: "Appeared with path: \(appCoordinator.navigationPath)")
      }
    }
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  HomeView(
    homeViewModel: container.resolve(HomeViewModel.self)!,
    appCoordinator: container.resolve(AppCoordinator.self)!,
  )
}
