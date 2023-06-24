//
//  ToDoListViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import UIKit

class ToDoListViewController: UIViewController {
  
  private lazy var toDoListTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    return tableView
  }()
  
  private lazy var plusButton = PlusButton()
  
  var viewModel = TasksViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    setupConstraints()
    addAction()
    viewModel.loadData()
    plusButtonPressed()
  }
  
  private func setupNavBar() {
    view.backgroundColor = .aBackIOSPrimary
    title = "Мои дела"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func setupConstraints() {
    view.addSubview(toDoListTableView)
    view.addSubview(plusButton)
    
    toDoListTableView.delegate = self
    toDoListTableView.dataSource = self
    toDoListTableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
    
    toDoListTableView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview().inset(10)
      make.bottom.equalToSuperview()
    }
    
    plusButton.snp.makeConstraints { make in
      make.width.height.equalTo(44)
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func addAction() {
    plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
  }
  
  @objc func plusButtonPressed() {
    let presentVC = UINavigationController(rootViewController: DetailViewController())
    navigationController?.present(presentVC, animated: true)
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

extension ToDoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    100
  }
}

extension ToDoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.toDoItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.id, for: indexPath) as? ToDoCell else {
      return UITableViewCell()
    }
    
    let viewModel = self.viewModel.getViewModel(for: indexPath.row)
    cell.viewModel = viewModel
    
    return cell
  }
}
