//
//  SocketIOManager.swift
//  Kick
//
//  Created by BernSternWhoEarns on 7/9/17.
//  Copyright © 2017 BernSternWhoEarns. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    var socket = SocketIOClient(socketURL: URL(string: "http://192.168.10.56:3000")!, config: [.log(false), .forcePolling(true)])
    //var socket = SocketIOClient(socketURL: URL(string:  "https://kicks-pi.herokuapp.com")!, config: [.log(false), .forcePolling(true)])

    override init() {
        super.init()
        print("we lit")
        socket.on(clientEvent: .connect) { data, ack in
            print("boolin bracka bracka")
        }
        
        socket.on("test") { dataArray, ack in
            print(dataArray)
        }
        
    }
    
    func establishConnection() {
        print("lit")
        socket.connect()
    }
    
    func turnOnSocket(_ port: String) {
        print("toggle button")
        socket.emit("on", port)
        
    }
    func turnOffSocket(_ port: String) {
        print("toggle button")
        socket.emit("off", port)

    }
    func closeConnection() {
        socket.disconnect()
    }
}