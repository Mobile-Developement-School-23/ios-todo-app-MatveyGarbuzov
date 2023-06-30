//
//  Model.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import Foundation

enum Importance {
  case unimportant
  case normal
  case important
  
  init?(rawValue: String) {
    switch rawValue {
    case "unimportant":
      self = .unimportant
    case "normal":
      self = .normal
    case "important":
      self = .important
    default:
      return nil
    }
  }
}

struct ToDoItem {
  let id: String
  let text: String
  let importance: Importance
  let deadline: Date?
  let isDone: Bool
  let createdAt: Date
  let changedAt: Date?

  init(id: String = UUID().uuidString, text: String, importance: Importance, deadline: Date?,
       isDone: Bool = false, createdAt: Date = Date(), changedAt: Date?) {
    self.id = id
    self.text = text
    self.importance = importance
    self.deadline = deadline
    self.isDone = isDone
    self.createdAt = createdAt
    self.changedAt = changedAt
  }
}

extension ToDoItem {
  var json: Any {
    var dict: [String: Any] = [
      "id": id,
      "text": text,
      "isDone": isDone,
      "createdAt": createdAt.timeIntervalSince1970
    ]
    
    if importance != .normal {
      dict["importance"] = String(describing: importance)
    }
    
    if let deadline = deadline {
      dict["deadline"] = deadline.timeIntervalSince1970
    }
    
    if let changedAt = changedAt {
      dict["changedAt"] = changedAt.timeIntervalSince1970
    }
    
    return dict
  }
  
  static func parse(json: Any) -> ToDoItem? {
    guard let jsonDictionary = json as? [String: Any],
          let id = jsonDictionary["id"] as? String,
          let text = jsonDictionary["text"] as? String,
          let createdAtTimestamp = jsonDictionary["createdAt"] as? TimeInterval else {
      return nil
    }

    let deadlineTimestamp = jsonDictionary["deadline"] as? TimeInterval
    let changedAtTimestamp = jsonDictionary["changedAt"] as? TimeInterval
    let isDone = jsonDictionary["isDone"] as? Bool ?? false
    
    let importanceString = jsonDictionary["importance"] as? String ?? "normal"
    let importance = Importance(rawValue: importanceString.lowercased()) ?? .normal
    let createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
    let deadline = deadlineTimestamp.flatMap { Date(timeIntervalSince1970: $0) }
    let changedAt = changedAtTimestamp.flatMap { Date(timeIntervalSince1970: $0) }

    return ToDoItem(id: id, text: text, importance: importance, deadline: deadline,
                      isDone: isDone, createdAt: createdAt, changedAt: changedAt)
    }
}
