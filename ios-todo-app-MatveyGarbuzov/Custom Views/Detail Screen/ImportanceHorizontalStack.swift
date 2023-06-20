//
//  ImportanceHorizontalStack.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import UIKit

final class ImportanceHorizontalStack: UIView {
  
  lazy private var hStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    
    return stack
  }()
  
  lazy private var importanceLabel = UILabel.body(with: "Важность")
  
  lazy private var segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl()
    
    let unimportantImage = UIImage(named: "Unimportant")?.resized(to: CGSize(width: 11, height: 14))
    let unimportantImageView = UIImageView(image: unimportantImage)
    unimportantImageView.contentMode = .scaleAspectFit
    
    let importantImage = UIImage(named: "Important")?.resized(to: CGSize(width: 10, height: 16))
    
    let importantImageView = UIImageView(image: importantImage)
    importantImageView.contentMode = .scaleAspectFit
    
    segmentedControl.insertSegment(with: unimportantImageView.image, at: 0, animated: false)
    segmentedControl.insertSegment(withTitle: "нет", at: 1, animated: false)
    segmentedControl.insertSegment(with: importantImageView.image, at: 2, animated: false)
       
    segmentedControl.selectedSegmentIndex = 1
    
    // TODO: Исправить цвет на .aOverlay или оставить .black
    // (дизайн в figma расходится с отображением на симуляторе)
    segmentedControl.backgroundColor = .black//.aOverlay
    segmentedControl.selectedSegmentTintColor = .aBackElevated
    
    return segmentedControl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func customInit() {
    setup()
    setupConstraints()
  }
  
  private func setupConstraints() {
    addSubview(hStack)
    
    hStack.addArrangedSubview(importanceLabel)
    hStack.addArrangedSubview(segmentedControl)
    
    hStack.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(12)
      make.top.bottom.equalToSuperview().inset(10)
    }
    
    segmentedControl.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.trailing.equalToSuperview()
      make.width.equalTo(150)
    }
  }
  
  private func setup() {
    backgroundColor = .aBackSecondary
    layer.cornerRadius = 15
  }
}

extension UIImage {
  func resized(to size: CGSize) -> UIImage? {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    return newImage?.withRenderingMode(.alwaysOriginal)
  }
}
