//
//  PeopleViewController.swift
//  ChatSocketIODemo
//
//  Created by simon heij on 22-02-19.
//  Copyright © 2019 simon heij. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController, ServerConnectionPeopleListDelegate {
    
    let serverConnection = ServerConnection.getInstance()

    var member : Person!
    var other : Person!
    var people = [PersonTableViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        serverConnection.peopleListDelegate = self
        serverConnection.getPeople()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "personIdentifier", for: indexPath) as! PersonTableViewCell

        cell = people[indexPath.row]
        return cell
    }
 
    func receivedPeople(_ people: [Person]) {
        self.people = [PersonTableViewCell]()
        for item in people {
            let cell = PersonTableViewCell()
            cell.person = item
            self.people.append(cell)
        }
        
        tableView.reloadData()
    }

    func receivedConnectRequest(from: String, in namespace: String) {
        
        for item in people {
            if item.person?.name == from {
                item.namespace = namespace
            }
        }
        
        let alert = UIAlertController(title: "Connection request from", message: from, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = tableView.cellForRow(at: indexPath) as! PersonTableViewCell
        
        other = row.person
        
        if row.namespace == nil || row.namespace!.isEmpty {
            serverConnection.connectTo(name: other.name)
        }else {
            serverConnection.joinNamespace(namespace: row.namespace!)
            performSegue(withIdentifier: "toChatIdentifier", sender: self)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController {
            let next = segue.destination as! ViewController
            next.member = member
            next.other = other
        }
    }

}
