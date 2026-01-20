import SwiftUI

struct AddPurchaseGroupView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ItemListViewModel
    
    @State private var groupName = ""
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("項目情報")) {
                    TextField("項目名（例：スーパー）", text: $groupName)
                    DatePicker("日付", selection: $selectedDate, displayedComponents: .date)
                }
            }
            .navigationTitle("項目を追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("追加") {
                        addGroup()
                    }
                    .disabled(groupName.isEmpty)
                }
            }
        }
    }
    
    private func addGroup() {
        let newGroup = PurchaseGroup(name: groupName, date: selectedDate)
        viewModel.addPurchaseGroup(newGroup)
        dismiss()
    }
}
