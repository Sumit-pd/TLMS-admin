
//
//  RegexFields.swift
//  TLMS-admin
//
//  Created by Abcom on 08/07/24.
//

import SwiftUI

func validateName(name: String) -> Bool {
    let nameRegex = "^[a-zA-Z]{2,20}$"
    let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameRegex)
    return namePredicate.evaluate(with: name)
}
    
func validateEmail(email: String) -> Bool {
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}
    
func validatePassword(password: String) -> Bool {
    let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,20}$"
    let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
    return passwordPredicate.evaluate(with: password)
}
func validatePhone(phone: String) -> Bool {
    let phoneRegex = "^[+]?[0-9]*\\s?(\\d{3})\\s?[-\\s]?\\d{3}[-\\s]?\\d{4}$"
    let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    return phonePredicate.evaluate(with: phone)
}

    
func validateAbout(about: String) -> Bool {
    return about.count <= 255
}


