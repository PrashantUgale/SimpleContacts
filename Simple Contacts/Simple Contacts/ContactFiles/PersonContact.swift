//
//  PersonContact.swift
//  Simple Contacts
//
//  Created by Prashant Ugale on 13/03/17.
//  Copyright © 2017 prashantWork. All rights reserved.
//

import Foundation
import Contacts

struct PersonContact {
    var name: String?
    var mobilePhone: String?
    
    init(contact: CNContact) {
        for phone in contact.phoneNumbers {
            if let phoneDict = phone.value(forKey: "value") as? CNPhoneNumber {
                mobilePhone = phoneDict.stringValue
                name = contact.givenName
            }
        }
    }
}
