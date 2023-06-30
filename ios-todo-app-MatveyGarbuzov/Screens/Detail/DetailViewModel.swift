//
//  DetailViewModel.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 29.06.2023.
//

import Foundation

/*
 let id: String
 let text: String
 let importance: Importance
 let deadline: Date?
 var isDone: Bool
 let createdAt: Date
 let changedAt: Date?
 
 */

class DetailViewModel {
  private let toDoItem: ToDoItem
  
  init(toDoItem: ToDoItem) {
    self.toDoItem = toDoItem
  }
}

extension DetailViewModel {
  var text: String {
    return toDoItem.text
  }
  
  var importanceLevel: Int {
    switch toDoItem.importance {
    case .unimportant:
      return 0
    case .normal:
      return 1
    case .important:
      return 2
    }
  }
  
  var deadlineDate: String {
    if let date = toDoItem.deadline {
      return date.toFormattedString()
    } else {
      return ""//Date().nextDayInString()
    }
  }
}
