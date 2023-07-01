//
//  ToDoCellModel.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import Foundation
import UIKit

class ToDoCellViewModel {
  private(set) var toDoItem: ToDoItem
  var index: Int
  
  init(toDoItem: ToDoItem, index: Int) {
    self.toDoItem = toDoItem
    self.index = index
  }
}

extension ToDoCellViewModel {
  var isDeadlineStackHidden: Bool {
    return toDoItem.deadline == nil
  }
  
  var getId: String {
    return toDoItem.id
  }
  
  var getText: String {
    return toDoItem.text
  }
  
  var getIsDoneImage: UIImage? {
    var imageName: String = "NotDone"
    if toDoItem.importance == .important { imageName = "HighPriority" }
    if toDoItem.isDone { imageName = "Done" }
    
    return UIImage(named: imageName)
  }
  
  var getDeadlineDate: String? {
    return toDoItem.deadline?.toFormattedString()
  }
  
  func changeIsDoneStatus() {
    let newItem = ToDoItem(
      id: toDoItem.id,
      text: toDoItem.text,
      importance: toDoItem.importance,
      deadline: toDoItem.deadline,
      isDone: !toDoItem.isDone,
      createdAt: toDoItem.createdAt,
      changedAt: toDoItem.changedAt)
    toDoItem = newItem
  }
}
