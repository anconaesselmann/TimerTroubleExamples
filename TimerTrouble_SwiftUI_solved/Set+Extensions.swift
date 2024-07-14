//  Created by Axel Ancona Esselmann on 7/14/24.
//

import Foundation

extension Set where Element == TypeErasedCancellable {
    static func += (lhs: inout Self, rhs: Element) {
        lhs.insert(rhs)
    }
}
