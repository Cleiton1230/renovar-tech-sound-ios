import SwiftUI

/// Fluxo alternativo de dois aparelhos: um celular toca a musica (num app
/// externo, como Spotify ou YouTube) e o outro usa o Karaoke com o
/// microfone ao vivo. Util quando os dois celulares estao proximos.
struct SyncView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Sincronizar dois aparelhos")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.renovarTeal)

                    stepView(
                        number: 1,
                        title: "Aparelho 1 - Musica",
                        description: "Abra o Spotify, YouTube ou outro app de musica neste primeiro aparelho e escolha a musica."
                    )

                    stepView(
                        number: 2,
                        title: "Aparelho 2 - Karaoke",
                        description: "No segundo aparelho, abra a aba Karaoke deste app e ative o microfone ao vivo."
                    )

                    stepView(
                        number: 3,
                        title: "Posicionamento",
                        description: "Deixe os dois aparelhos proximos, com o volume da musica moderado, para o microfone captar bem sua voz junto com a musica."
                    )

                    Text("Dica: se preferir tudo em um so aparelho, use a aba Karaoke - ela ja mantem a musica de apps externos tocando ao ativar o microfone.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
                .padding()
            }
            .background(Color.renovarBackground.ignoresSafeArea())
            .navigationTitle("Sincronizar")
        }
        .navigationViewStyle(.stack)
    }

    private func stepView(number: Int, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(number)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(Circle().fill(Color.renovarOrange))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.renovarTeal)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}
