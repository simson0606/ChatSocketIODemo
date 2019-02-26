//
//  LoginViewController.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 22-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, ServerConnectionResponseDelegate {
    
    let serverConnection = ServerConnection.getInstance()

    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.delegate = self
        userNameTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        serverConnection.reconnect()
        serverConnection.responseDelegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        serverConnection.responseDelegate = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userNameTextField.text != nil {
        serverConnection.login(name: userNameTextField.text!)
            return true
        }
        return false
    }
    
    func receivedConnectRequest(from: String) {
        //nothing
    }
    
    func ack() {
        performSegue(withIdentifier: "toPeopleViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PeopleViewController {
            let next = segue.destination as! PeopleViewController
            next.member = Person(name: userNameTextField.text!, ip: "127.0.0.1")
        }
    }
    

}
