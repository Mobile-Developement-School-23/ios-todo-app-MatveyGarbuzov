//
//  ImportanceHorizontalStack.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import UIKit

final class ImportanceHorizontalStack: UIStackView {
  
  lazy private var importanceLabel: UILabel = {
    let label = UILabel.body(with: "Важность")
    
    return label
  }()
  
//  lazy private var segmentedControl: UISegmentedControl = {
//    let unimportantImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 11, height: 14))
//    unimportantImage.image = UIImage(
//    let normal
//    let important
//
//    let segmentedControl = UISegmentedControl(items: <#T##[Any]?#>)
//    segmentedControl.frame = CGRect(x: 0, y: 0, width: 150, height: 36)
//
//    return segmentedControl
//  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func customInit() {
    
  }
  
  private func setupConstraints() {
    
  }
}
