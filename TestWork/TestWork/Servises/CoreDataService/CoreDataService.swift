//
//  CoreDataService.swift
//  TestWork
//
//  Created by Polina on 10.03.2022.
//

import Foundation
import CoreData

final class CoreDataService {
    
    //MARK: - Init
    
    static let shared = CoreDataService()
    private init() {}
    
    //MARK: - CoreData Stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
