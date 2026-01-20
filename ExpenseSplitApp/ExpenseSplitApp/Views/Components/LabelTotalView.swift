import SwiftUI

struct LabelTotalView: View {
    let labelTotals: [(label: String, total: Double)]
    let totalAmount: Double
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 4)
                
                ForEach(labelTotals, id: \.label) { item in
                    HStack {
                        Text(item.label)
                            .font(.body)
                        Spacer()
                        Text("¥\(Int(item.total))")
                            .font(.body)
                            .fontWeight(.bold)
                    }
                }
                
                Divider()
                    .padding(.vertical, 8)
                
                HStack {
                    Text("合計")
                        .font(.headline)
                    Spacer()
                    Text("¥\(Int(totalAmount))")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color(.systemGray6))
        }
    }
}
