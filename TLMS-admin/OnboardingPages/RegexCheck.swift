
//
//  RegexFields.swift
//  TLMS-admin
//
//  Created by Abcom on 08/07/24.
//

import SwiftUI

func validateName(name: String) -> Bool {
    let nameRegex = "^[a-zA-Z ]{1,20}$"
    let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameRegex)
    return namePredicate.evaluate(with: name)
}
    
func validateEmail(email: String) -> Bool {
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}
    
func validatePassword(_ password: String) -> Bool {
    let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z\\d]).{8,}$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return predicate.evaluate(with: password)
}

func validatePhoneNumber(_ phoneNumber: String) -> Bool {
    let phoneRegex = "^[1-9][0-9]{9}$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    return predicate.evaluate(with: phoneNumber)
}

func validateTitle(title: String) -> Bool {
    let nameRegex = "^[a-zA-Z0-9 ]{1,30}$"
    let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameRegex)
    return namePredicate.evaluate(with: title)
}
    
func validateAbout(about: String) -> Bool {
    return about.count <= 255
}


