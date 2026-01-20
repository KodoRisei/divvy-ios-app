import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                Text(product.label)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("¥\(Int(product.price))")
                .font(.body)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}
