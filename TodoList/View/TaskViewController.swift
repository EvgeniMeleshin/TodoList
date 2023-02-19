//
//  ViewController.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import UIKit

/// Контроллер задач 
class TaskViewController: UIViewController {
	
	let tasksAdapter = TasksAdapter()
	
	lazy var tasksTableView: UITableView = {
		let view = UITableView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.delegate = tasksAdapter.self
		view.dataSource = tasksAdapter
		view.separatorStyle = .singleLine
		view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
		view.rowHeight = UITableView.automaticDimension
		view.estimatedRowHeight = 100
		view.backgroundColor = .white
		view.register(TaskViewCell.self, forCellReuseIdentifier: tasksAdapter.identifier)
		
		return view
	}()
	
	let presenter = TasksPresenter()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "To-do List"
		presenter.addView(view: self)
		tasksAdapter.presenter = presenter
		view.addSubview(tasksTableView)
		setupTableViewConstraints()
		presenter.getTasks()
	}
		
	private func setupTableViewConstraints() {
		tasksTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
	}
	
}

extension TaskViewController: ITasksView {
		
	func render(viewDataArray: [ViewData]) {
		tasksAdapter.viewDataArray = viewDataArray
		tasksTableView.reloadData()
	}
	
}


