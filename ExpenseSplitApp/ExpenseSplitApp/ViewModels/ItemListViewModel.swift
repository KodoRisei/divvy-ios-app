import Foundation
import Combine
import SwiftUI

class ItemListViewModel: ObservableObject {
    @Published var purchaseGroups: [PurchaseGroup] = []
    @Published var availableLabels: Set<String> = ["太郎", "花子", "次郎"]
    
    // 全体のラベル別合計
    var labelTotals: [(label: String, total: Double)] {
        var totals: [String: Double] = [:]
        
        for group in purchaseGroups {
            for product in group.products {
                totals[product.label, default: 0] += product.price
            }
        }
        
        return totals.map { (label: $0.key, total: $0.value) }
            .sorted { $0.label < $1.label }
    }
    
    var totalAmount: Double {
        purchaseGroups.reduce(0) { $0 + $1.totalAmount }
    }
    
    func addPurchaseGroup(_ group: PurchaseGroup) {
        purchaseGroups.append(group)
    }
    
    func deletePurchaseGroup(at offsets: IndexSet) {
        purchaseGroups.remove(atOffsets: offsets)
    }
    
    func addProduct(_ product: Product, to groupId: UUID) {
        if let index = purchaseGroups.firstIndex(where: { $0.id == groupId }) {
            purchaseGroups[index].products.append(product)
        }
    }
    
    func deleteProduct(at offsets: IndexSet, from groupId: UUID) {
        if let index = purchaseGroups.firstIndex(where: { $0.id == groupId }) {
            purchaseGroups[index].products.remove(atOffsets: offsets)
        }
    }
    
    func addLabel(_ label: String) {
        guard !label.isEmpty else { return }
        availableLabels.insert(label)
    }
    
    // 特定グループのラベル別合計
    func labelTotals(for groupId: UUID) -> [(label: String, total: Double)] {
        guard let group = purchaseGroups.first(where: { $0.id == groupId }) else {
            return []
        }
        
        let grouped = Dictionary(grouping: group.products, by: { $0.label })
        return grouped.map { (label: $0.key, total: $0.value.reduce(0) { $0 + $1.price }) }
            .sorted { $0.label < $1.label }
    }
}
