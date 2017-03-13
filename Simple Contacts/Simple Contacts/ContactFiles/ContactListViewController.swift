//
//  ContactListViewController.swift
//  Simple Contacts
//
//  Created by Prashant Ugale on 13/03/17.
//  Copyright © 2017 prashantWork. All rights reserved.
//

import UIKit
import Contacts

class ContactListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contactTableView: UITableView?
    
    // Variables
    private var personsArray: [PersonContact] = []
    lazy private var contactStore: CNContactStore = {
        return CNContactStore()
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        configure()
        setupView()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
//        contactTableView?.isHidden = true
        contactTableView?.delegate = self
        contactTableView?.dataSource = self
//        contactTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
    }
    
    private func configure() {
        contactsPermission { (granted, errorMessage) in
            if granted {
                self.contactTableView?.isHidden = false
                self.fetchContactsFromStore()
            } else {
                self.showAlertWithAction(title: "Alert", message: errorMessage ?? "Need permission", okHandler: { (action) in
                    guard let settings = URL(string: UIApplicationOpenSettingsURLString) else {
                        return
                    }
                    UIApplication.shared.open(settings, options: [:], completionHandler: { [weak self] (success) in
                        guard let wSelf = self else {
                            return
                        }
                        if !success {
                            wSelf.showAlert(title: "Alert", message: "Not able to open settings application.")
                        }
                    })
                    
                }, cancelHandler: { (cancel) in
                    //
                })
            }
        }
    }
    
    private func contactsPermission(completionHandler:@escaping (_ isGranted: Bool, _ errorMessage: String?)-> Void) {
        let authorisationStatus = CNContactStore.authorizationStatus(for: .contacts)
        var errorMessage: String?
        
        switch authorisationStatus {
        case .authorized:
            completionHandler(true, errorMessage)
            
        case .denied, .notDetermined:
            contactStore.requestAccess(for: .contacts, completionHandler: { (granted, error) in
                if granted {
                    completionHandler(true, errorMessage)
                } else {
                    errorMessage = "Enable access to contacts from Settings"
                    completionHandler(false, errorMessage)
                }
            })
            
        case .restricted:
            completionHandler(false, errorMessage)
        }
    }
    
    private func fetchContactsFromStore() {
        
        let keysToFetch: [CNKeyDescriptor] = [CNContactEmailAddressesKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactIdentifierKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor, CNContactMiddleNameKey as CNKeyDescriptor,CNContactTypeKey as CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        fetchRequest.sortOrder = CNContactSortOrder.familyName
        do {
            _ = try contactStore.enumerateContacts(with: fetchRequest) { [weak self] (contact, mutableObjCPointer) in
                let newContact = PersonContact(contact: contact)
                self?.personsArray.append(newContact)
            }
        } catch {
            print("error while getting contacts from store")
        }
        contactTableView?.reloadData()
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = personsArray[indexPath.row].name
        cell.detailTextLabel?.text = personsArray[indexPath.row].mobilePhone
        return cell
    }

}
