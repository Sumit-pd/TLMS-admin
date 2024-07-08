//
//  TargetViewModel.swift
//  TLMS-admin
//
//  Created by Abcom on 08/07/24.
//

import Foundation
import SwiftUI

class TargetViewModel : ObservableObject {
    @Published var targets : [Target] = []
    
    func addTarget(title : String) {
        let newTarget = Target(id: UUID(), targetName: title, courses: [])
        targets.append(newTarget)
    }
    
    func removeTarget(target : Target) {
        if let index = targets.firstIndex(where: {$0.id == target.id}) {
            targets.remove(at: index)
        }
    }
}
