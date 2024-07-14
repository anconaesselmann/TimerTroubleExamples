import UIKit
import Combine

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ContentViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

final class ContentViewController: UIViewController {

    private lazy var timerToggle: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(timerTogglePressed), for: .touchUpInside)
        return button
    }()

    private var timerViewController: TimerViewController?

    private var timerIsShowing = true

    @objc
    private func timerTogglePressed(_ sender: UIButton) {
        timerIsShowing = !timerIsShowing
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        timerToggle.align(to: view.safeAreaLayoutGuide.topAnchor, in: view)
        updateView()
    }

    private func updateView() {
        timerToggle.setTitle(timerIsShowing ? "Hide timer" : "Show timer", for: .normal)
        if timerIsShowing {
            let timerVC = TimerViewController()
            timerViewController = timerVC
            addChild(timerVC)
            timerVC.view.align(to: timerToggle.bottomAnchor, in: view)
            timerVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            timerVC.view.fillHorizontally(in: view)
        } else {
            timerViewController?.view.removeFromSuperview()
            timerViewController?.removeFromParent()
            timerViewController = nil
        }
    }
}

final class TimerViewModel: ObservableObject {

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

final class TimerViewController: UIViewController {

    private let vm = TimerViewModel()

    private var subscription: AnyCancellable?

    private lazy var timerToggle: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(timerTogglePressed), for: .touchUpInside)
        return button
    }()

    private lazy var timerDisplay: UILabel = UILabel()

    @objc
    private func timerTogglePressed(_ sender: UIButton) {
        if vm.isInactive {
            vm.startTimer()
        } else {
            vm.stopTimer()
        }
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        timerToggle.align(to: view.safeAreaLayoutGuide.topAnchor, in: view)
        timerDisplay.align(to: timerToggle.bottomAnchor, in: view)

        subscription = vm.objectWillChange.sink { [weak self] in
            self?.updateView()
        }

        updateView()
    }

    private func updateView() {
        timerToggle.setTitle(vm.isInactive ? "start" : "stop", for: .normal)
        timerDisplay.text = String(vm.elapsed)
    }
}

extension UIView {
    func align(to anchor: NSLayoutYAxisAnchor, in view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchor, constant: 16).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func fillHorizontally(in view: UIView) {
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
