//
//  NewRunViewController.swift
//  Rundude
//
//  Created by Matt Bettinson on 2016-06-17.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//https://www.raywenderlich.com/97944/make-app-like-runkeeper-swift-part-1

import UIKit
import CoreLocation
import HealthKit
import MapKit

class NewRunViewController : UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoText: UILabel!
    
    
    var seconds = 0.0
    var distance = 0.0
    var isRunning = false
    
    @IBOutlet weak var beginEndButton: UIButton!
    
    @IBAction func beginRun(sender: AnyObject) {
        if (isRunning == false) {
            startRun()
            beginEndButton.hidden = true
        }
    }
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .Fitness
        
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()
    
    lazy var locations = [CLLocation]()
    lazy var timer = NSTimer()
    
    func startRun() {
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepCapacity: false)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self,
                                                        selector: #selector(NewRunViewController.eachSecond(_:)),
                                                        userInfo: nil,
                                                        repeats: true)
        startLocationUpdates()
    }
    
    //This delegate method is called every time the location is changed
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            if location.horizontalAccuracy < 20 {
                if self.locations.count > 0 {
                    distance += location.distanceFromLocation(self.locations.last!)
                }
                self.locations.append(location)
            }
        }
    }
    
    func eachSecond(timer: NSTimer) {
        seconds += 1
        let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: seconds)
        let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: distance)
        let paceUnit = HKUnit.secondUnit().unitDividedByUnit(HKUnit.meterUnit())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
        
        
        setInfoText(secondsQuantity, distance: distanceQuantity, pace: paceQuantity)
    }
    
    func setInfoText(seconds: HKQuantity, distance: HKQuantity, pace: HKQuantity) {
        infoText.text = "You've done \(distance.description) in \(seconds.description), at a pace of \(pace). Good job!"
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginEndButton.titleLabel!.text = "Done"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        print("View is disappearing, time to save run")
    }
    
    override func viewWillAppear(animated: Bool) {
        locationManager.requestAlwaysAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


