//
//  PersonTableViewCell.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 26-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    private var _person: Person?
    var person: Person? {
        get {
            return _person
        }
        set {
            _person = newValue
            self.textLabel?.text = "\(_person?.name ?? "")"
        }
    }
    
    var namespace: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
