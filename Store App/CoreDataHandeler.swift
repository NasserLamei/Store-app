//
//  CoreDataHandeler.swift
//  Store App
//
//  Created by nassermac on 6/3/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHandeler {
    private static let objectCoreData = CoreDataHandeler()
    
   static func shared() ->CoreDataHandeler{
        return CoreDataHandeler.objectCoreData
    }
    
    
 func saveInCoreData(parameters:[String:Any]){
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appdelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Item", in: context)
            let entityObject = NSManagedObject(entity: entity!, insertInto: context)
            entityObject.setValue(parameters["FirstName"], forKey: "name")
            entityObject.setValue(parameters["Age"], forKey: "age")
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
            
            
        }
    }
    // this func  can use with any Entity ....
    
    func saveDataToEntity(entityName: String, attributes: [String: Any]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        
        let newEntity = NSManagedObject(entity: entityDescription, insertInto: context)
        
        for (key, value) in attributes {
            newEntity.setValue(value, forKey: key)
        }
        
        do {
            try context.save()
            print("Data saved successfully")
        } catch {
            print("Could not save data. \(error.localizedDescription)")
        }
    }
    
//
//    To use this function, you need to pass the name of the entity and a dictionary of attributes as parameters. The dictionary should contain the attribute names as keys and their corresponding values.
//
//    For example, if you have an entity called "User" with attributes "name", "age", "password", and "image", you can call the function like this:
//
//
//    let attributes = ["name": "John Doe", "age": 25, "password": "password123", "image": imageData]
//    saveDataToEntity(entityName: "User", attributes: attributes)
//
//
//    Note that the value for the "image" attribute should be a Data object containing the image data.
//
//    This function can be reused for any other entity by simply changing the name of the entity and passing in a dictionary of attributes with their corresponding values.
//
    
    
    
    
    
    
    func getDataFromCoreData()->[Items]?{
        if let appdelegate = UIApplication.shared.delegate as?AppDelegate{
            let context = appdelegate.persistentContainer.viewContext
            var arrayOfItems: [Items]?
            do{
                try arrayOfItems =  context.fetch(Items.fetchRequest())
                return arrayOfItems
            }catch{ return arrayOfItems }
        }
        return nil
    }
    
    
    
}
