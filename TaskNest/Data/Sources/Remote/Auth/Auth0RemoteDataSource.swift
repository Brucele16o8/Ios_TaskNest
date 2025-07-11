//
//  Auth0RemoteDataSource.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation
import Auth0

final class Auth0RemoteDataSource {
  private let credentialsManager: CredentialsManager
  private let auth: Authentication
  private let networkService: NetworkService
  
  init(networkService: NetworkService) {
    auth = Auth0.authentication(clientId: Auth0Config.clientId, domain: Auth0Config.domain)
    credentialsManager = CredentialsManager(authentication: auth)
    self.networkService = networkService
  }
  
  // ✅ Login with email and passwork by Auth0
  func loginWithEmailandPassword(email: String, password: String, completion: @escaping (Result<Credentials, AppError>) -> Void) {
    auth
      .login(
        usernameOrEmail: email,
        password: password,
        realmOrConnection: Auth0Config.databaseRealm,
        audience: Auth0Config.audience,
        scope: "openid profile email offline_access"
      )
      .start { result in
        switch result {
        case .success(let credentials):
          _ = self.credentialsManager.store(credentials: credentials)
          completion(.success(credentials))
        case .failure(let error):
          completion(.failure(error.toAppError))
        }
      }
  }
  
  
  
  // ✅ Login with Google in Auth0
  func loginWithGoogle(completion: @escaping (Result<Credentials, AppError>) -> Void) {
    login(connection: Auth0Config.googleConnection, completion: completion)
  }
  
  /// ++ Helper method
  func login(connection: String? = nil, completion: @escaping (Result<Credentials, AppError>) -> Void) {
    var webAuth = Auth0
      .webAuth(clientId: Auth0Config.clientId, domain: Auth0Config.domain)
      .scope("openid profile email offline_access")
      .redirectURL(URL(string: Auth0Config.callbackURLString)!)
    
    if let connection = connection {
      webAuth = webAuth.connection(connection)
    }
    
    webAuth.start { result in
      switch result {
      case .success(let credentials):
        let didStore = self.credentialsManager.store(credentials: credentials)
        print("Store securely with biometrics: \(didStore)")
        completion(.success(credentials))
      case .failure(let error):
        completion(.failure(error.toAppError))
      }
    }
  }
  
  // ✅
  func restoreSession(completion: @escaping (Result<Credentials, AppError>) -> Void) {
    credentialsManager.credentials(
      withScope: "openid profile email",
      minTTL: 300
    ) { result in
      completion(result.mapError{ $0.toAppError })
    }
  }
  
  // ✅
  func clearSession(completion: @escaping (Result<Void, AppError>) -> Void) {
    Auth0
      .webAuth(clientId: Auth0Config.clientId, domain: Auth0Config.domain)
      .redirectURL(URL(string: Auth0Config.callbackURLString)!)
      .clearSession(federated: true) { result in
        Logger.d(tag: "Auth0", message: "Session cleared")
        completion(result.mapError{ $0.toAppError })
      }
  }
  
  // ✅
  @discardableResult
  func store(credentials: Credentials) -> Bool {
    return credentialsManager.store(credentials: credentials)
  }
  
  // ✅
  @discardableResult
  func clearCredentials() -> Bool {
    Logger.d(tag: "Logout", message: "Clear credentials")
    return credentialsManager.clear()
  }
  
  // ✅ Fetch User Info
  func getUserInfo(accessToken: String) async throws -> AuthenticatedUser {
    let url = URL(string: "https://\(Auth0Config.domain)/userinfo")!
    do {
      let userInfoDto: UserInfoDto = try await networkService.request(
        endpoint: "",
        method: .getMethod,
        body: Optional<String>.none,
        headers: [:],
        authToken: accessToken,
        customURL: url
      )
      return userInfoDto.mapToAuthenticatedUser
    } catch let appError as AppError {
      throw appError
    } catch {
      throw error.toAppError
    }
  }
  
  // ✅ Sign Up with Auth0
  func singUpWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<Credentials, AppError>) -> Void) {
    auth
      .signup(
        email: email,
        password: password,
        connection: Auth0Config.databaseRealm
      )
      .start { result in
        Logger.d(tag: "Auth0", message: "Signup result: \(result)")
        switch result {
        case .success:
          self.loginWithEmailandPassword(email: email, password: password) { loginResult in
            completion(loginResult.mapError { $0.toAppError })
          }
        case .failure(let authenticationError):
          completion(.failure(authenticationError.toAppError))
        }
      }
  }
  
} // 🧱
