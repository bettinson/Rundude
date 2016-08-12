//
//  Run+CoreDataProperties.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-07-04.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Run {

    @NSManaged var distance: NSNumber?
    @NSManaged var timeRanString: String?
    @NSManaged var date: NSDate?
    @NSManaged var route: NSObject?

}
