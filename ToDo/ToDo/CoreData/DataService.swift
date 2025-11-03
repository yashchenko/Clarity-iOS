//
//  DataService.swift
//  ToDo
//
//  Created by Ivan on 02.11.2025.
//

import Foundation
import CoreData

class DataService: DataServiceProtocol {
    
    let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    
    func fetchTasks(completion: @escaping (Result<[Task], Error>) -> Void) {
    // We use the viewContext because this is a read operation for the UI.
        
        let context = coreDataStack.viewContext
        let fetchRequest = Task.fetchRequest() as NSFetchRequest<Task>
        
        // sorting: newest task first
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)]
        
        do {
            let tasks = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                completion(.success(tasks))
            }
        } catch {
            print("Failed to fetch tasks: \(error.localizedDescription)")
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            
        }
        
    }
    
}
