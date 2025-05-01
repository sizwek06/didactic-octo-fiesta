//
//  PersistedTodoItems.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/01.
//

import Foundation
import CoreData

protocol PersistedTodoItemsProtocol: AnyObject {
    var managedObjectContext: NSManagedObjectContext { get }
   
    func getTodoRequest() -> NSFetchRequest<NSFetchRequestResult>
    func clearTodoItemsData()
    func createTodoEntity(from newTodoItem: ToDoItem) -> NSManagedObject?
    func createTodoItemFromManagedObject(from ToDoItem: NSManagedObject) -> ToDoItem
    func saveToDoItemsToCoreData(todoItems: [ToDoItem])
    func fetchPersistedTodoItems() -> [ToDoItem]
}
