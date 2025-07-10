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
  
  // ✅
  func isAuthenticated() async throws -> Bool {
    try await withCheckedThrowingContinuation { continuation in
      Logger.d(tag: "AuthrRepositoryImplement", message: "Inside isAuthenticated")
      remoteAuthenticationSource.restoreSession { result in
        switch result {
        case .success:
          Logger.d(tag: "AuthrRepositoryImplement", message: "Inside restoreSession - success")
          continuation.resume(returning: true)
        case .failure:
          continuation.resume(returning: false)
          Logger.d(tag: "AuthrRepositoryImplement", message: "Inside restoreSession - failure")
        }
      }
    }
  }
  
  // ✅
  func loginWithEmailAndPassword(email: String, password: String) async throws -> Credentials {
    Logger.d(tag: "", message: "Inside AuthRepositoryImpl - loginWithEmailAndPassword")
    return try await withCheckedThrowingContinuation { continuation in
      remoteAuthenticationSource.loginWithEmailandPassword(email: email, password: password) { result in
        continuation.resume(with: result)
      }
    }
  }
  
  // ✅
  func loginWithGoogle() async throws -> Credentials {
    return try await withCheckedThrowingContinuation { continuation in
      remoteAuthenticationSource.loginWithGoogle { result in
        continuation.resume(with: result)
      }
    }
  }
  
  // ✅
  func logout() async throws {
    try await withCheckedThrowingContinuation { continuation in
      remoteAuthenticationSource.clearCredentials()
      remoteAuthenticationSource.clearSession { result in
        continuation.resume(with: result)
      }
    }
  }
  
  // ✅
  func getUserInfo(accessToken: String) async throws -> AuthenticatedUser {
    return try await remoteAuthenticationSource.getUserInfo(accessToken: accessToken)
  }
  
  // ✅
  func signUpwithEmailAndPassword(email: String, password: String) async throws -> Credentials {
    return try await withCheckedThrowingContinuation { continuation in
      remoteAuthenticationSource.singUpWithEmailAndPassword(email: email, password: password) { result in
        continuation.resume(with: result)
      }
    }
  }
  
} // 🧱
