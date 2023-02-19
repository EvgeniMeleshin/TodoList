//
//  SectionsAdapter.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 18.02.2023.
//

import Foundation

/// Протокол типов секций
protocol ISectionsTypes {
	var description: String { get }
	func getItemsCountForSection(taskManager: ITaskManager) -> Int
	func getItemsForSection(taskManager: ITaskManager) -> [Task]
}

/// Типы секций
enum SectionsTypes: Int, CustomStringConvertible, CaseIterable, ISectionsTypes {
	
	case uncompletedTasks = 0
	case completedTasks = 1
	
	var description: String {
		switch self {
		case .uncompletedTasks: return "Невыполненные задачи"
		case .completedTasks: return "Выполненные задачи"
		}
	}
	
	func getItemsCountForSection(taskManager: ITaskManager) -> Int {
		switch self {
		case .uncompletedTasks:
			return taskManager.uncompletedTasks().count
		case .completedTasks:
			return taskManager.completedTasks().count
		}
	}
	
	func getItemsForSection(taskManager: ITaskManager) -> [Task] {
		switch self {
		case .uncompletedTasks:
			return taskManager.uncompletedTasks()
		case .completedTasks:
			return taskManager.completedTasks()
		}
	}
	
}
