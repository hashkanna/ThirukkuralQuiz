import SwiftUI

class DailyChallengeManager: ObservableObject {
    static let shared = DailyChallengeManager()
    @Published var dailyKural: Thirukkural?
    @Published var hasCompletedToday = false
    
    private let defaults = UserDefaults.standard
    private let lastCompletedKey = "lastCompletedDaily"
    private let scoreKey = "dailyChallengeScore"
    private let streakKey = "dailyChallengeStreak"
    
    @Published var currentStreak: Int {
        didSet {
            defaults.set(currentStreak, forKey: streakKey)
        }
    }
    
    init() {
        self.currentStreak = defaults.integer(forKey: streakKey)
        checkAndUpdateDaily()
    }
    
    func checkAndUpdateDaily() {
        let calendar = Calendar.current
        let lastCompleted = defaults.object(forKey: lastCompletedKey) as? Date ?? .distantPast
        
        if !calendar.isDate(lastCompleted, inSameDayAs: Date()) {
            // New day, new challenge
            hasCompletedToday = false
            generateDailyKural()
        } else {
            hasCompletedToday = true
        }
    }
    
    private func generateDailyKural() {
        // Use the current date to generate a consistent daily kural
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        
        let kuralIndex = (dayOfYear - 1) % ThirukkuralDatabase.shared.kurals.count
        dailyKural = ThirukkuralDatabase.shared.kurals[kuralIndex]
    }
    
    func completeDailyChallenge(score: Int) {
        defaults.set(Date(), forKey: lastCompletedKey)
        hasCompletedToday = true
        
        let lastCompleted = defaults.object(forKey: lastCompletedKey) as? Date ?? .distantPast
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        
        if calendar.isDate(lastCompleted, inSameDayAs: yesterday) {
            currentStreak += 1
        } else {
            currentStreak = 1
        }
    }
} 