//
//  ContactExtension.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 02/04/21.
//

import Foundation
import CoreData

extension Contact {
    
    static func newContact(inContext context: NSManagedObjectContext) -> Contact? {
        return NSEntityDescription.insertNewObject(forEntityName: "Contact",
                                                   into: context) as? Contact
    }
    
    static var mockedData: [Contact] = loadPreviewData()
    static func loadPreviewData() -> [Contact] {
        Contact.importMockedJSON()
        let contacts = Contact.contactList()
        return contacts
    }
    static func contactList() -> [Contact] {
        do {
            let request: NSFetchRequest<Contact> = Contact.fetchRequest()
            let context = CoreDataManager.shared.viewContext
            let contacts = try context.fetch(request)
            return contacts
        } catch let error {
            print(error)
        }
        
        return []
    }
    
    static func importMockedJSON() {
        do {
            guard let path = Bundle.main.path(forResource: "MockedContacts", ofType: "json"),
                  let data = FileManager.default.contents(atPath: path) else {return}
            print(String(data: data, encoding: .utf8))
            let contactListObject = try JSONDecoder().decode(ContactListObject.self, from: data)
            guard let contactList = contactListObject.contacts else {return}
            let context = CoreDataManager.shared.backgroundManagedObjectContext()
            context.performAndWait {
                for contactObject in contactList {
                    guard var contact = Contact.newContact(inContext: context) else {continue}
                    contact.firstName = contactObject.firstName
                    contact.lastName = contactObject.lastName
                    contact.emailAddress = contactObject.emailAddress
                    if let phoneNumber = contactObject.phoneNumber, phoneNumber > 0 {
                        contact.phoneNumber = String(phoneNumber)
                    }
                    contact.nameFirstChar = "\(contact.firstName ?? "") + \(contact.lastName ?? "")".initials()
                    contact.isVisible = true
                }
                
                _ = CoreDataManager.shared.saveBackgroundContext(inContext: context)
            }
            
        } catch let error {
            print(error)
        }
    }
    
}
