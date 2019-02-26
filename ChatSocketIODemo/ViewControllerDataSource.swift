//
//  ViewControllerDataExtension.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 26-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

extension ViewController: MessagesDataSource {
    func numberOfSections(
        in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() -> Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
}
