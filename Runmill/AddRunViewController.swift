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

//extension String {
//    struct NumberFormatter {
//        static let instance = NumberFormatter()
//    }
//    
//    var doubleValue:Double? {
//        return NumberFormatter().numberFromString(self)! as Double
//    }
//}

extension Double {
    init?(myCustomFormat:String) {
        guard let
            standardDouble = Double(myCustomFormat),
            let firstChar: Character? = myCustomFormat.characters.first,
            let lastChar: Character? = myCustomFormat.characters.last, firstChar != "." && lastChar != "."
            else { return nil }
        self = standardDouble
    }
}

class AddRunViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var editDateButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var runs = [NSManagedObject]()
    
    var formattedTimeText = ""
    var unformattedTimeText = ""
    
    override func viewDidLoad() {
        timeTextField.becomeFirstResponder()
        timeTextField.delegate = self
        
        timeTextField.addTarget(self, action: #selector(AddRunViewController.timeTextEditingDidChange), for: UIControlEvents.editingChanged)
    }
    
    //MARK - TextFieldActions
    
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
        
    
        if (timeTextField.text?.characters.count)! > 0 {
            formattedTimeText = formatter.changeText(unformattedTimeText)
            print("\(formattedTimeText)")
            
            timeTextField.text? = String(formattedTimeText.characters)
        }
        
        if (timeTextField.text?.characters.count)! >= 8 {
            
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            if textField == timeTextField {
                timeTextField.text = ""
                unformattedTimeText = ""
                formattedTimeText = ""
            }
        }
        return true
    }
    
    //MARK - UI Actions
    
    @IBAction func editDate(sender: AnyObject) {
        timeTextField.resignFirstResponder()
        distanceTextField.resignFirstResponder()
        
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        done()
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    
    //Mark - Saving methods
    
    func done() {
        //Get CoreData context
        var willSave = false
        let managedContext = appDelegate.managedObjectContext
        var saveSecondsString = ""
//        var saveDistanceString = ""
        var saveDistanceDouble = 0.0
        let entity = NSEntityDescription.entity(forEntityName: "Run", in: managedContext)
        
        
        //Get date to save to run
        let savingDate = datePicker.date
        
        if (timeTextField.text) != nil {
            if timeTextField.text! != ""{
                saveSecondsString = timeTextField.text!
                willSave = true
            } else {
                let alert = UIAlertController(title: "No time inputted", message:"Please add the time of your run", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}

                timeTextField.becomeFirstResponder()
                willSave = false
            }
            
        }
        
        if (distanceTextField.text) != nil {
            if distanceTextField.text! != ""{
                //TODO: Catch strings like ".101" or "4324132."
                saveDistanceDouble = Double(myCustomFormat: distanceTextField.text!)!
                
                willSave = true
                
                if !saveDistanceDouble.isFinite {
                    let alert = UIAlertController(title: "Invalid Distance", message:"Please change the distance of your run", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self.present(alert, animated: true){}

                    willSave = false
                }
                
            } else {
                let alert = UIAlertController(title: "No distance inputted", message:"Please add the distance of your run", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
                timeTextField.becomeFirstResponder()
                willSave = false
            }
        }
        
        if willSave {
            let run = NSManagedObject(entity: entity!, insertInto: managedContext)
            run.setValue(savingDate, forKey: "date")
            run.setValue(saveSecondsString, forKey: "timeRanString")
            run.setValue(saveDistanceDouble, forKey: "distance")
            
            do {
                try managedContext.save()
                runs.append(run)
                print ("\(run)")
            } catch {
                print("Error. Idk set a break point or something")
            }
            self.dismiss(animated: true, completion: {})
        }
        
        //Save shit
        
    }
    

}
