import Foundation

class StreakManager: ObservableObject {
    @Published var currentStreak: Int = 0
    @Published var bestStreak: Int = 0
    private let lastPlayedKey = "LastPlayedDate"
    private let currentStreakKey = "CurrentStreak"
    private let bestStreakKey = "BestStreak"
    
    init() {
        loadStreaks()
    }
    
    func checkAndUpdateStreak() {
        let defaults = UserDefaults.standard
        let calendar = Calendar.current
        
        if let lastPlayed = defaults.object(forKey: lastPlayedKey) as? Date {
            let daysSinceLastPlayed = calendar.dateComponents([.day], from: lastPlayed, to: Date()).day ?? 0
            
            if daysSinceLastPlayed == 1 {
                // Consecutive day
                currentStreak += 1
                bestStreak = max(currentStreak, bestStreak)
            } else if daysSinceLastPlayed > 1 {
                // Streak broken
                currentStreak = 1
            }
        } else {
            // First time playing
            currentStreak = 1
        }
        
        defaults.set(Date(), forKey: lastPlayedKey)
        defaults.set(currentStreak, forKey: currentStreakKey)
        defaults.set(bestStreak, forKey: bestStreakKey)
    }
    
    private func loadStreaks() {
        let defaults = UserDefaults.standard
        currentStreak = defaults.integer(forKey: currentStreakKey)
        bestStreak = defaults.integer(forKey: bestStreakKey)
    }
} 