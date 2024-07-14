//  Created by Axel Ancona Esselmann on 7/14/24.
//

import Foundation

final class TypeErasedCancellable {

    private var onDeinit: () -> Void

    init(_ cancel: @escaping () -> Void) {
        self.onDeinit = cancel
    }

    deinit {
        onDeinit()
    }
}

extension TypeErasedCancellable: Hashable {

    private var identifier: ObjectIdentifier {
        ObjectIdentifier(self)
    }

    static func == (lhs: TypeErasedCancellable, rhs: TypeErasedCancellable) -> Bool {
        lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension TypeErasedCancellable {
    func store(in cancellables: inout Set<TypeErasedCancellable>) {
        cancellables.insert(self)
    }
}
