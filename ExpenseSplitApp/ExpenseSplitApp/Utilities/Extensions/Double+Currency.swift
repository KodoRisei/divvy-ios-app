import Foundation

extension Double {
    func toCurrencyString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "JPY"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: NSNumber(value: self)) ?? "¥0"
    }
}
