//
//  CoreDataStack.swift
//  CoreDataStack
//
//  Created by Fahir Mehovic on 5/27/15.
//  Copyright (c) 2015 Fahir Mehovic. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    let context: NSManagedObjectContext;
    let psc: NSPersistentStoreCoordinator;
    let model: NSManagedObjectModel;
    
    init() {
    
        let bundle = NSBundle.mainBundle();
        
        let modelURL = bundle.URLForResource("Data", withExtension: "momd")!;
        
        model = NSManagedObjectModel(contentsOfURL: modelURL)!;
        
        psc = NSPersistentStoreCoordinator(managedObjectModel: model);
        
        context = NSManagedObjectContext();
        context.persistentStoreCoordinator = psc;
        
        let appDir = applicationDocumentDirectory();
        let storeURL = appDir.URLByAppendingPathComponent("Data");
        
        let option = [NSMigratePersistentStoresAutomaticallyOption: true];
        
        do {
        
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: option);
            
        } catch {
            print("Problem Creating Store");
            abort();
        }
        
    }
    
    func saveContext() {
        do {
        
            try context.save()
            
        } catch {
            print("Could Not Save");
        }
    }
    
    func applicationDocumentDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager();
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask);
        return urls[0];
    }
    




}








































