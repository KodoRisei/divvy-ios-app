import SwiftUI

struct PurchaseGroupRow: View {
    let group: PurchaseGroup
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(group.name)
                    .font(.headline)
                Text(group.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(group.products.count)個の商品")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("¥\(Int(group.totalAmount))")
                .font(.body)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}
