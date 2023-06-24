//
//  ToDoCellModel.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import Foundation

struct ToDoCellViewModel {
  let id: String
  let text: String
  let importance: String
  let deadline: Date?
  var isDone: Bool
  let createdAt: Date
  let changedAt: Date?
}
