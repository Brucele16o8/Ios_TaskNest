//
//  AuthRepositoryImpl.swift
//  TaskNest
//
//  Created by Tung Le on 12/6/2025.
//

import Auth0

final class AuthRepositoryImpl: AuthRepository {
  private let remoteAuthenticationSource: Auth0RemoteDataSource
  
  init(remote: Auth0RemoteDataSource) {
    self.remoteAuthenticationSource = remote
  }
  
  func loginWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<Credentials, Error>) -> Void) {
    Logger.d(tag: "", message: "Inside AuthRepositoryImpl - loginWithEmailAndPassword")
    remoteAuthenticationSource.loginWithEmailandPassword(email: email, password: password, completion: completion)
  }
  
  func loginWithGoogle(completion: @escaping (Result<Credentials, any Error>) -> Void) {
    remoteAuthenticationSource.loginWithGoogle(completion: completion)
  }
  
  func restoreSession(completion: @escaping (Result<Credentials, any Error>) -> Void) {
    remoteAuthenticationSource.restoreSession(completion: completion)
  }
  
  func logout(completion: @escaping (Result<Void, Error>) -> Void) {
    remoteAuthenticationSource.clearSession(completion: completion)
    remoteAuthenticationSource.clearCredentials()
  }
  
  func getUserInfo(accessToken: String) async throws -> AuthenticatedUser {
    return try await remoteAuthenticationSource.getUserInfo(accessToken: accessToken)
  }
  
  func signUpwithEmailAndPassword(email: String, password: String, completion: @escaping (Result<Auth0.Credentials, AppError>) -> Void) {
    remoteAuthenticationSource.singUpWithEmailAndPassword(email: email, password: password, completion: completion)
  }
  
} // 🧱
