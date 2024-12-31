import SwiftUI

struct AccessibilityHelper {
    static func configureQuestionView(_ view: some View, question: Question) -> some View {
        return view
            .accessibilityElement(children: .combine)
            .accessibilityLabel("குறள் கேள்வி")
            .accessibilityValue("\(question.kural.Line1), \(question.kural.Line2)")
            .accessibilityHint("விடுபட்ட வார்த்தையைத் தேர்ந்தெடுக்கவும்")
    }
    
    static func configureAnswerButton(_ view: some View, option: String, isSelected: Bool, isCorrect: Bool?) -> some View {
        let hint = if isSelected {
            isCorrect ?? false ? "சரியான விடை" : "தவறான விடை"
        } else {
            "தேர்வு செய்ய தட்டவும்"
        }
        
        return view
            .accessibilityElement(children: .combine)
            .accessibilityLabel("விடை தேர்வு")
            .accessibilityValue(option)
            .accessibilityHint(hint)
            .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
} 