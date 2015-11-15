//
//  ViewController.swift
//  CoreDataStack
//
//  Created by Fahir Mehovic on 5/27/15.
//  Copyright (c) 2015 Fahir Mehovic. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    var students: [Student] = [];
    var context: NSManagedObjectContext!;
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) ;
        cell.textLabel?.text = students[indexPath.row].name;
        return cell;
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            
            let item = students[indexPath.row]
            students.removeAtIndex(indexPath.row)
            context.deleteObject(item)
            
            try! context.save()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Students";
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        let request = NSFetchRequest(entityName: "Student");
        
        do {
        
            try students = context.executeFetchRequest(request) as! [Student];
            
        } catch {
            print("Could not load data");
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveStudent(name: String) {
        let student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context!) as! Student;
        student.name = name;
        
        do {
        
            try context.save();
            
        } catch {
            print("Could not save data");
        }
        
        students.append(student);
        
    }

    @IBAction func addStudent(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Student", message: "Add New Student", preferredStyle: .Alert);
        
        let save = UIAlertAction(title: "Save", style: .Default) { (alertAction: UIAlertAction) -> Void in
            let textField = alert.textFields![0] ;
            self.saveStudent(textField.text!);
            self.myTableView.reloadData();
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (alertAction: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
        }
        
        alert.addAction(save);
        alert.addAction(cancel);
        
        presentViewController(alert, animated: true, completion: nil);
        
    }

}

