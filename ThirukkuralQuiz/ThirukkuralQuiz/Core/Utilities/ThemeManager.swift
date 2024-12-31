import SwiftUI

class ThemeManager: ObservableObject {
    @Published var colorScheme: ColorScheme = .light
    
    struct ThemeColors {
        static func background(for scheme: ColorScheme) -> LinearGradient {
            switch scheme {
            case .light:
                return LinearGradient(
                    colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            case .dark:
                return LinearGradient(
                    colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            @unknown default:
                return LinearGradient(
                    colors: [Color.purple, Color.blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
        
        static func cardBackground(for scheme: ColorScheme) -> Color {
            scheme == .light ? Color.blue.opacity(0.6) : Color.blue.opacity(0.3)
        }
    }
} 