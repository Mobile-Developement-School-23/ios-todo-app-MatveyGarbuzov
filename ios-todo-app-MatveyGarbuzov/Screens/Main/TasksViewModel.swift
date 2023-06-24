//
//  TasksViewModel.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import Foundation

class TasksViewModel {
  var toDoItems: [ToDoItem] = []
  
  func loadData() {
    let fileCache = FileCache()
    let fileName = "ToDoItems"
    
    do {
      try fileCache.load(from: fileName)
      fileCache.itemsDict.forEach { (key: String, value: ToDoItem) in
        toDoItems.append(value)
      }
      print("\(fileCache.itemsDict.count) ToDoItems from \(fileName) loaded succefully!")
    } catch {
      print("ERROR. Can't find such file!")
      
      // Creating destination directory URL
      guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("Error saving file")
        return
      }
      let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("json")
      
      print("=======")
      print("Add *\(fileName).json* in directory: \(fileURL.absoluteURL)")
      print("=======")
      print()
    }
    
    if toDoItems.count == 0 {
      toDoItems.append(ToDoItem(text: "Проверьте консоль Xcode", importance: .important, deadline: nil, changedAt: nil))
      toDoItems.append(ToDoItem(text: "Нет сохранённых задач", importance: .important, deadline: nil, changedAt: nil))
    }
  }
  
  func getViewModel(for index: Int) -> ToDoCellViewModel {
    let item = toDoItems[index]
    
    return ToDoCellViewModel(id: item.id, text: item.text, importance: String(describing: item.importance),
                             deadline: item.deadline, isDone: item.isDone,
                             createdAt: item.createdAt, changedAt: item.changedAt)
  }
  
}
