//
//  FileCache.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 01.07.2023.
//

import Foundation

import CocoaLumberjackSwift

class FileCache {
  private(set) var itemsDict = [String: ToDoItem]()
  private let logger: DDLog = {
    let logger = DDLog()
    DDLog.add(DDOSLogger.sharedInstance)
    return logger
  }()

  
  func addTask(_ item: ToDoItem) {
    itemsDict[item.id] = item
  }
  
  func removeTask(id: String) {
    itemsDict[id] = nil
  }
  
  func save(to file: String) throws {
    // Creating destination directory URL
    let fm = FileManager.default
    guard let directoryURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      DDLogError("Error saving file")
      return
    }
    
    // Creating file URL
    let fileURL = URL(fileURLWithPath: file, relativeTo: directoryURL).appendingPathExtension("json")
    
    // Saving data to the file URL
    do {
      let serializedItems = itemsDict.map { _, item in item.json }
      let data = try JSONSerialization.data(withJSONObject: serializedItems, options: [])
      try data.write(to: fileURL)
      DDLogInfo("Savasfkljing file at: \(fileURL.absoluteURL)")
    } catch {
      DDLogError(error.localizedDescription)
    }
  }
  
  func load(from file: String) throws {
    let fm = FileManager.default
    guard let directoryURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      DDLogError("Error reading file")
      return
    }
    
    // Creating file URL
    let fileURL = URL(fileURLWithPath: file, relativeTo: directoryURL).appendingPathExtension("json")
    
    let savedData = try Data(contentsOf: fileURL)
    let json = try JSONSerialization.jsonObject(with: savedData, options: [])
    guard let dict = json as? [Any] else {
      DDLogError("Error with parsing data")
      return
    }
    DDLogInfo("SAVED")
    let items = dict.compactMap { ToDoItem.parse(json: $0) }
    
    itemsDict = items.reduce(into: [:]) { res, item in
      res[item.id] = item
    }
  }
}
