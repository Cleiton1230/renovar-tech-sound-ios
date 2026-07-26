import SwiftUI

struct StoreAssistanceView: View {
    private let phoneDigits = "5531981026477"
    private let phoneDisplay = "(31) 98102-6477"
    private let siteURL = URL(string: "https://www.renovartech.com.br")!

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Assistencia & Loja")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.renovarTeal)

                    Text("Precisa de suporte, assistencia tecnica ou quer ver nossos produtos? Fale com a gente.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)

                    actionRow(icon: "phone.fill", title: "WhatsApp / Telefone", subtitle: phoneDisplay) {
                        if let url = URL(string: "https://wa.me/\(phoneDigits)") {
                            UIApplication.shared.open(url)
                        }
                    }

                    actionRow(icon: "cart.fill", title: "Loja online", subtitle: "renovartech.com.br") {
                        UIApplication.shared.open(siteURL)
                    }
                }
                .padding()
            }
            .background(Color.renovarBackground.ignoresSafeArea())
            .navigationTitle("Assistencia & Loja")
        }
        .navigationViewStyle(.stack)
    }

    private func actionRow(icon: String, title: String, subtitle: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Color.renovarTeal))

                VStack(alignment: .leading) {
                    Text(title).font(.headline).foregroundColor(.primary)
                    Text(subtitle).font(.subheadline).foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.secondary)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}
