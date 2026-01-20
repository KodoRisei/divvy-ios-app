import SwiftUI

struct PurchaseGroupDetailView: View {
    let group: PurchaseGroup
    @ObservedObject var viewModel: ItemListViewModel
    @State private var showingAddProduct = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 商品リスト
            List {
                ForEach(group.products) { product in
                    ProductRow(product: product)
                }
                .onDelete { offsets in
                    viewModel.deleteProduct(at: offsets, from: group.id)
                }
            }
            
            // このグループのラベル別合計
            if !group.products.isEmpty {
                LabelTotalView(
                    labelTotals: viewModel.labelTotals(for: group.id),
                    totalAmount: group.totalAmount,
                    title: "このレシートの合計"
                )
            }
        }
        .navigationTitle(group.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddProduct = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddProduct) {
            AddProductView(groupId: group.id, viewModel: viewModel)
        }
    }
}
