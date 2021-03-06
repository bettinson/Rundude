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
            beginEndButton.isHidden = true
        }
    }
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .fitness
        
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()
    
    lazy var locations = [CLLocation]()
    lazy var timer = Timer()
    
    func startRun() {
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepingCapacity: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                                        selector: #selector(NewRunViewController.eachSecond),
                                                        userInfo: nil,
                                                        repeats: true)
        startLocationUpdates()
    }
    
    //This delegate method is called every time the location is changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            if location.horizontalAccuracy < 20 {
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                }
                self.locations.append(location)
            }
        }
    }
    
    func eachSecond() {
        seconds += 1
        let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds)
        let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: distance)
        let paceUnit = HKUnit.second().unitDivided(by: HKUnit.meter())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
        
        setInfoText(seconds: secondsQuantity, distance: distanceQuantity, pace: paceQuantity)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        print("View is disappearing, time to save run")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.requestAlwaysAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


