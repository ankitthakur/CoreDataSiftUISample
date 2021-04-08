//
//  ContactView.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 02/04/21.
//

import SwiftUI

struct ContactCell: View {
    let contact: Contact
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("\(contact.firstName ?? "") \(contact.lastName ?? "")")
            Text("\(contact.emailAddress ?? "")")
        })
    }
}

struct ContactListView: View {
    var contacts: [Contact] = []
    
    var body: some View {
        NavigationView {
            List(contacts) { contact in
                NavigationLink(destination: ContactCell(contact: contact)) {
                    ContactCell(contact: contact)
                }
            }
            .navigationTitle(Text("Contacts"))
        }
    }
}


struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockedItems = Contact.mockedData
        ContactListView(contacts: mockedItems)
    }
}


