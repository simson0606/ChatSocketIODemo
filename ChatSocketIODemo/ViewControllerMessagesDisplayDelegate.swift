//
//  ViewControllerMessagesDisplaydDelegate.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 26-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

extension ViewController: MessagesDisplayDelegate {
    func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) {
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
            
        }
        
    }
    

}
