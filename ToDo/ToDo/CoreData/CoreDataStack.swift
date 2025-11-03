//
//  CoreDataStack.swift
//  ToDo
//
//  Created by Ivan on 02.11.2025.
//


import CoreData

class CoreDataStack {
    
    enum StoreType {
        case sqlite
        case inMemory
    }
    
    private let storeType: StoreType
    
    // The persistent container that encapsulates the Core Data stack in our application.
    // Everyone can read it, only this class can modify it
    private(set) var persistentContainer: NSPersistentContainer
    
    // Computed property — a shortcut to get the main Core Data context
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    
    init(storeType: StoreType = .sqlite) {
        self.storeType = storeType
        let model = CoreDataModel.createModel()
        // Create the container that holds my Core Data stack
        self.persistentContainer = NSPersistentContainer(name: "Todo", managedObjectModel: model)
    }
    
    // Asynchronous method to load the persistent stores.
    func setupStack(completion: @escaping (Error?) -> Void) {
        let description = NSPersistentStoreDescription()
        
        if storeType == .inMemory {
            description.url = URL(fileURLWithPath: "/dev/null")
            
        }
        
        persistentContainer.persistentStoreDescriptions = [description]
        
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                
                print("Fialed to load persistent store: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            print("Successfully loaded persistent store at: \(storeDescription.url?.absoluteString ?? "N/A")")
            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            completion(nil)
        }
    }
}
