//
//  TaskManager.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import Foundation

/// Приоритеты важных задач
enum ImportantTaskPriorities: Int, CustomStringConvertible {
	case high   = 1
	case medium = 2
	case low    = 3
	
	/// Описание приоритета
	var description : String {
		switch self {
			
		case .high: return "high"
		case .medium: return "medium"
		case .low: return "low"
		}
	}
	
}

/// Протокол менеджера задач
protocol ITaskManager {
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTasks(tasks: [Task])
}

/// Класс менеджера задач
final class TaskManager {
	
	/// Список задач
	private var tasksList: [Task] = []
	
	/// Получить все задачи
	public func allTasks() -> [Task] {
		tasksList
	}
	
	/// Получить выполненные задачи
	public func completedTasks() -> [Task] {
		tasksList.filter ({ $0.completed == true})
	}
	
	/// Получить навыполненные задачи
	public func uncompletedTasks() -> [Task] {
		return tasksList.filter ({ $0.completed != true})
	}
	
	/// Добавить задачу в список
	public func addTask(task: Task) {
		tasksList.append(task)
	}
	
	public func addTasks(tasks: [Task]) {
		tasksList.append(contentsOf: tasks)
	}
	
	/// Удалить задачу из списка
	public func removeTask(task: Task) {
		tasksList.removeAll() { value in value === task }
	}
	
}

extension TaskManager: ITaskManager {}
