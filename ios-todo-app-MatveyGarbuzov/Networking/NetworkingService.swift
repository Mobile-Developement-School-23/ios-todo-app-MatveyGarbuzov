
//  NetworkingService.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 08.07.2023.
//
 
import Foundation
 
protocol NetworkingService {
  func getAllItems() async throws -> [ToDoItem]
  func getItem(with id: String) async throws -> ToDoItem?
  func putItem(with item: ToDoItem) async throws -> ToDoItem?
  func patchAllItems(with todoItemsClient: [ToDoItem]) async throws -> [ToDoItem]
  func postItem(with todoItemClient: ToDoItem) async throws -> ToDoItem?
  func deleteItem(with id: String) async throws -> ToDoItem?
}
 
// Дико извиняюсь, я вырубаюсь
class DefaultNetworkingService: NetworkingService {
  private let token = "balawu"
  private var revision: Int = 0
  private let url = URL(string: "https://beta.mrdekk.ru/todobackend/list")
 
  func getAllItems() async throws -> [ToDoItem] {
    return []
  }
 
  func getItem(with id: String) async throws -> ToDoItem? {
    return nil
  }
 
  func putItem(with item: ToDoItem) async throws -> ToDoItem? {
    return nil
  }
 
  func patchAllItems(with todoItemsClient: [ToDoItem]) async throws -> [ToDoItem] {
    return []
  }
 
  func postItem(with todoItemClient: ToDoItem) async throws -> ToDoItem? {
    return nil
  }
 
  func deleteItem(with id: String) async throws -> ToDoItem? {
    return nil
  }
}
