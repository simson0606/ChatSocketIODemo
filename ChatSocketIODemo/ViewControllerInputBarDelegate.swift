//
//  ViewControllerInputBarDelegate.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 26-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import Foundation
import UIKit
import MessageKit
import MessageInputBar

extension ViewController: MessageInputBarDelegate {
    func messageInputBar(
        _ inputBar: MessageInputBar,
        didPressSendButtonWith text: String) {
        
        let newMessage = Message(
            member: member,
            text: text,
            messageId: UUID().uuidString)
        
        messages.append(newMessage)
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
        serverConnection.sendMessage(newMessage.text)
    }
}
