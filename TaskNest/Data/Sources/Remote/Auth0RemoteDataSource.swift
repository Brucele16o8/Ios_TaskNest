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
  
  init() {
    auth = Auth0.authentication(clientId: Auth0Config.clientId, domain: Auth0Config.domain)
    credentialsManager = CredentialsManager(authentication: auth)
  }
  
  // ✅ Login with email and passwork by Auth0
  func loginWithEmail(email: String, password: String, completion: @escaping (Result<Credentials, Error>) -> Void) {
    auth
      .login(
        usernameOrEmail: email,
        password: password,
        realmOrConnection: Auth0Config.databaseRealm,
        audience: Auth0Config.audience,
        scope: "openid profile email offline_access"
      )
      .start { result in
        if case .success(let credentials) = result {
          _ = self.credentialsManager.store(credentials: credentials)
        }
        completion(result.mapError { $0.toAppError })
      }
  }
  
  
  
  // ✅ Login with Google in Auth0
  func loginWithGoogle(completion: @escaping (Result<Credentials, Error>) -> Void) {
          login(connection: Auth0Config.googleConnection, completion: completion)
      }
  
  /// Helper method
  func login(connection: String? = nil, completion: @escaping (Result<Credentials, Error>) -> Void) {
    var webAuth = Auth0
      .webAuth(clientId: Auth0Config.clientId, domain: Auth0Config.domain)
      .scope("openid profile email offline_access")
      .redirectURL(URL(string: Auth0Config.callbackURLString)!)
    
    if let connection = connection {
      webAuth = webAuth.connection(connection)
    }
    
    
    webAuth.start { result in
      if case .success(let credentials) = result {
        let didStore = self.credentialsManager.store(credentials: credentials)
        print("Store securely with biometrics: \(didStore)")
        
      }
      completion(result.mapError { $0.toAppError })
    }
  }
  
  // ✅
  func restoreSession(completion: @escaping (Result<Credentials, Error>) -> Void) {
    credentialsManager.credentials(
      withScope: "openid profile email",
      minTTL: 300
    ) { result in
      completion(result.mapError{ $0.toAppError })
    }
  }
  
  // ✅
  func clearSession() {
    Auth0
      .webAuth(clientId: Auth0Config.clientId, domain: Auth0Config.domain)
      .clearSession { _ in }
  }
  
  // ✅
  @discardableResult
  func store(credentials: Credentials) -> Bool {
    return credentialsManager.store(credentials: credentials)
  }
  
  // ✅
  @discardableResult 
  func clearCredentials() -> Bool {
    return credentialsManager.clear()
  }
  
    
} // 🧱
