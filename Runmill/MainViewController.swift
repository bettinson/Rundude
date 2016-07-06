//
//  MainViewController.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-07-04.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {
	var runs = [NSManagedObject]()
	let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
	
	override func viewWillAppear(animated: Bool) {
		
		
		let fetchRequest = NSFetchRequest(entityName: "Run")
		let managedContext = appDelegate.managedObjectContext
		
		do {
			let results = try managedContext.executeFetchRequest(fetchRequest)
			runs = results as! [NSManagedObject]
		} catch {
			print("Could not fetch runs")
		}
		sortListAscending()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return runs.count
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "Add Run" {
			let addRunNavigationController = segue.destinationViewController as! UINavigationController
			let addRunViewController = addRunNavigationController.topViewController as! AddRunViewController
			addRunViewController.runs = runs
		}
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		
		let run = runs[indexPath.row]
		
		//Should always have a date
		//Better to store as date and decode each time I think. More flexible with graph views
		
		let cellDate = run.valueForKey("date") as! NSDate
		
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale.currentLocale()
		dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
		
		let convertedDate = dateFormatter.stringFromDate(cellDate)
		
		cell.textLabel?.text = convertedDate
		return cell
	}
	
	func sortListAscending() {
		runs.sortInPlace () {($0.valueForKey("date") as! NSDate).timeIntervalSince1970 > ($1.valueForKey("date") as! NSDate).timeIntervalSince1970 }
		tableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

