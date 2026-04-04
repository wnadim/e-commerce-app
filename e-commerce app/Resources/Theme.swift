import SwiftUI

// MARK: - App Colors
extension Color {
    static let theme = AppTheme()
}

struct AppTheme {
    let primary = Color(hex: "#FF1275")
    let secondary = Color(hex: "#1A237E")
    let tertiary = Color(hex: "#0D1117")
    let neutral = Color(hex: "#080B1A")
    
    // Additional semantics based on the design system
    let background = Color(hex: "#080B1A")
    let surface = Color(hex: "#0D1117")
    
    // MARK: Semantic Text Colors
        let textPrimary = Color(hex: "#1A237E")   // Main titles
        let textSecondary = Color.gray            // Subtitles / metadata
        let textOnPrimary = Color.white           // Text on CTA buttons
        let textOnDark = Color.white              // Text on dark backgrounds
}

// Helper to use hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - App Typography
extension Font {
    static let theme = AppTypography()
}

struct AppTypography {
    // Requires adding "Manrope" font files to your project bundle and Info.plist
    
    var headline: Font {
        .custom("Manrope-Bold", size: 32)
    }
    
    var bodyText: Font {
        .custom("Manrope-Regular", size: 16)
    }
    
    var label: Font {
        .custom("Manrope-Medium", size: 14)
    }
    
    // System fallbacks while font is not yet added
    var fallbackHeadline: Font {
        .system(size: 32, weight: .bold, design: .default)
    }
    var fallbackBody: Font {
        .system(size: 16, weight: .regular, design: .default)
    }
    var fallbackLabel: Font {
        .system(size: 14, weight: .medium, design: .default)
    }
}

// MARK: - Component Styles

// Primary Button
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.theme.label)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(Color.theme.primary)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// Secondary Button
struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.theme.label)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(Color.theme.secondary)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// Outlined Button
struct OutlinedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.theme.label)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
