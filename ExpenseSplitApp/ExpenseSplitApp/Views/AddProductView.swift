import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) var dismiss
    let groupId: UUID
    @ObservedObject var viewModel: ItemListViewModel
    
    @State private var productName = ""
    @State private var productPrice = ""
    @State private var selectedLabel = ""
    @State private var newLabel = ""
    @State private var showingNewLabelField = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("商品情報")) {
                    TextField("商品名", text: $productName)
                    TextField("金額", text: $productPrice)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("購入者")) {
                    Picker("ラベルを選択", selection: $selectedLabel) {
                        Text("選択してください").tag("")
                        ForEach(Array(viewModel.availableLabels).sorted(), id: \.self) { label in
                            Text(label).tag(label)
                        }
                    }
                    
                    Button(action: {
                        showingNewLabelField.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("新しいラベルを追加")
                        }
                    }
                    
                    if showingNewLabelField {
                        HStack {
                            TextField("新しいラベル名", text: $newLabel)
                            Button("追加") {
                                viewModel.addLabel(newLabel)
                                selectedLabel = newLabel
                                newLabel = ""
                                showingNewLabelField = false
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(newLabel.isEmpty)
                        }
                    }
                }
            }
            .navigationTitle("商品を追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("追加") {
                        addProduct()
                    }
                    .disabled(!isValidInput)
                }
            }
        }
    }
    
    private var isValidInput: Bool {
        !productName.isEmpty &&
        Double(productPrice) != nil &&
        !selectedLabel.isEmpty
    }
    
    private func addProduct() {
        guard let price = Double(productPrice) else { return }
        let newProduct = Product(name: productName, price: price, label: selectedLabel)
        viewModel.addProduct(newProduct, to: groupId)
        dismiss()
    }
}
