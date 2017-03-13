//
//  HomeViewController.swift
//  Simple Contacts
//
//  Created by Prashant Ugale on 13/03/17.
//  Copyright © 2017 prashantWork. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    @IBOutlet weak var contactButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Simple View"
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        contactButton?.addTarget(self, action: #selector(showContacts(sender:)), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    
    func showContacts(sender: UIButton) {
        let contactsController = ContactListViewController(nibName: "ContactListViewController", bundle: nil)
        self.navigationController?.pushViewController(contactsController, animated: true)
    }
    

}
