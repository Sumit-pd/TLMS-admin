//
//  Tagets.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 06/07/24.
//

import Foundation

final class Targets : Identifiable {
    var id = UUID()
    var title : String = ""
    
    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}
