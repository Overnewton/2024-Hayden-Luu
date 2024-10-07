//
//  game1Stats.swift
//  Swish Tracker.
//
//  Created by Hayden Luu on 26/7/2024.
//

import Foundation

class Person: NSObject {
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var mobileNumber: String
    
    init(firstName: String, lastName: String, mobileNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
    }
}
