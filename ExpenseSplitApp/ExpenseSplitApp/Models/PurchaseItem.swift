import Foundation

// 商品（個別の購入品）
struct Product: Identifiable, Codable {
    let id: UUID
    var name: String
    var price: Double
    var label: String  // 購入者
    
    init(id: UUID = UUID(), name: String, price: Double, label: String) {
        self.id = id
        self.name = name
        self.price = price
        self.label = label
    }
}

// 項目グループ（スーパー、コンビニなど）
struct PurchaseGroup: Identifiable, Codable {
    let id: UUID
    var name: String
    var date: Date
    var products: [Product]
    
    var totalAmount: Double {
        products.reduce(0) { $0 + $1.price }
    }
    
    init(id: UUID = UUID(), name: String, date: Date = Date(), products: [Product] = []) {
        self.id = id
        self.name = name
        self.date = date
        self.products = products
    }
}
