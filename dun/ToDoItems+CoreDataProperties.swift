//
//  ToDoItems+CoreDataProperties.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/01.
//
//

import Foundation
import CoreData


extension ToDoItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItems> {
        return NSFetchRequest<ToDoItems>(entityName: "ToDoItems")
    }

    @NSManaged public var itemDescription: String?
    @NSManaged public var isCompleted: Bool

}

extension ToDoItems : Identifiable {

}
