//
//  DataServiceProtocol.swift
//  ToDo
//
//  Created by Ivan on 02.11.2025.
//


import Foundation

// This is key for dependency injection and testing.

protocol DataServiceProtocol {
    func fetchTasks(completion: @escaping (Result<[Task], Error>) -> Void)
}
