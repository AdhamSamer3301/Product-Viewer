//
//  CoreDataManager.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext: NSManagedObjectContext!
    let entity: NSEntityDescription!
    let entityName: String = "ProductsDB"
    private static var coreDataObj: CoreDataManager?
        
    public static func getInstance() -> CoreDataManager {
        if let instance = coreDataObj {
            return instance
        } else {
            coreDataObj = CoreDataManager()
            return coreDataObj!
        }
    }
    
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
    }
    
    func saveToCoreData(item: ProductClass?) {
        guard let entity = entity else { return }
        let productToSave = NSManagedObject(entity: entity, insertInto: managedContext)
        productToSave.setValue(item?.name, forKey: "name")
        productToSave.setValue(item?.id, forKey: "id")
        productToSave.setValue(item?.description, forKey: "details")
        productToSave.setValue(item?.imageUrl, forKey: "image")
        productToSave.setValue(item?.price, forKey: "price")
        do {
            try managedContext.save()
            print("Saved")
        } catch let error {
            print("Failed")
            print(error.localizedDescription)
        }
    }
    
    func fetchFromCoreData() -> [NSManagedObject] {
        var products: [NSManagedObject]?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            products = try managedContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return products ?? []
    }
    
    func deleteFromCoreData(itemToDelete: ProductClass) {
        let products = fetchFromCoreData()
        for product in products {
            if product.value(forKey: "id") as? String == itemToDelete.name {
                managedContext.delete(product)
                try? managedContext.save()
            }
        }
    }
}

