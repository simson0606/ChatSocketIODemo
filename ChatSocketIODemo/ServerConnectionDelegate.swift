//
//  ServerConnectionDelegate.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 22-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import Foundation

protocol ServerConnectionMessageDelegate {
    func receivedMessage(_ message: String)
}

protocol ServerConnectionResponseDelegate {
    func ack()
}

protocol ServerConnectionPeopleListDelegate {
    func receivedPeople(_ people: [Person])
    func receivedConnectRequest(from: String, in namespace: String)
}
