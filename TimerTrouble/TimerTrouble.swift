import SwiftUI

@main
struct TimerTrouble: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

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

class TimerViewModel: ObservableObject {

    @Published
    private(set) var elapsed: Int = 0

    var isInactive: Bool {
        timer == nil
    }

    private var timer: Timer?

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] timer in
            self?.elapsed += 1
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        objectWillChange.send()
    }
}

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
