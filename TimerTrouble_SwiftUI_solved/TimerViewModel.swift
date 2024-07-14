//  Created by Axel Ancona Esselmann on 7/14/24.
//

import SwiftUI

@MainActor
class TimerViewModel: ObservableObject {

    @Published
    private(set) var elapsed: Int = 0

    var isInactive: Bool {
        cancellable == nil
    }

    private var cancellable: TypeErasedCancellable?

    func startTimer() {
        cancellable = Timer(every: 1) { [weak self] in
            self?.elapsed += 1
        }.schedule()
    }

    func stopTimer() {
        cancellable = nil
    }
}
