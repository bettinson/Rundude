//
//  AddRunViewController.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-07-04.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddRunViewController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var runs = [NSManagedObject]()
   
    @IBAction func doneAction(sender: AnyObject) {
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Run", inManagedObjectContext: managedContext)
        
        let run = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        let currentDate = NSDate()
        
        run.setValue(currentDate ,forKey: "date")
        
        do {
            try managedContext.save()
            runs.append(run)
            print ("\(run)")
        } catch {
            print("Error. Idk set a break point or something")
        }
        
        self.dismissViewControllerAnimated(true, completion: {})
        //Save shit
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        
    }
    
}