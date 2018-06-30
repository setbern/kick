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
//    static let sharedInstance = SocketIOManager()
//    static var connection : String = "dissconcted"
//
//    var socket = SocketIOClient(manager: URL(string: "http://192.168.1.78:3000")! as! SocketManagerSpec, nsp: [.log(false), .forcePolling(true)])
//    //var socket = SocketIOClient(socketURL: URL(string:  "https://kicks-pi.herokuapp.com")!, config: [.log(false), .forcePolling(true)])
//
////    override init() {
////        super.init()
////        print("we lit")
////
////        socket.on(clientEvent: .connect) { data, ack in
////            print("boolin bracka bracka")
////            self.connection = "connected"
////
////        }
////        socket.on(clientEvent: .dissconnect) { data, ack in
////            print("dissconected")
////        }
////        socket.on("test") { dataArray, ack in
////            print(dataArray)
////        }
////
////    }
//
//    func establishConnection() {
//        print("lit connection")
//        socket.connect()
//    }
//
//    func turnOnSocket(_ port: String) {
//        print("toggle button")
//        socket.emit("on", port)
//
//    }
//    func turnOffSocket(_ port: String) {
//        print("toggle button")
//        socket.emit("off", port)
//
//    }
//    func toggleLights( _ ports: [Dictionary<String, Any>]) {
//        print("ports \(ports)")
//        socket.emit("toggle", ports)
//    }
//    func closeConnection() {
//        print("not lit disconnected")
//        //self.connection = "Disconcted"
//        socket.disconnect()
//    }
}
