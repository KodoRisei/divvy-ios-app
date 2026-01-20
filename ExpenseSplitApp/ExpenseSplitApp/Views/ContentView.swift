import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ItemListViewModel()
    @State private var showingAddGroup = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 項目グループリスト
                List {
                    ForEach(viewModel.purchaseGroups) { group in
                        NavigationLink(destination: PurchaseGroupDetailView(group: group, viewModel: viewModel)) {
                            PurchaseGroupRow(group: group)
                        }
                    }
                    .onDelete(perform: viewModel.deletePurchaseGroup)
                }
                
                // 全体のラベル別合計表示
                if !viewModel.purchaseGroups.isEmpty {
                    LabelTotalView(
                        labelTotals: viewModel.labelTotals,
                        totalAmount: viewModel.totalAmount,
                        title: "全体の合計"
                    )
                }
            }
            .navigationTitle("支払い分割")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddGroup = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddGroup) {
                AddPurchaseGroupView(viewModel: viewModel)
            }
        }
    }
}
