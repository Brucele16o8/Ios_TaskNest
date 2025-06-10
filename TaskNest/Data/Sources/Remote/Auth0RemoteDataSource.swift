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
  
  init() {
    let auth = Auth0.authentication(clientId: Auth0Config.clientId, domain: Auth0Config.domain)
    credentialsManager = CredentialsManager(authentication: auth)
  }
  
  // ✅
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
        print("STore securely with biometrics: \(didStore)")
        
      }
      completion(result.mapError { $0 as Error })
    }
  }
  
//  // ✅
//  func restoreSession(completion: @escaping (Result<Credentials, Error>) )
  
  
  
}
