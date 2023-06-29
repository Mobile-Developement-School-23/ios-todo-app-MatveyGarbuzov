//
//  ToDoCellModel.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import Foundation
import UIKit

struct ToDoCellViewModel {
  let id: String
  let text: String
  let importance: Importance
  let deadline: Date?
  var isDone: Bool
  let createdAt: Date
  let changedAt: Date?
}

extension ToDoCellViewModel {
  var getId: String {
    return id
  }
  
  var getText: String {
    return text
  }
  
  var getImportanceImage: UIImage? {
    var imageName: String = "NotDone"
    if importance == .important { imageName = "HighPriority" }
    if isDone { imageName = "Done" }
    
    return UIImage(named: imageName)
  }
  
  var getDeadlineDate: String? {
    return deadline?.toFormattedString()
  }
  
  
}
