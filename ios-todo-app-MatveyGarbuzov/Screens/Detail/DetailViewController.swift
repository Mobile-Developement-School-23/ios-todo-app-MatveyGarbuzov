//
//  DetailViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 19.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {
  
  lazy private var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    
    return scrollView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  private func setup() {
    view.backgroundColor = UIColor.aBackPrimary
    title = "Дело"
    
    let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonPressed))
    navigationItem.leftBarButtonItem = cancelButton
    
    let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonPressed))
    navigationItem.rightBarButtonItem = saveButton
  }
  
  @objc func cancelButtonPressed() {
    print("Cancel button pressed")
    dismiss(animated: true)
  }
  
  @objc func saveButtonPressed() {
    print("Save button pressed")
    dismiss(animated: true)
  }
}
