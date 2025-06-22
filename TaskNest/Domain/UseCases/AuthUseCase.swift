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
  
  public func loginWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<Credentials, Error>) -> Void) {
    Logger.d(tag: "", message: "Inside LoginUseCase - loginWithEmailAndPassword")
    repository.loginWithEmailAndPassword(email: email, password: password, completion: completion)
  }
  
  func loginWithGoogle(completion: @escaping (Result<Credentials, Error>) -> Void) {
    repository.loginWithGoogle(completion: completion)
  }
  
  func restore(completion: @escaping (Result<Credentials, Error>) -> Void) {
    repository.restoreSession(completion: completion)
  }
  
  func logout() {
    repository.logout()
  }
  
}
