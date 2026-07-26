import SwiftUI

struct LegalView: View {
    private let siteURL = URL(string: "https://www.renovartech.com.br")!

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Legal")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.renovarTeal)

                    Text("Politica de Privacidade")
                        .font(.headline)
                    Text("Coletamos apenas os dados necessarios para o funcionamento do app (como permissao de microfone para o Karaoke e as ferramentas de audio). Nao compartilhamos seus dados com terceiros para fins de publicidade.")
                        .foregroundColor(.secondary)

                    Text("Termos de Uso")
                        .font(.headline)
                    Text("Ao usar o Renovar Tech Sound App, voce concorda em utiliza-lo de forma responsavel. As ferramentas de teste auditivo e medicao de decibeis sao indicativas e nao substituem avaliacao profissional.")
                        .foregroundColor(.secondary)

                    Text("Assinaturas")
                        .font(.headline)
                    Text("Os pagamentos de assinatura sao processados pelo Mercado Pago. Duvidas sobre cobranca podem ser tratadas pelo nosso canal de assistencia.")
                        .foregroundColor(.secondary)

                    Button("Ver politica completa no site") {
                        UIApplication.shared.open(siteURL)
                    }
                    .padding(.top, 8)
                    .foregroundColor(.renovarTeal)
                }
                .padding()
            }
            .background(Color.renovarBackground.ignoresSafeArea())
            .navigationTitle("Legal")
        }
        .navigationViewStyle(.stack)
    }
}
