import Foundation

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int
    @Published var isActive = false
    private var timer: Timer?
    
    init(seconds: Int = 60) {
        self.timeRemaining = seconds
    }
    
    func start() {
        isActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stop()
            }
        }
    }
    
    func stop() {
        isActive = false
        timer?.invalidate()
        timer = nil
    }
    
    func reset(to seconds: Int = 60) {
        stop()
        timeRemaining = seconds
    }
} 