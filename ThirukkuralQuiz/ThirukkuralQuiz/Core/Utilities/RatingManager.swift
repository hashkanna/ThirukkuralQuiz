import StoreKit
import SwiftUI

class RatingManager: ObservableObject {
    static let shared = RatingManager()
    private let defaults = UserDefaults.standard
    
    private let completedQuizzesKey = "completedQuizzes"
    private let lastRatingPromptKey = "lastRatingPrompt"
    
    func incrementQuizCount() {
        let count = defaults.integer(forKey: completedQuizzesKey) + 1
        defaults.set(count, forKey: completedQuizzesKey)
        
        checkAndRequestRating()
    }
    
    private func checkAndRequestRating() {
        let completedQuizzes = defaults.integer(forKey: completedQuizzesKey)
        let lastPrompt = defaults.object(forKey: lastRatingPromptKey) as? Date ?? Date.distantPast
        
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        
        if completedQuizzes >= 5 && lastPrompt < weekAgo {
            requestRating()
        }
    }
    
    private func requestRating() {
        Task {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                await AppStore.requestReview(in: scene)
                defaults.set(Date(), forKey: lastRatingPromptKey)
                defaults.set(0, forKey: completedQuizzesKey)
            }
        }
    }
} 