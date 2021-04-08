//
//  ContactDetailView.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 06/04/21.
//

import Foundation
import SwiftUI

struct ContactProfileView: View {
    var nameInitials: String
    
    var body: some View {
        Text(nameInitials)
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .frame(width: 45, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(45/2)
            .background(LinearGradient(gradient: Gradient(colors: [Color.primary, Color.secondary.luminanceToAlpha()]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            .clipShape(Circle())
            .overlay(Circle().stroke(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, lineWidth: 2))
    }
}



struct ContactDetailView: View {
    var contact: Contact
    
    var body: some View {
        HStack {
            
            NavigationView {
                ContactProfileView(nameInitials: "\(contact.firstName ?? "") \(contact.lastName ?? "")".initials())
                    
                .navigationTitle(Text("Contact"))
            }
        }
    }
}


struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockedItems = Contact.mockedData
        ContactDetailView(contact: mockedItems.first!)
    }
}
