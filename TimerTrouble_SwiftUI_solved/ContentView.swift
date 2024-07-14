//  Created by Axel Ancona Esselmann on 7/14/24.
//

import SwiftUI

struct ContentView: View {

    @State
    private var timerIsShowing = true

    var body: some View {
        VStack {
            if timerIsShowing {
                TimerView()
            }
            Button(timerIsShowing ? "Hide timer" : "Show timer") {
                timerIsShowing = !timerIsShowing
            }
        }
    }
}
