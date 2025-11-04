    //
    //  TaskListVM.swift
    //  ToDo
    //
    //  Created by Ivan on 04.11.2025.
    //

    import Foundation

    class TaskListVM {
        
        let dataService: DataServiceProtocol
        
        private(set) var tasks: [Task] = []
        
        var didTaskUpdate: (() -> Void)?
        
        var numberOfTasks: Int {
            
            tasks.count
        }
        
        func taskTitle(at index: Int) -> String {
        
            guard tasks.indices.contains(index) else {
                return ""
            }
            
            return tasks[index].title
        }
        
        
        func taskStatus(at index: Int) -> String {
            guard tasks.indices.contains(index) else {
                return ""
            }
            
            return tasks[index].status
        }
        
        
        
        init(dataService: DataServiceProtocol) {
            self.dataService = dataService
        }
        

        func fetchTasks() {
            dataService.fetchTasks { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    
                    switch result {
                    case .failure(let error):
                        print("error \(error.localizedDescription)")
                        
                    case .success(let arrayoOfTasks):
                        self.tasks = arrayoOfTasks
                    }

                    
                    self.didTaskUpdate?()
                }
                
              
                
            }
        }
        
    }


