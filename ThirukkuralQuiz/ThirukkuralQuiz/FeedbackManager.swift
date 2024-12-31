import SwiftUI
import AVFoundation

class FeedbackManager {
    static let shared = FeedbackManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        prepareAudioPlayer()
    }
    
    private func prepareAudioPlayer() {
        // Temporarily disable sound until we add the file
        // We'll implement this later when we add the sound file
    }
    
    func playCorrectAnswerSound() {
        // Temporarily disabled
    }
    
    func triggerHaptic(for result: Bool) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(result ? .success : .error)
    }
} 