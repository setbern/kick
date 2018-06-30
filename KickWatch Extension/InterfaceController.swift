//
//  InterfaceController.swift
//  KickWatch Extension
//
//  Created by BernSternWhoEarns on 12/28/17.
//  Copyright © 2017 BernSternWhoEarns. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var mTableView: WKInterfaceTable!
    
    
    var sockets = [Socket]()
    let defaults = UserDefaults(suiteName: "group.bernardo")!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        defaults.synchronize()

        sockets = [
            Socket(socketName: "one", status: defaults.bool(forKey: "one"), label: "Living Room" ),
            Socket(socketName: "two", status: defaults.bool(forKey: "two"), label: "Bed Room"),
            Socket(socketName: "three", status: defaults.bool(forKey: "three"), label: "Tweak Light"),
            Socket(socketName: "four", status: defaults.bool(forKey: "four"), label: "Kitchen"),
            Socket(socketName: "five", status: defaults.bool(forKey: "five"), label: "Volcano"),
        ]
        
        mTableView.setNumberOfRows(sockets.count, withRowType: "WatchSocketRow")
        
        setupTable()
        // Configure interface objects here.
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("clicked on row \(rowIndex)")
        
        let status: Bool = sockets[rowIndex].status
        let socketName: String = sockets[rowIndex].socketName
        
        
        ApiClient.toggleLight(socket: [ sockets[rowIndex] ])
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
                    self.setupTable()
                }
        }
    }
    
    func setupTable() {
        for (index, socket) in sockets.enumerated() {
            let row = mTableView.rowController(at: index) as! WatchSocketRow
            
            
            let background = sockets[index].status ? UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0): UIColor(red:0.00, green:0.65, blue:0.93, alpha:1.0)
            
            //row.backgroundColor = background
            row.mGroup.setBackgroundColor(background)
            
            row.mLabel.setText(sockets[index].label)
        }
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
