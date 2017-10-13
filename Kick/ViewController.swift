//
//  ViewController.swift
//  Kick
//
//  Created by BernSternWhoEarns on 7/7/17.
//  Copyright © 2017 BernSternWhoEarns. All rights reserved.
//

import UIKit
import CoreLocation
//import SocketIO

class ViewController: UIViewController, CLLocationManagerDelegate {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var all: UIButton!
    
    @IBOutlet weak var status: UILabel!
    
    @IBAction func oneButton(_ sender: UIButton) {
        let state = defaults.bool(forKey: "one")
        let background = state ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
        one.backgroundColor = background

        var oneD = [[ "light": "one", "status": state]] as [[String : Any]]
        
        toggleLight(oneD)
        toggleButton("one", state: state)

    }
    @IBAction func twoButton(_ sender: UIButton) {
        let state = defaults.bool(forKey: "two")
        let background = state ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
        
        two.backgroundColor = background
        var twoD = [[ "light": "two", "status": state]] as [[String : Any]]
        toggleLight(twoD)
        toggleButton("two", state: state)

    }
    
    @IBAction func threeButton(_ sender: UIButton) {
        let state = defaults.bool(forKey: "three")
        let background = state ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
        three.backgroundColor = background

        var threeD = [[ "light": "three", "status": state]] as [[String : Any]]
        toggleLight(threeD)
        toggleButton("three", state: state)

    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        let state = defaults.bool(forKey: "four")
        let background = state ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
        
        four.backgroundColor = background

        var fourD = [[ "light": "four", "status": state]] as [[String : Any]]
        toggleLight(fourD)
        toggleButton("four", state: state)

    }
    
    @IBAction func fiveButton(_ sender: UIButton) {
        let state = defaults.bool(forKey: "five")
        let background = state ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
        five.backgroundColor = background

        var fiveD = [[ "light": "five", "status": state]] as [[String : Any]]
        toggleLight(fiveD)
        toggleButton("five", state: state)

    }
    @IBAction func All(_ sender: UIButton) {
        let state = defaults.bool(forKey: "five")
        let background = state ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
        five.backgroundColor = background
        
        let allD = [[ "light": "two", "status": state], [ "light": "one", "status": state], [ "light": "three", "status": state], [ "light": "four", "status": state], [ "light": "five", "status": state]]
        
        toggleLight(allD)
        toggleButton("all", state: state)
    }
    
    
    func toggleButton(_ socket: String, state: Bool) {

        print("socket \(socket) status: \(state)")
        defaults.set(!state, forKey: socket)

    }
    
    func toggleLight(_ lights: [[String : Any]]) {
        SocketIOManager.sharedInstance.toggleLights(lights)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        one.layer.shadowColor = UIColor.black.cgColor
        one.layer.shadowOffset = CGSize(width: 5, height: 5)
        one.layer.shadowRadius = 5
        one.layer.shadowOpacity = 1.0
        
        two.layer.shadowColor = UIColor.black.cgColor
        two.layer.shadowOffset = CGSize(width: 5, height: 5)
        two.layer.shadowRadius = 5
        two.layer.shadowOpacity = 1.0
        
        three.layer.shadowColor = UIColor.black.cgColor
        three.layer.shadowOffset = CGSize(width: 5, height: 5)
        three.layer.shadowRadius = 5
        three.layer.shadowOpacity = 1.0
        
        four.layer.shadowColor = UIColor.black.cgColor
        four.layer.shadowOffset = CGSize(width: 5, height: 5)
        four.layer.shadowRadius = 5
        four.layer.shadowOpacity = 1.0
        
        five.layer.shadowColor = UIColor.black.cgColor
        five.layer.shadowOffset = CGSize(width: 5, height: 5)
        five.layer.shadowRadius = 5
        five.layer.shadowOpacity = 1.0
        
        all.layer.shadowColor = UIColor.black.cgColor
        all.layer.shadowOffset = CGSize(width: 5, height: 5)
        all.layer.shadowRadius = 5
        all.layer.shadowOpacity = 1.0
        
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

