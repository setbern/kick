//
//  KickTableViewController.swift
//  Kick
//
//  Created by BernSternWhoEarns on 9/8/17.
//  Copyright © 2017 BernSternWhoEarns. All rights reserved.
//

import UIKit
import CoreLocation

class KickTableViewController: UITableViewController, CLLocationManagerDelegate{
    
   
    var locationManager: CLLocationManager!
    
    let defaults = UserDefaults(suiteName: "group.bernardo")!
    
        //UserDefaults.standard
    var sockets = [Socket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.synchronize()
        //let state = defaults.bool(forKey: "one")
        sockets = [
            Socket(socketName: "one", status: defaults.bool(forKey: "one"), label: "Living Room" ),
            Socket(socketName: "two", status: defaults.bool(forKey: "two"), label: "Bed Room"),
            Socket(socketName: "three", status: defaults.bool(forKey: "three"), label: "Tweak Light"),
            Socket(socketName: "four", status: defaults.bool(forKey: "four"), label: "Kitchen"),
            Socket(socketName: "five", status: defaults.bool(forKey: "five"), label: "Volcano"),
        ]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rowssocket
        return sockets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocketCell", for: indexPath) as! SocketTableViewCell
        
        let background = sockets[indexPath.row].status ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
        
        cell.backgroundColor = background
        cell.mLabel.text = sockets[indexPath.row].label
        cell.selectionStyle = .none

       print("IndexPath.row \(indexPath.row)")
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect \(indexPath.row)")
        let status: Bool = sockets[indexPath.row].status
        let socketName: String = sockets[indexPath.row].socketName
        
        
        
        
        
        ApiClient.toggleLight(socket: [ sockets[indexPath.row] ])
            .then{ payload -> Void in
                print("payload for toggle light \(payload["toggleLights"])")
                if (payload["toggleLights"] == "done") {
                    print("socket \(socketName) new status \(!status)")
                    self.defaults.set( !status, forKey: socketName)
                    self.sockets = [
                        Socket(socketName: "one", status: self.defaults.bool(forKey: "one"), label: "Living Room"),
                        Socket(socketName: "two", status: self.defaults.bool(forKey: "two"), label: "Bed Room"),
                        Socket(socketName: "three", status: self.defaults.bool(forKey: "three"), label: "Tweak Light"),
                        Socket(socketName: "four", status: self.defaults.bool(forKey: "four"), label: "Kitchen"),
                        Socket(socketName: "five", status: self.defaults.bool(forKey: "five"), label: "Volcano"),
                    ]
                    
                    self.defaults.synchronize()
                    tableView.reloadData()
                    
                }
            }
                
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "SocketCell", for: indexPath) as! SocketTableViewCell
        //let background = sockets[indexPath.row].status ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
        
        //cell.backgroundColor = background
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 63870, minor: 20863, identifier: "VengaBoi")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        print(beacons)
        
        if beacons.count > 0 {
            updateDistance(beacons[0].proximity)
            if defaults.bool(forKey: "home") {
                print("already home")
            } else {
                self.defaults.set(true, forKey: "home")
                print("just got home")
                self.defaults.set(true, forKey: "left")
                let onSockets = [
                    Socket(socketName: "four", status: true, label: "Kitchen"),
                    Socket(socketName: "one", status: true, label: "Living Room"),
                    Socket(socketName: "two", status: true, label: "Bed Room"),
                    Socket(socketName: "three", status: true, label: "Tweak Light"),
                ]
                ApiClient.toggleLight(socket: onSockets)
                    .then{ payload -> Void in
                        print("payload for toggle light \(payload["toggleLights"])")
                        if (payload["toggleLights"] == "done") {
                            
                            self.sockets = [
                                Socket(socketName: "one", status: true, label: "Living Room"),
                                Socket(socketName: "two", status: true, label: "Bed Room"),
                                Socket(socketName: "three", status: true, label: "Tweak Light"),
                                Socket(socketName: "four", status: true, label: "Kitchen"),
                                Socket(socketName: "five", status: self.defaults.bool(forKey: "five"), label: "Volcano"),
                            ]
                            
                            self.tableView.reloadData()
                            
                        }
                }
            }
            
        } else {
            updateDistance(.unknown)
            self.defaults.set(false, forKey: "home")
            if defaults.bool(forKey: "left") {
                print("turn off all lights")
                
                let onSockets = [
                    Socket(socketName: "four", status: false, label: "Kitchen"),
                    Socket(socketName: "one", status: false, label: "Living Room"),
                    Socket(socketName: "two", status: false, label: "Bed Room"),
                    Socket(socketName: "three", status: false, label: "Tweak Light"),
                    ]
                ApiClient.toggleLight(socket: onSockets)
                    .then{ payload -> Void in
                        print("payload for toggle light \(payload["toggleLights"])")
                        if (payload["toggleLights"] == "done") {
                           
                            self.sockets = [
                                Socket(socketName: "one", status: false, label: "Living Room"),
                                Socket(socketName: "two", status: false, label: "Bed Room"),
                                Socket(socketName: "three", status: false, label: "Tweak Light"),
                                Socket(socketName: "four", status: false, label: "Kitchen"),
                                Socket(socketName: "five", status: self.defaults.bool(forKey: "five"), label: "Volcano"),
                            ]
                            
                            self.tableView.reloadData()
                            
                        }
                }
                self.defaults.set(false, forKey: "left")
            } else {
                print("has already left")
                //self.defaults.set(false, forKey: "left")
            }
            print("not home")
        }
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                
            case .far:
                self.view.backgroundColor = UIColor.black
                
            case .near:
                self.view.backgroundColor = UIColor.black
                
            case .immediate:
                self.view.backgroundColor = UIColor.black
            }
        }
    }
    
    
}
