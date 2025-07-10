//
//  AuthManager.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import Auth0
import Observation

@MainActor
@Observable
final class AuthManager {
  private let authUseCase: AuthUseCase
  private var credentials: Credentials?
  private(set) var currentUser: AuthenticatedUser?
  
  init(authUseCase: AuthUseCase) {
    self.authUseCase = authUseCase
    }
  
  var authToken: String {
    get throws {
      guard let credentials else {
        throw AppError.auth(.unknown(message: "Failed to get auth token from stored credentials in AuthManager"))
      }
      return credentials.accessToken
    }
  }
  
  // ✅ Store / Cache credentials
  func storeCredentials(_ credentials: Credentials) {
    self.credentials = credentials
  }
  
  func storeAuthenticatedUser(_ user: AuthenticatedUser) {
      self.currentUser = user
    }
  
  // ===== Combine authUseCase in authManager
  // ✅
  func loginWithEmailAndPassword(email: String, password: String) async throws -> Credentials {
    do {
      let credentials = try await authUseCase.loginWithEmailAndPassword(email: email, password: password)
      storeCredentials(credentials)
      return credentials
    } catch let appError as AppError{
      throw appError
    } catch {
      throw AppError.unknown(message: "Unknown error occurred while logging in", underlyingError: error)
    }
  }
  
  // ✅
  func loginWithGoogle() async throws -> Credentials {
    do {
      let credentials = try await authUseCase.loginWithGoogle()
      storeCredentials(credentials)
      return credentials
    } catch let appError as AppError{
      throw appError
    } catch {
      throw AppError.unknown(message: "Unknown error occurred while logging in with Google", underlyingError: error)
    }
  }
  
  // ✅
  func signUpWithEmailAndPassword(email: String, password: String) async throws -> Credentials {
    do {
      let credentials = try await authUseCase.signUpWithEmailAndPassword(email: email, password: password)
      storeCredentials(credentials)
      return credentials
    } catch let appError as AppError{
      throw appError
    } catch {
      throw AppError.unknown(message: "Unknown error occurred while signing up", underlyingError: error)
    }
  }
  
  // ✅
  func getUserInfo() async throws -> AuthenticatedUser {
    do {
      let authenticatedUser = try await authUseCase.getUserInfo(acceessToken: self.authToken)
      storeAuthenticatedUser(authenticatedUser)
      return authenticatedUser
    } catch let appError as AppError{
      throw appError
    } catch {
      throw AppError.unknown(message: "Unknown error occurred while getting user info", underlyingError: error)
    }
  }
  
  // ✅
  func logout() async throws {
    do {
      try await authUseCase.logout()
      clearCredentials()
    } catch let appError as AppError {
      throw appError
    } catch {
      throw AppError.unknown(message: "Unknown error occurred while logging out", underlyingError: error)
    }
  }
  
  // ✅
  @discardableResult
  func clearCredentials() -> Bool {
    credentials = nil
    currentUser = nil
    return true
  }

} // 🧱

