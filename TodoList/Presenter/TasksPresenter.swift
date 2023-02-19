//
//  TasksPresenter.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 18.02.2023.
//

import UIKit

/// Протокол view контроллера
protocol ITasksView: NSObjectProtocol {
	func render(viewDataArray: [ViewData])
}

/// Протокол презентера
protocol ITasksPresenter {
	func completeTask(id: String)
	func getTasks()
	func addView(view: ITasksView)
}

/// Презентер
class TasksPresenter: ITasksPresenter {
	
	private let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
	private let repository: IRepository = Repository()
	weak private var tasksView: ITasksView?
	var viewDataArray: [ViewData] = []
	
	func addView(view: ITasksView) {
		tasksView = view
	}
	
	func getTasks() {
		let allTasks = repository.getAllTasks()
		taskManager.addTasks(tasks: allTasks)
		createViewData(tasks: taskManager.allTasks())
	}
	
	func createViewElement(tasks: [Task], section: Int) {
		for task in tasks.enumerated() {
			if let importantTask = task.element as? ImportantTask {
				let viewData = ViewData(title: importantTask.title,
										completed: importantTask.completed,
										priority: importantTask.priority.description,
										completionDate: getStringByDate(date: importantTask.completionDate),
										section: section,
										row: task.offset,
										id: importantTask.id,
										overdue: importantTask.completionDate < Date() ? true : false)
				viewDataArray.append(viewData)
			} else {
				let viewData = ViewData(title: task.element.title,
										completed: task.element.completed,
										priority: "",
										completionDate: "",
										section: section,
										row: task.offset, id: task.element.id)
				viewDataArray.append(viewData)
			}
		}
	}
	
	func createViewData(tasks: [Task]) {
		let uncompletedTasks = taskManager.uncompletedTasks()
		let completedTasks = taskManager.completedTasks()
		SectionsTypes.allCases.forEach { sectionType in
			switch sectionType {
			case .uncompletedTasks:
				createViewElement(tasks: uncompletedTasks, section: sectionType.rawValue)
			case .completedTasks:
				createViewElement(tasks: completedTasks, section: sectionType.rawValue)
			}
		}
		tasksView?.render(viewDataArray: viewDataArray)
		self.viewDataArray = []
	}
	
	func completeTask(id: String) {
		let tasks = taskManager.allTasks()
		let task = tasks.first { task in
			task.id == id
		}
		task?.completeTask()
		createViewData(tasks: taskManager.allTasks())
	}
	
	private func getStringByDate(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy HH:mm"
		return formatter.string(from: date)
	}
}
