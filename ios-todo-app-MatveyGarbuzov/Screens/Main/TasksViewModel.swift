//
//  TasksViewModel.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import Foundation

class TasksViewModel {
  var toDoItems: [ToDoItem] = []
  let fileCache = FileCache()
  let fileName = "ToDoItem"
  
  var fileURL: String {
    guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return "" }
    let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("json")
    
    return "\(fileURL.absoluteURL)"
  }

  func loadData() {
    do {
      try fileCache.load(from: fileName)
      fileCache.itemsDict.forEach { (key: String, value: ToDoItem) in
        toDoItems.append(value)
      }
      print("\(fileCache.itemsDict.count) ToDoItems from \(fileName) loaded succefully!")
      print(fileURL)
    } catch {
      print("ERROR. Can't find such file!")
      print("Try to add \(fileName).json in \(fileURL)")
    }
    
    if toDoItems.count == 0 {
//      toDoItems.append(ToDoItem(text: "Проверьте консоль Xcode", importance: .important, deadline: nil, changedAt: nil))
//      toDoItems.append(ToDoItem(text: "Нет сохранённых задач", importance: .important, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Купить что-то", importance: .important, deadline: nil, isDone: true, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Купить что-то", importance: .normal, deadline: nil, isDone: true, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Задание", importance: .normal, deadline: Date(timeIntervalSince1970: 1686744616), changedAt: nil))
      toDoItems.append(ToDoItem(text: "Задание", importance: .normal, deadline: Date(timeIntervalSince1970: 1686744616), changedAt: nil))
      toDoItems.append(ToDoItem(text: "Купить что-то", importance: .important, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Купить что-то", importance: .normal, deadline: nil, isDone: true, changedAt: nil))
      toDoItems.append(ToDoItem(text: "сделать зарядку", importance: .normal, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обрезать текст текст текст", importance: .normal, deadline: Date(timeIntervalSince1970: 1686744616), changedAt: nil))
      toDoItems.append(ToDoItem(text: "Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обрезать текст текст текст", importance: .normal, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Купить что-то, где-то, зачем-то, но зачем?", importance: .normal, deadline: nil, changedAt: nil))
      
      toDoItems.append(ToDoItem(text: "Купить сыр", importance: .unimportant, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Сделать пиццу", importance: .important, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Задание", importance: .normal, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Сделать зарядку", importance: .unimportant, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Купить сыр", importance: .unimportant, deadline: nil, changedAt: nil))
    }
  }
  
  func getCellViewModel(for index: Int) -> ToDoCellViewModel {
    let item = toDoItems[index]
    
    return ToDoCellViewModel(toDoItem: item, index: index)
  }
  
  func getDetailViewModel(for index: Int) -> DetailViewModel {
    let item = toDoItems[index]
    
    return DetailViewModel(toDoItem: item, index: index)
  }
  
  func deleteToDoItem(at index: Int) {
    toDoItems.remove(at: index)
  }
  
  func isDoneToggle(at index: Int) {
    let oldItem = toDoItems[index]
    let newItem = ToDoItem(id: oldItem.id, text: oldItem.text, importance: oldItem.importance, deadline: oldItem.deadline, isDone: !oldItem.isDone, createdAt: oldItem.createdAt, changedAt: oldItem.changedAt)
    
    toDoItems[index] = newItem
  }
  
  func addToDoItem(toDoItem: ToDoItem) {
    toDoItems.append(toDoItem)
  }
  
  func updateToDoItem(at index: Int, toDoItem: ToDoItem) {
    if index == toDoItems.count {
      addToDoItem(toDoItem: toDoItem)
    } else {
      toDoItems[index] = toDoItem
    }
  }
}
