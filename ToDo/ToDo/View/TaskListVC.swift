//
//  TaskListVC.swift
//  ToDo
//
//  Created by Ivan on 05.11.2025.
//

import UIKit

class TaskListVC: UIViewController {
    
    let vm: TaskListVM
    let cellIdentifier = "TaskCell"
    let taskTableView = UITableView()
    let spinIndicator = UIActivityIndicatorView(style: .large)
    let emptyLabel = UILabel()
    
    
    init(vm: TaskListVM) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableViewSetup()
        setupBindings()
        
        spinIndicator.startAnimating()
        vm.fetchTasks()
        
    }
    
    func setupUI() {
        
        view.backgroundColor = .systemBackground
        self.title = "Tasks"
        
        spinIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinIndicator)
        
        emptyLabel.text = "No tasks yet"
        emptyLabel.textColor = .secondaryLabel
        emptyLabel.textAlignment = .center
        emptyLabel.isHidden = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            spinIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
    }
    

    func tableViewSetup() {
        
        taskTableView.dataSource = self
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        taskTableView.isHidden = true
        taskTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(taskTableView)
        
        NSLayoutConstraint.activate([
        
            taskTableView.topAnchor.constraint(equalTo: view.topAnchor),
            taskTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            
            
        ])
    }
    
    func setupBindings() {
        vm.didTaskUpdate = { [weak self] in
            guard let self = self else { return }
            
            self.spinIndicator.stopAnimating()
            
            if self.vm.numberOfTasks == 0 {
                self.taskTableView.isHidden = true
                self.emptyLabel.isHidden = false
            } else {
                
                self.taskTableView.isHidden = false
                self.emptyLabel.isHidden = true
                self.taskTableView.reloadData()
                
            }
            
        }
    }
}

extension TaskListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfTasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let title = vm.taskTitle(at: indexPath.row)
        let status = vm.taskStatus(at: indexPath.row)
        
        var content = cell.defaultContentConfiguration()
        content.text = title
        content.secondaryText = "Status: \(status)"
        cell.contentConfiguration = content
        
        return cell
    
    }
}
