//
//  ViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var toDoListTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .green
    
    return tableView
  }()
  
  private lazy var saveButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .gray
    button.setTitle("Save", for: .normal)
    
    return button
  }()
  
  var viewModel = TasksViewModel()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    title = "To do list"
    
    setupConstraints()
    viewModel.loadData()
  }
  
  private func setupConstraints() {
    view.addSubview(toDoListTableView)
    view.addSubview(saveButton)
    
    toDoListTableView.delegate = self
    toDoListTableView.dataSource = self
    toDoListTableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
    
    saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    
    saveButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview().inset(10)
      make.height.equalTo(50)
    }
    
    toDoListTableView.snp.makeConstraints { make in
      make.top.equalTo(saveButton.snp.bottom).offset(10)
      make.leading.trailing.equalToSuperview().inset(10)
      make.bottom.equalToSuperview()
    }
  }
  
  @objc func saveButtonPressed() throws {
    print("Saving file with \(viewModel.toDoItems.count) ToDoItems!")
    
    let fileCache = FileCache()
    let fileName = "newSavedFile"
    
    viewModel.toDoItems.forEach { item in
      fileCache.addTask(item)
    }
    
    do {
      try fileCache.save(to: fileName)
      print("File saved succefully!")
    } catch {
      print("Error. File not saved!")
    }
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    100
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.toDoItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.id, for: indexPath) as? ToDoCell else {
      return UITableViewCell()
    }
    
    let viewModel = self.viewModel.toDoCellViewModel(for: indexPath.row)
    cell.viewModel = viewModel
    
    return cell
  }
}

class TasksViewModel {
  fileprivate var toDoItems: [ToDoItem] = []
  
  func loadData() {
    let fileCache = FileCache()
    let fileName = "qqwe"
    
    do {
      try fileCache.load(from: fileName)
      fileCache.itemsDict.forEach { (key: String, value: ToDoItem) in
        toDoItems.append(value)
      }
      print("\(fileCache.itemsDict.count) ToDoItems from \(fileName) loaded succefully!")
    } catch {
      print("Error. Can't find such file!")
      
      // Creating destination directory URL
      guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("Error saving file")
        return
      }
      let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("json")
      print("Try to add *\(fileName).json* in directory: \(fileURL.absoluteURL)")
    }
  }
  
  func toDoCellViewModel(for index: Int) -> ToDoCellViewModel {
    let item = toDoItems[index]
    
    return ToDoCellViewModel(id: item.id, text: item.text, importance: String(describing: item.importance),
                             deadline: item.deadline, isDone: item.isDone,
                             createdAt: item.createdAt, changedAt: item.changedAt)
  }
  
}
