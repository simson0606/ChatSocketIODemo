//
//  ServerConnection.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 22-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import Foundation
import SocketIO

class ServerConnection {
    
    private static var instance : ServerConnection? = nil
    static func getInstance() -> ServerConnection {
        if instance == nil {
            instance = ServerConnection()
            instance?.startListening()
        }
        return instance!
    }
    
    private var firstStart = true
    
    var messageDelegate: ServerConnectionMessageDelegate? = nil
    var responseDelegate: ServerConnectionResponseDelegate? = nil
    var peopleListDelegate: ServerConnectionPeopleListDelegate? = nil
        
    private var manager: SocketManager!
    private var socket: SocketIOClient?

    
    
    private func startListening(){
        manager = SocketManager(socketURL: URL(string: "http://"+Constants.ip+":3000")!, config: [.log(true), .compress])
    }
    
    private func on() {
        socket?.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket?.on("chat message") {data, ack in
            guard let cur = data[0] as? String else {
                return
            }
            
            self.messageDelegate?.receivedMessage(cur)
        }
        
        socket?.on("response") {data, ack in
            self.responseDelegate?.ack()
        }
        
        socket?.on("connect request") {data, ack in
            guard let person = data[0] as? String else {
                return
            }
            let decoder = JSONDecoder()
            let res = try! decoder.decode(ConnectionResult.self, from: person.data(using: .utf8)!)
            self.peopleListDelegate?.receivedConnectRequest(from: res.name, in: res.namespace)
            
        }
        
        socket?.on("users") {data, ack in
            guard let cur = data[0] as? String else {
                return
            }
            
            print(cur)
            
            let decoder = JSONDecoder()
            
            let people = try! decoder.decode([Person].self, from: cur.data(using: .utf8)!)
            self.peopleListDelegate?.receivedPeople(people)
        }
    }
    
    func off(){
        socket?.off(clientEvent: .connect)
        socket?.off("chat message")
        socket?.off("response")
        socket?.off("connect request")
        socket?.off("users")
    }
    
    func sendMessage(_ message: String) {
        socket?.emit("chat message", message)
        
    }
    
    func login(name: String){
        socket?.emit("add user", name)
    }
    
    func getPeople(){
        socket?.emit("list users")
    }
    
    func connectTo(name: String) {
        socket?.emit("connect to", name)
    }
    
    func joinNamespace(namespace: String) {
        off()
        socket = manager.socket(forNamespace: namespace)
        on()
        socket?.connect()
    }
    
    func reconnect() {
        if firstStart {
            firstStart = false
        }else {
            off()
        }
        socket = manager.defaultSocket
        on()
        socket?.connect()
    }

}
