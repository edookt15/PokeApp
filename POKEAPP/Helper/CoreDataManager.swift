//
//  CoreDataManager.swift
//  POKEAPP
//
//  Created by Phincon on 21/08/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
  
  //1
  static let sharedManager = CoreDataManager()
  //2.
  private init() {} // Prevent clients from creating another instance.
  
  //3
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "Pokemon")
    
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  //4
  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
    
    func insertPerson(name: String, image : Data) -> Pokemons? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Pokemons",
                                                in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(name, forKeyPath: "name")
        person.setValue(image, forKeyPath: "image")
        
        do {
          try managedContext.save()
          return person as? Pokemons
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
          return nil
        }
      }
    
    func fetchAllPersons() -> [Pokemons]?{
        
        
        /*Before you can do anything with Core Data, you need a managed object context. */
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pokemons")
        
        do {
          let people = try managedContext.fetch(fetchRequest)
          return people as? [Pokemons]
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
          return nil
        }
        
      }
    
    func DeleteAllData(){

        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemons"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }
    
    
}

