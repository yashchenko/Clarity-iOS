//
//  CoreDataModel.swift
//  ToDo
//
//  Created by Ivan on 01.11.2025.
//


// Using an enum as a namespace for our static model creation function.
// This prevents anyone from accidentally creating an instance of CoreDataModel.

import CoreData

enum CoreDataModel {
    
    static func createModel() -> NSManagedObjectModel {
       
        // create the Task Entity
        let taskEntity = NSEntityDescription()
        taskEntity.name = "Task"
        // This is the class name that Core Data will use for the managed object.
        taskEntity.managedObjectClassName = "Task"
        
        // create attributes
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .UUIDAttributeType
        idAttribute.isOptional = false
        
        let titleAttribute = NSAttributeDescription()
        titleAttribute.name = "title"
        titleAttribute.attributeType = .stringAttributeType
        titleAttribute.isOptional = false
        
        let taskDescriptionAttribute = NSAttributeDescription()
        taskDescriptionAttribute.name = "taskDescription"
        taskDescriptionAttribute.attributeType = .stringAttributeType
        taskDescriptionAttribute.isOptional = true
        
        let statusAttribute = NSAttributeDescription()
        statusAttribute.name = "status"
        statusAttribute.attributeType = .stringAttributeType
        statusAttribute.isOptional = false
        // You could set a default value if needed, e.g., "todo"
        // statusAttribute.defaultValue = "todo"
        
        let createdAtAttribute = NSAttributeDescription()
        createdAtAttribute.name = "date"
        createdAtAttribute.attributeType = .dateAttributeType
        createdAtAttribute.isOptional = false
        
        taskEntity.properties = [
        
            idAttribute,
            titleAttribute,
            taskDescriptionAttribute,
            statusAttribute,
            createdAtAttribute
        
        ]
        
        let model = NSManagedObjectModel()
        model.entities = [taskEntity]
        
        return model
    }
    
}
