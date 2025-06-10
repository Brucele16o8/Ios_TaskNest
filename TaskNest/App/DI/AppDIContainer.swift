//
//  AppDIContainer.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import Swinject

final class AppDIContainer {
  let container = Container()
  
  private func registerServices() {
    container.register(<#T##serviceType: Service.Type##Service.Type#>, factory: <#T##(any Resolver) -> Service#>)
  }
}
