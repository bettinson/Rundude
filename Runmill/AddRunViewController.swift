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

class AddRunViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var editDateButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var runs = [NSManagedObject]()
    
    var formattingPattern = "**:**:**"
    
    override func viewDidLoad() {
        let managedContext = appDelegate.managedObjectContext

        timeTextField.becomeFirstResponder()
        let entity = NSEntityDescription.entityForName("Run", inManagedObjectContext: managedContext)
        
        let run = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        let currentDate = NSDate()
        
        datePicker.date = currentDate
        
        //Set timeText to format as you type
        
    }
    
    
//    func timeTextDidChange() {
//        if count(timeTextField.text > 0 )
//    }
//    
    
    @IBAction func editDate(sender: AnyObject) {
        timeTextField.resignFirstResponder()
        distanceTextField.resignFirstResponder()
        
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        //Get CoreData context
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Run", inManagedObjectContext: managedContext)
        let run = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //Get date to save to run
        let savingDate = datePicker.date
        
        //Get time in seconds
        
        if (timeTextField.text) != nil {
            if let seconds = NSNumberFormatter().numberFromString(timeTextField.text!) {
                
            }
        }
        
        run.setValue(savingDate, forKey: "date")
        
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
        self.dismissViewControllerAnimated(true, completion: {})
    }
}