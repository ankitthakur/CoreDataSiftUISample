//
//  ContactJSONModel.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 06/04/21.
//

import Foundation

struct ContactListObject: Codable {
    let contacts: [ContactObject]?
}

struct ContactObject: Codable {
    let firstName, lastName, emailAddress, jobTitle, locationCountry: String?
    let phoneNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case emailAddress = "email_address"
        case phoneNumber = "phone_number"
        case jobTitle = "job_title"
        case locationCountry = "location_country"
    }
}
