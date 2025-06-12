//
//  AuthRepositoryImpl.swift
//  TaskNest
//
//  Created by Tung Le on 12/6/2025.
//

import Auth0

final class AuthRepositoryImpl: AuthRepository {
  private let remote: Auth0RemoteDataSource
  
  init(remote: Auth0RemoteDataSource) {
    self.remote = remote
  }
  
  func loginWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<Credentials, Error>) -> Void) {
    remote.loginWithEmail(email: email, password: password, completion: completion)
  }
  
  func loginWithGoogle(completion: @escaping (Result<Credentials, any Error>) -> Void) {
    remote.loginWithGoogle(completion: completion)
  }
  
  func restoreSession(completion: @escaping (Result<Credentials, any Error>) -> Void) {
    remote.restoreSession(completion: completion)
  }
  
  func logout() {
    remote.clearSession()
    remote.clearCredentials()
  }
  
}
