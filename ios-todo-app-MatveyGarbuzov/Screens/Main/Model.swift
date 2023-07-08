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
      JSONKeys.kId : id,
      JSONKeys.kText : text,
      JSONKeys.kDone : isDone,
      JSONKeys.kCreatedAt : createdAt.timeIntervalSince1970
    ]
    
    if importance != .normal {
      dict[JSONKeys.kImportance] = String(describing: importance)
    }
    
    if let deadline = deadline {
      dict[JSONKeys.kDeadline] = deadline.timeIntervalSince1970
    }
    
    if let changedAt = changedAt {
      dict[JSONKeys.kChangedAt] = changedAt.timeIntervalSince1970
    }
    
    return dict
  }
  
  static func parse(json: Any) -> ToDoItem? {
    guard let jsonDictionary = json as? [String: Any],
          let id = jsonDictionary[JSONKeys.kId] as? String,
          let text = jsonDictionary[JSONKeys.kText] as? String,
          let createdAtTimestamp = jsonDictionary[JSONKeys.kCreatedAt] as? TimeInterval else {
      return nil
    }
    
    let deadlineTimestamp = jsonDictionary[JSONKeys.kDeadline] as? TimeInterval
    let changedAtTimestamp = jsonDictionary[JSONKeys.kChangedAt] as? TimeInterval
    let isDone = jsonDictionary[JSONKeys.kDone] as? Bool ?? false
    
    let importanceString = jsonDictionary[JSONKeys.kImportance] as? String ?? "normal"
    let importance = Importance(rawValue: importanceString.lowercased()) ?? .normal
    let createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
    let deadline = deadlineTimestamp.flatMap { Date(timeIntervalSince1970: $0) }
    let changedAt = changedAtTimestamp.flatMap { Date(timeIntervalSince1970: $0) }
    
    return ToDoItem(id: id, text: text, importance: importance, deadline: deadline,
                    isDone: isDone, createdAt: createdAt, changedAt: changedAt)
  }
  
  func getJsonForNet(deviceID: String) -> [String: Any] {
    var tempDictionary: [String: Any] = [:]
    
    tempDictionary[JSONKeys.kId] = id
    tempDictionary[JSONKeys.kText] = text
    tempDictionary[JSONKeys.kImportance] = importance
    if deadline != nil { tempDictionary[JSONKeys.kImportance] = Int(deadline!.timeIntervalSince1970) }
    tempDictionary[JSONKeys.kDone] = isDone
    tempDictionary[JSONKeys.kCreatedAt] = Int(createdAt.timeIntervalSince1970)
    if changedAt != nil { tempDictionary[JSONKeys.kChangedAt] = Int(changedAt!.timeIntervalSince1970) }
    tempDictionary[JSONKeys.kLastUpdatedBy] = deviceID
    
    return tempDictionary
  }
}

enum JSONKeys {
  static let kId = "id"
  static let kText = "text"
  static let kImportance = "importance"
  static let kDeadline = "deadline"
  static let kDone = "done"
  static let kColor = "color"
  static let kCreatedAt = "created_at"
  static let kChangedAt = "changed_at"
  static let kLastUpdatedBy = "last_updated_by"
}
