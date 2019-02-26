//
//  Message.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 26-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import Foundation
import MessageKit

struct Message: Codable {
    let member: Person
    let text: String
    let messageId: String
}

extension Message: MessageType {
    var sender: Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    var sentDate: Date {
        return Date()
    }
    
    var kind: MessageKind {
        return .text(text)
    }

}
