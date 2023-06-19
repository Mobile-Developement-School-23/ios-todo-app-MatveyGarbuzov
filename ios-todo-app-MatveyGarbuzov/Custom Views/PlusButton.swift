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
    setupView()
    addShadow()
  }
 
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
    addShadow()
  }
 
  private func setupView() {
    backgroundColor = UIColor.systemBlue
    layer.cornerRadius = frame.size.width / 2
 
    // увеличиваем размер картинки
    let originalImage = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
    let scaledImage = originalImage?.scaledImage(scale: 1.4).withTintColor(.white)
    setImage(scaledImage, for: .normal)
 
    layer.masksToBounds = true
  }
 
  func addShadow() {
    layer.shadowColor = UIColor.systemBlue.cgColor
    layer.shadowOffset = CGSize(width: 7, height: 7)
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.3
    layer.masksToBounds = false
  }
}
 
extension UIImage {
  // метод для масштабирования картинки
  func scaledImage(scale: CGFloat) -> UIImage {
    let newSize = CGSize(width: size.width * scale, height: size.height * scale)
    let renderer = UIGraphicsImageRenderer(size: newSize)
 
 
    let newImage = renderer.image { (context) in
      draw(in: CGRect(origin: .zero, size: newSize))
    }
 
 
    return newImage
  }
}
