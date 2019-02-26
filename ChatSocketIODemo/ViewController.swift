//
//  ViewController.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 19-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import UIKit
import MessageKit

class ViewController: MessagesViewController, ServerConnectionMessageDelegate {

    var messages: [Message] = []
    var member: Person!
    var other : Person!
    
    let serverConnection = ServerConnection.getInstance()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        serverConnection.messageDelegate = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        serverConnection.messageDelegate = nil
    }
    
    func receivedMessage(_ message: String) {
        let newMessage = Message(
            member: other,
            text: message,
            messageId: UUID().uuidString)
        messages.append(newMessage)
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }

}

