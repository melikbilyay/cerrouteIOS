import SwiftUI

extension Color {
    static let brandPrimary = Color(hex: "#F1A183")
    static let brandSecondary = Color(hex: "#ED884C")
    static let brandAccent = Color(hex: "#E64F25")
    static let brandDark = Color(hex: "#BD2630") // Düzeltilen renk kodu
    static let brandDarker = Color(hex: "#991B27")
    static let brandText = Color.white
}

extension Color {
    init(hex: String) {
        // Hex string temizleme (gereksiz # işareti varsa)
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        // Hexadecimal değeri UInt64'e çevirme
        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)
        
        // RGB bileşenlerine ayırma
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        // Renk nesnesini oluşturma
        self.init(red: red, green: green, blue: blue)
    }
}
