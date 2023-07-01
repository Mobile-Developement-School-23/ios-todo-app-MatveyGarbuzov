//
//  ios_todo_app_MatveyGarbuzovTests.swift
//  ios-todo-app-MatveyGarbuzovTests
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import XCTest
@testable import ios_todo_app_MatveyGarbuzov

final class IosTodoAppMatveyGarbuzovTests: XCTestCase {
  
  // MARK: Testing initializers (full or only required)
  func testToDoItemInit() {
    let id: String = "1337"
    let text: String = "Hello, world!"
    let importance: Importance = Importance.normal
    let deadline: Date? = Date()
    let isDone: Bool = false
    let createdAt: Date = Date()
    let changedAt: Date? = Date()
    
    let toDoItem = ToDoItem(id: id, text: text, importance: importance, deadline: deadline, isDone: isDone, createdAt: createdAt, changedAt: changedAt)
    
    let toDoItem2 = ToDoItem(text: text, importance: importance, deadline: deadline, changedAt: changedAt)
    
    // Testing first ToDoItem object
    XCTAssertEqual(toDoItem.id, id)
    XCTAssertEqual(toDoItem.text, text)
    XCTAssertEqual(toDoItem.importance, importance)
    XCTAssertEqual(toDoItem.deadline, deadline)
    XCTAssertEqual(toDoItem.isDone, isDone)
    XCTAssertEqual(toDoItem.createdAt, createdAt)
    XCTAssertEqual(toDoItem.changedAt, changedAt)
    
    // Testing second ToDoItem object
    XCTAssertEqual(toDoItem2.text, text)
    XCTAssertEqual(toDoItem2.importance, importance)
    XCTAssertEqual(toDoItem2.deadline, deadline)
    XCTAssertEqual(toDoItem2.isDone, isDone)
    XCTAssertEqual(toDoItem2.changedAt, changedAt)
    XCTAssertNotNil(toDoItem2.id)
    XCTAssertNotNil(toDoItem2.createdAt)
  }
  
  func testToDoItemJson() {
    let deadline = Date()
    let createdAt = Date()
    let changedAt = Date().addingTimeInterval(2.0)
    let todoItem = ToDoItem(id: "1", text: "Buy groceries", importance: .important,
                            deadline: deadline, isDone: false, createdAt: createdAt,
                            changedAt: changedAt)
    
    let json = todoItem.json as? [String: Any]
    
    XCTAssertNotNil(json)
    XCTAssertEqual(json?["id"] as? String, "1")
    XCTAssertEqual(json?["text"] as? String, "Buy groceries")
    XCTAssertEqual(json?["importance"] as? String, "important")
    XCTAssertEqual(json?["isDone"] as? Bool, false)
    XCTAssertEqual(json?["createdAt"] as? TimeInterval, createdAt.timeIntervalSince1970)
    XCTAssertEqual(json?["deadline"] as? TimeInterval, deadline.timeIntervalSince1970)
    XCTAssertEqual(json?["changedAt"] as? TimeInterval, changedAt.timeIntervalSince1970)
  }
  
  func testToDoItemParse() {
    let json: [String: Any] = [
      "id": "1",
      "text": "Buy groceries",
      "importance": "high",
      "isDone": true,
      "createdAt": Date().timeIntervalSince1970,
      "deadline": Date().addingTimeInterval(3600).timeIntervalSince1970,
      "changedAt": Date().addingTimeInterval(2.0).timeIntervalSince1970
    ]
    
    guard let todoItem = ToDoItem.parse(json: json) else { return }
    
    XCTAssertNotNil(todoItem)
    XCTAssertEqual(todoItem.id, "1")
    XCTAssertEqual(todoItem.text, "Buy groceries")
    XCTAssertEqual(todoItem.importance, .important)
    XCTAssertEqual(todoItem.isDone, true)
    XCTAssertEqual(todoItem.createdAt.timeIntervalSince1970, json["createdAt"] as? TimeInterval)
    XCTAssertEqual(todoItem.deadline?.timeIntervalSince1970, json["deadline"] as? TimeInterval)
    XCTAssertEqual(todoItem.changedAt?.timeIntervalSince1970, json["changedAt"] as? TimeInterval)
  }
  
  func testToDoItemParseShouldFailWithInvalidJson() {
    let json: [String: Any] = [
      "id": "1",
      "text": "Buy groceries",
      "importance": "unknown",
      "createdAt": "not a timestamp"
    ]
    
    let todoItem = ToDoItem.parse(json: json)
    
    XCTAssertNil(todoItem)
  }
  
}
