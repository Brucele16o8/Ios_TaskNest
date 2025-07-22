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
    
    VStack {
      HomeViewTitleComponent()
      SearchableBar(searchText: homeViewModel.searchTextBinding)
      
      /// Category Grid
      VStack(alignment: .leading, spacing: 10) {
        Text("Categories")
          .font(.title3.bold())
        
        let column = [GridItem(.adaptive(minimum: 68))]
        ScrollView {
          LazyVGrid(columns: column) {
            ForEach(state.categoryItems, id: \.id) { categoryItem in
              CategoryIcon(
                name: categoryItem.title,
                systemIcon: AppCategory.from(title: categoryItem.title).iconName,
                iconSize: 25,
                onClick: {
                  homeViewModel.navigateToCategoryDetailView(for: categoryItem)
                }
              )
            }
            AddCategoryIcon(iconSize: 25, action: {
              homeViewModel.updateShowAddCategory(true)
            })
            
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      /// Task Item
      
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
    .sheet(isPresented: homeViewModel.showAddCategoryBiniding) {
      AddCategoryView(
        viewModel: AddCategoryViewModel(),
        onSave: {
          await homeViewModel.createAndSaveCategory(from: $0)
          Logger.d(tag: "SaveCategory", message: "Inside onSave - HomeView")
        },
        onCancel: {
          homeViewModel.updateShowAddCategory(false)
        }
      )
    }
    .background(Color.backgroundColor3)
    .onAppear {
      Logger.d(tag: "HomeView", message: "Appeared with path: \(appCoordinator.navigationPath)")
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
