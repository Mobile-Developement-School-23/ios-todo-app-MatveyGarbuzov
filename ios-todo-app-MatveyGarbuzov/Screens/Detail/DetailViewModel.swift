//
//  DetailViewModel.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 29.06.2023.
//

import Foundation

class DetailViewModel {
  private(set) var toDoItem: ToDoItem
  
  var index: Int
  var newText: String
  var newImportance: Importance
  var isDeadlineSet: Bool
  var newDeadlineDate: Date?
  
  var somethingChanged: Bool = false {
    didSet {
      NotificationCenter.default.post(name: NSNotification.Name("somethingChanged"), object: nil)
    }
  }

  init(toDoItem: ToDoItem, index: Int) {
    self.toDoItem = toDoItem
    
    self.index = index
    self.newText = toDoItem.text
    self.newImportance = toDoItem.importance
    self.isDeadlineSet = toDoItem.deadline != nil
    self.newDeadlineDate = toDoItem.deadline
  }
}

extension DetailViewModel {
  var isSomethingChanged: Bool {
    if (toDoItem.text != newText) || (toDoItem.importance != newImportance) || (toDoItem.deadline != newDeadlineDate) || (isDeadlineSet){
      return true
    }

    return false
  }
    
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
      return ""
    }
  }
  
  func saveItem() {
    let newItem = ToDoItem(id: toDoItem.id, text: newText, importance: newImportance, deadline: newDeadlineDate, isDone: toDoItem.isDone, createdAt: toDoItem.createdAt, changedAt: toDoItem.changedAt)
    toDoItem = newItem
  }
}
