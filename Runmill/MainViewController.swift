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
		
		print ("Hey!")
		let fetchRequest = NSFetchRequest(entityName: "Run")
		let managedContext = appDelegate.managedObjectContext
		
		do {
			let results = try managedContext.executeFetchRequest(fetchRequest)
			runs = results as! [NSManagedObject]
		} catch {
			print("Could not fetch runs")
		}
		tableView.reloadData()
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
		let cellDate = run.valueForKey("date") as! NSDate
		
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale.currentLocale()
		dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
		
		var convertedDate = dateFormatter.stringFromDate(cellDate)
		
		cell.textLabel?.text = convertedDate
		return cell
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

}

