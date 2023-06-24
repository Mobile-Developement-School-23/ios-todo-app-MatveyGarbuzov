//
//  CustomLabels.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import UIKit

extension UILabel {
  static func largeTitle(with text: String) -> UILabel {
    let label = UILabel()
    label.frame = CGRect(x: 0, y: 0, width: 0, height: 46)
    label.textColor = .aLabelPrimary
    
    label.font = .systemFont(ofSize: 38)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.42, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    
    return label
  }
  
  static func title(with text: String) -> UILabel {
    let label = UILabel()
    label.frame = CGRect(x: 0, y: 0, width: 0, height: 24)
    label.textColor = .aLabelPrimary
    
    label.font = .systemFont(ofSize: 20)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.38, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    
    return label
  }
  
  static func headline(with text: String) -> UILabel {
    let label = UILabel()
    label.frame = CGRect(x: 0, y: 0, width: 0, height: 22)
    label.textColor = .aLabelPrimary
    
    label.font = .systemFont(ofSize: 17)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    
    return label
  }
  
  static func body(with text: String) -> UILabel {
    let label = UILabel()
    label.frame = CGRect(x: 0, y: 0, width: 0, height: 22)
    label.textColor = .aLabelPrimary
    
    label.font = .systemFont(ofSize: 17)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    
    return label
  }
  
  static func subhead(with text: String) -> UILabel {
    let label = UILabel()
    label.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
    label.textColor = .aLabelPrimary
    
    label.font = .systemFont(ofSize: 15)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    
    return label
  }
  
  static func footnote(with text: String) -> UILabel {
    let label = UILabel()
    label.frame = CGRect(x: 0, y: 0, width: 0, height: 18)
    label.textColor = .aLabelPrimary
    
    label.font = .systemFont(ofSize: 13)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    
    return label
  }
}
