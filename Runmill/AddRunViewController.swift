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
    
    var formattedTimeText = ""
    var unformattedTimeText = ""
    
    override func viewDidLoad() {
        let managedContext = appDelegate.managedObjectContext

        timeTextField.becomeFirstResponder()
        timeTextField.delegate = self
        
        let entity = NSEntityDescription.entityForName("Run", inManagedObjectContext: managedContext)
        
        let currentDate = datePicker.date
        
        //This is the culprit
//        entity?.setValue(currentDate, forKey: "date")
        
        let run = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        run.setValue(currentDate, forKey: "date")
        
        
        
        timeTextField.addTarget(self, action: Selector("timeTextEditingDidChange"), forControlEvents: UIControlEvents.EditingChanged)
        
        
        
        //Set timeText to format as you type
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == timeTextField { // Switch focus to other text field
//            timeTextEditingDidEnd()
        } else if textField == distanceTextField {
            done()
        }
        return true
    }
    
    func timeTextEditingDidChange() {
        let formatter = TimeFormatter()
        let lastCharacterInputted = timeTextField.text!.characters.last!
        unformattedTimeText.append(lastCharacterInputted)
        
        if timeTextField.text?.characters.count > 0 {
            formattedTimeText = formatter.changeText(unformattedTimeText)
            print("\(formattedTimeText)")
            
            timeTextField.text? = String(formattedTimeText.characters)
        }
        
//        distanceTextField.becomeFirstResponder()
    }
    
    @IBAction func editDate(sender: AnyObject) {
        timeTextField.resignFirstResponder()
        distanceTextField.resignFirstResponder()
        
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        done()
    }
    
    func done() {
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