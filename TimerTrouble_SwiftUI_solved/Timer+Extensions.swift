//  Created by Axel Ancona Esselmann on 7/14/24.
//

import Foundation

extension Timer {

    func schedule(
        on runLoop: RunLoop = .main,
        forMode mode: RunLoop.Mode = .default,
        onCanceled: (() -> Void)? = nil
    ) -> TypeErasedCancellable {
        runLoop.add(self, forMode: mode)
        return TypeErasedCancellable { [weak self] in
            self?.invalidate()
            onCanceled?()
        }
    }

    @MainActor
    convenience init(
        every timeInterval: Double,
        repeat block: @escaping @MainActor () -> Void
    ) {
        self.init(timeInterval: timeInterval, repeats: true) { _ in
            Task { @MainActor in  block() }
        }
    }

    @MainActor
    convenience init(
        once timeInterval: Double,
        repeat block: @escaping @MainActor () -> Void
    ) {
        self.init(timeInterval: timeInterval, repeats: false) { _ in
            Task { @MainActor in block() }
        }
    }
}
