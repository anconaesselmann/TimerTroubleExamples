## Scheduled Timer — Defusing a time bomb

### Modernizing Swift’s Timer API

This is the companion code for the article [Scheduled Timer - Defusing a time bomb](https://medium.com/@DudeOnSwift/scheduled-timer-defusing-a-time-bomb-85f854714b5c)

- [This implementation](https://github.com/anconaesselmann/TimerTroubleExamples/tree/main/TimerTrouble_SwiftUI) of a simple timer leaks memory ([UIKit version](https://github.com/anconaesselmann/TimerTroubleExamples/tree/main/TimerTrouble_UIKit))
- [This implementation](https://github.com/anconaesselmann/TimerTroubleExamples/tree/main/TimerTrouble_SwiftUI_solved) uses a cancellable type to avoid memory leaks
