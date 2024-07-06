import SwiftUI

class TargetViewModel: ObservableObject {
    @Published var targets: [Targets] = []
    
    func addTarget(title: String) {
        let newTarget = Targets(title: title)
        targets.append(newTarget)
        
    }
    func removeTarget(target: Targets) {
        if let index = targets.firstIndex(where: { $0.id == target.id }) {
            targets.remove(at: index)
        }
    }
}
