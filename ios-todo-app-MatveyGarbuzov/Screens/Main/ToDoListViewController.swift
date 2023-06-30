//
//  ToDoListViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import UIKit

protocol ToDoItemDelegate: AnyObject {
  func updateItem(at index: Int, toDoItem: ToDoItem)
  func deleteItem(at index: Int)
}

class ToDoListViewController: UIViewController {
  
  private lazy var tableViewContainer = TableViewContainer()
  
  var viewModel = TasksViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    setupConstraints()
    viewModel.loadData()
    setupDelegates()
  }
  
  private func setupDelegates() {
    tableViewContainer.buttonContainerDelegate = self
    tableViewContainer.delegate = self
    tableViewContainer.dataSource = self
  }
  
  private func setupConstraints() {
    view.addSubview(tableViewContainer)
    
    tableViewContainer.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

extension ToDoListViewController {
  private func presentDetailVC(with viewModel: DetailViewModel) {
    let detailVC = DetailViewController(viewModel: viewModel)
    detailVC.toDoItemDelegate = self
    
    let presentVC = UINavigationController(rootViewController: detailVC)
    navigationController?.present(presentVC, animated: true)
  }
}

extension ToDoListViewController {
  private func setupNavBar() {
    view.backgroundColor = .aBackIOSPrimary
    title = "Мои дела"
    
    let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 34), .kern: 0.37]
    navigationController?.navigationBar.largeTitleTextAttributes = attributes
    navigationController?.navigationBar.prefersLargeTitles = true
   
    if var margins = navigationController?.navigationBar.layoutMargins {
        margins.left = 32
        navigationController?.navigationBar.layoutMargins = margins
    }
  }
}

extension ToDoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewModel = viewModel.getDetailViewModel(for: indexPath.row)
    presentDetailVC(with: viewModel)
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let removeAction = UIContextualAction(style: .destructive, title: "") { [self] (action, view, completionHandler) in
      self.removeToDoItem(at: indexPath)
      completionHandler(true)
    }
    
    removeAction.image = UIImage(systemName: "trash.fill")
    removeAction.backgroundColor = UIColor.aRed
    
    let configuration = UISwipeActionsConfiguration(actions: [removeAction])
    configuration.performsFirstActionWithFullSwipe = true
    
    return configuration
  }
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let doneAction = UIContextualAction(style: .destructive, title: "") { [self] (action, view, completionHandler) in
      print(viewModel.toDoItems[indexPath.row])
      isDoneToggle(at: indexPath)
      completionHandler(true)
    }
    
    doneAction.image = UIImage(systemName: "checkmark.circle.fill")
    doneAction.backgroundColor = UIColor.aGreen
    
    let configuration = UISwipeActionsConfiguration(actions: [doneAction])
    configuration.performsFirstActionWithFullSwipe = true
    
    return configuration
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
    let viewModel = viewModel.getCellViewModel(for: indexPath.row)
    cell.configure(with: viewModel)
    cell.cellButtonContainerDelegate = self
    
    return cell
  }
}

extension ToDoListViewController {
  func updateToDoItem(at index: Int, toDoItem: ToDoItem) {
    viewModel.updateToDoItem(at: index, toDoItem: toDoItem)
    tableViewContainer.updateTableView()
    viewModel.saveData()
  }
  
  func deleteToDoItem(at index: Int) {
    viewModel.deleteItemFromData(at: index)
    viewModel.deleteToDoItem(at: index)
    tableViewContainer.updateTableView()
    
    viewModel.saveData()
  }
  
  func removeToDoItem(at indexPath: IndexPath) {
    viewModel.deleteItemFromData(at: indexPath.row)
    viewModel.deleteToDoItem(at: indexPath.row)
    tableViewContainer.deleteRow(at: indexPath)
    
    viewModel.saveData()
  }
  
  func isDoneToggle(at indexPath: IndexPath) {
    viewModel.isDoneToggle(at: indexPath.row)
    tableViewContainer.updateRow(at: indexPath)
    viewModel.saveData()
  }
}

extension ToDoListViewController: ToDoItemDelegate {
  func deleteItem(at index: Int) {
    deleteToDoItem(at: index)
  }
  
  func updateItem(at index: Int, toDoItem: ToDoItem) {
    updateToDoItem(at: index, toDoItem: toDoItem)
  }
}

extension ToDoListViewController: CellButtonContainerDelegate {
  func isDoneButtonPressed(at index: Int, toDoItem: ToDoItem) {
    updateToDoItem(at: index, toDoItem: toDoItem)
  }
  
  func detailVCButtonPressed() {
    print("VC detailVCButtonPressed")
  }
}

extension ToDoListViewController: ButtonContainerDelegate {
  func plusButtonPressed() {
    let toDoItem = ToDoItem(text: "", importance: .normal, deadline: nil, changedAt: nil)
    let viewModel = DetailViewModel(toDoItem: toDoItem, index: viewModel.toDoItems.count)
    
    presentDetailVC(with: viewModel)
  }
}
