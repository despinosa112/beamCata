//
//  CoreService.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/22/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit
import CoreData

class CoreService: NSObject {
    
    
    static func fetch(xCObjectName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping([NSManagedObject]?) -> ()){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: xCObjectName)
        if predicate != nil {
            fetchRequest.predicate = predicate!
        }
        if sortDescriptors != nil {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            let xCObjects = try managedContext.fetch(fetchRequest)
            completion(xCObjects)
        } catch {
            completion(nil)
        }
        
    }
    
    
    
    static func delete(xCObject: NSManagedObject){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(xCObject)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error xCObject: \(error.localizedDescription)")
        }
    }    
    
    static func save(_ nsManagedObject: NSManagedObject) {
        guard (UIApplication.shared.delegate as? AppDelegate) != nil else { return }
        let managedContext = nsManagedObject.managedObjectContext
        do {
            try managedContext?.save()
        } catch {
            print("ERROR: Not able to save xCObject")
        }
    }
    
    
    static func create(xCObjectName: String, data: [String : Any]) -> NSManagedObject?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: xCObjectName, in: managedContext) else { return nil }
        let xcObject = NSManagedObject(entity: entity, insertInto: managedContext)
        for (key, value) in data {
            xcObject.setValue(value, forKey: key)
        }
        return xcObject
    }
    
    
}
