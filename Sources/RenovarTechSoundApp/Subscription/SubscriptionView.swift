import SwiftUI

struct SubscriptionView: View {
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Assinatura Renovar Tech Sound")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.renovarTeal)
                    .multilineTextAlignment(.center)

                Text("Desbloqueie todas as ferramentas de audio, sons relaxantes e recursos exclusivos assinando o plano mensal.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Button(action: startCheckout) {
                    if isLoading {
                        ProgressView().tint(.white)
                    } else {
                        Text("Assinar agora")
                            .bold()
                    }
                }
                .disabled(isLoading)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.renovarOrange)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)

                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Text("O pagamento e processado com seguranca pelo Mercado Pago. Voce sera direcionado para concluir a compra.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 32)
            .background(Color.renovarBackground.ignoresSafeArea())
            .navigationTitle("Assinatura")
        }
        .navigationViewStyle(.stack)
    }

    private func startCheckout() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let url = try await SubscriptionService.createCheckoutURL(plan: "mensal")
                await MainActor.run {
                    isLoading = false
                    UIApplication.shared.open(url)
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = "Nao foi possivel iniciar o pagamento agora. Tente novamente em instantes."
                }
            }
        }
    }
}
