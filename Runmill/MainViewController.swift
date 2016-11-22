//
//  MainViewController.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-07-04.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController, FloatingButtonDelegate {
    @IBOutlet weak var addButton: UIBarButtonItem!
	
	var runs = [NSManagedObject]()
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view, typically from a nib.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Run")
		let managedContext = appDelegate.managedObjectContext
		do {
			let results = try managedContext.fetch(fetchRequest)
			runs = results as! [NSManagedObject]
		} catch {
			print("Could not fetch runs")
		}
		sortListAscending()
	}
	
	//Handles animations of new run view icons
	@IBAction func newButtonTapped(sender: AnyObject) {
		let buttonContainer = FloatingButtonContainer(frame: (self.navigationController?.view.frame)!)
		buttonContainer.addRunButton!.delegate = self
		buttonContainer.newRunButton!.delegate = self
		self.navigationController?.view.addSubview(buttonContainer)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return runs.count
	}
	
	//J
	func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
		let run = runs[indexPath.row]
		let managedContext = appDelegate.managedObjectContext
		
		let done = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
			self.tableView.beginUpdates()
			managedContext.delete(run)
			self.runs.remove(at: indexPath.row)
			self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
			self.tableView.endUpdates()
		})
			
		do {
			try managedContext.save()
		} catch _ {
			print("Save did not work")
		}
		
		done.backgroundColor = UIColor.red
		return [done]
	}

	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! RunCell
		
		let run = runs[indexPath.row]
		
		//Should always have a date
		//Better to store as date and decode each time I think. More flexible with graph views
		
		let cellDate = run.value(forKey: "date") as! NSDate
		let cellDistance = run.value(forKey: "distance") as! Double
		let cellTime = run.value(forKey: "timeRanString") as! String
		
		let dateFormatter = DateFormatter()
		dateFormatter.locale = NSLocale.current
		dateFormatter.dateStyle = DateFormatter.Style.full
		
		let convertedDate = dateFormatter.string(from: cellDate as Date)
		
		cell.dateLabel?.text = convertedDate
		cell.distanceLabel?.text = String(cellDistance)
		cell.timeLabel?.text = cellTime
		
		return cell
	}
	
	func sortListAscending() {
		//If one of the runs has a date, assumes they all do and they can be sorted
		if runs.count > 1 && runs[0].value(forKey: "date") != nil {
			runs.sort () {($0.value(forKey: "date") as! NSDate).timeIntervalSince1970 > ($1.value(forKey: "date") as! NSDate).timeIntervalSince1970 }
		}
		tableView.reloadData()
	}
	
	func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "Add Run" {
			let addRunNavigationController = segue.destination as! UINavigationController
			let addRunViewController = addRunNavigationController.topViewController as! AddRunViewController
			addRunViewController.runs = runs
		}
	}
	
	func buttonWasTapped(sender: FloatingButtonDelegate, button: FloatingButton.viewRepresentingOptions) {
		switch button {
		case FloatingButton.viewRepresentingOptions.NewRun:
			// Present new run view
			print("Switch to new run view")
		case FloatingButton.viewRepresentingOptions.EnterRunData:
			// Present add run view
			print("Switch to add run view")
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

