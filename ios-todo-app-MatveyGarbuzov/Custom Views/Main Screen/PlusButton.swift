//
//  PlusButton.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//
 
import UIKit
 
final class PlusButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    setupImage()
    addShadow()
  }
 
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupImage()
    addShadow()
  }
 
  private func setupImage() {
    let image = UIImage(named: "Plus")
    setImage(image, for: .normal)
    imageView?.contentMode = .scaleAspectFill
  }
 
  func addShadow() {
    layer.shadowColor = UIColor.systemBlue.cgColor
    layer.shadowOffset = CGSize(width: 7, height: 7)
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.3
    layer.masksToBounds = false
  }
}
