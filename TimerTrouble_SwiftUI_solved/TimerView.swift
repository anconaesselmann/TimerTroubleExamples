//  Created by Axel Ancona Esselmann on 7/14/24.
//

import SwiftUI

struct TimerView: View {

    @StateObject
    private var vm = TimerViewModel()

    var body: some View {
        VStack {
            Button(
                vm.isInactive ? "start" : "stop",
                action: vm.isInactive ? vm.startTimer : vm.stopTimer
            )
            Text(String(vm.elapsed))
        }
    }
}
