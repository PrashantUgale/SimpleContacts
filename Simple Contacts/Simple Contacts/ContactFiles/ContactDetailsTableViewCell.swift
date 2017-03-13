//
//  ContactDetailsTableViewCell.swift
//  Simple Contacts
//
//  Created by Prashant Ugale on 13/03/17.
//  Copyright © 2017 prashantWork. All rights reserved.
//

import UIKit

class ContactDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImageView: UIImageView?
    @IBOutlet weak var initialsLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var mobileLabel: UILabel?
    @IBOutlet weak var mobileTypeLabel: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialsLabel?.backgroundColor = UIColor.lightGray
    }
    
    // MARK: - Public Methods
    
    func configureCell(person: PersonContact) {
        
        initialsLabel?.layer.cornerRadius = 25
        initialsLabel?.clipsToBounds = true
        var nameString = ""
        var initialCharacters = ""
        if let lastName = person.lastName, lastName.characters.count > 0 {
            nameString = lastName
            if let lastInitial = lastName.characters.first {
                initialCharacters = "\(lastInitial)".uppercased()
            }
        }
        if let firstName = person.firstName, firstName.characters.count > 0 {
            if nameString.characters.count > 0 {
                nameString = "\(nameString) \(firstName)"
                if let firstInitial = firstName.characters.first {
                    initialCharacters = "\(initialCharacters)\(firstInitial)".uppercased()
                }
            } else {
                nameString = firstName
                if let firstInitial = firstName.characters.first {
                    initialCharacters = "\(firstInitial)".uppercased()
                }
            }
        }
        contactImageView?.isHidden = true
        nameLabel?.text = nameString
        mobileLabel?.text = person.mobilePhone
        initialsLabel?.text = initialCharacters
    }
    
}
