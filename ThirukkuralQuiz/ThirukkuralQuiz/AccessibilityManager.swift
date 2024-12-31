import SwiftUI

struct AccessibilityManager {
    static func configureQuestionView(_ view: some View, question: Question) -> some View {
        return view
            .accessibilityLabel("குறள் கேள்வி")
            .accessibilityValue("\(question.kural.Line1)\n\(question.kural.Line2)")
            .accessibilityHint("விடுபட்ட வார்த்தையைத் தேர்ந்தெடுக்கவும்")
    }
    
    static func configureAnswerButton(_ view: some View, option: String, isSelected: Bool, isCorrect: Bool?) -> some View {
        return view
            .accessibilityLabel("விடை தேர்வு")
            .accessibilityValue(option)
            .accessibilityHint(isSelected ? (isCorrect ?? false ? "சரியான விடை" : "தவறான விடை") : "தேர்வு செய்ய தட்டவும்")
    }
} 