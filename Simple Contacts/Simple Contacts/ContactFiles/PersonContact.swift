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
    
    var firstName: String?
    var lastName: String?
    
    var phoneType: String?
    var mobilePhone: String?
    
    var isImageAvailable: Bool?
    var imageData: Data?
    
    init(contact: CNContact) {
        for phone in contact.phoneNumbers {
            if let phoneDict = phone.value(forKey: "value") as? CNPhoneNumber {
                firstName = contact.givenName
                lastName = contact.familyName
                
//                phoneType = contact.contactType
                mobilePhone = phoneDict.stringValue
                
                isImageAvailable = contact.imageDataAvailable
                imageData = contact.imageData
            }
        }
    }
}
