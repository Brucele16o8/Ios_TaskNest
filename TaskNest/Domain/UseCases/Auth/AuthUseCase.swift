//
//  LoginUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 12/6/2025.
//

import Auth0

final class AuthUseCase {
  private let repository: AuthRepository
  
  init(repository: AuthRepository) {
    self.repository = repository
  }
  
  func isAuthenticated() async throws -> Bool {
    Logger.d(tag: "AuthUseCase", message: "Inside isAuthenticated")
    return try await repository.isAuthenticated()
  }
  
  public func loginWithEmailAndPassword(email: String, password: String) async throws -> Credentials {
    Logger.d(tag: "", message: "Inside LoginUseCase - loginWithEmailAndPassword")
    return try await repository.loginWithEmailAndPassword(email: email, password: password)
  }
  
  func loginWithGoogle() async throws -> Credentials {
    try await repository.loginWithGoogle()
  }
  
  func logout() async throws {
    try await repository.logout()
  }
  
  func getUserInfo(acceessToken: String) async throws -> AuthenticatedUser {
    return try await repository.getUserInfo(accessToken: acceessToken)
  }
  
  func signUpWithEmailAndPassword(email: String, password: String) async throws -> Credentials {
    try await repository.signUpwithEmailAndPassword(email: email, password: password)
  }
}
