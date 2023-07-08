//
//  URLSession.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 07.07.2023.
//

import Foundation

extension URLSession {
  func dataTask(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
    return try await withCheckedThrowingContinuation ({ continuation in
      let task = self.dataTask(with: urlRequest) { data, response, error in
        if let error = error {
          continuation.resume(throwing: error)
        }
        if let data = data, let response = response {
          continuation.resume(returning: (data, response))
        } else {
          continuation.resume(throwing: URLError(.unknown))
        }
      }
      
      if Task.isCancelled {
        task.cancel()
      } else {
        task.resume()
      }
    })
  }
}
