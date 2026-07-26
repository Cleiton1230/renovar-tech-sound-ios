import SwiftUI

/// Calculadora de tempo seguro de exposicao sonora, baseada na regra de
/// troca de 3 dB do NIOSH (a cada +3 dB, o tempo seguro de exposicao cai
/// pela metade, partindo de 8 horas em 85 dB).
struct CalculatorView: View {
    @State private var decibels: Double = 85

    private var safeExposureHours: Double {
        8.0 / pow(2.0, (decibels - 85.0) / 3.0)
    }

    private var formattedTime: String {
        let hours = safeExposureHours
        if hours >= 1 {
            return String(format: "%.1f horas", hours)
        }
        let minutes = hours * 60
        if minutes >= 1 {
            return String(format: "%.0f minutos", minutes)
        }
        return String(format: "%.0f segundos", minutes * 60)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Calculadora de Exposicao Sonora")
                    .font(.headline)
                    .foregroundColor(.renovarTeal)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("\(Int(decibels)) dB")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.renovarOrange)

                Slider(value: $decibels, in: 70...120, step: 1)
                    .tint(.renovarTeal)
                    .padding(.horizontal)

                VStack(spacing: 6) {
                    Text("Tempo seguro de exposicao diaria")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(formattedTime)
                        .font(.title)
                        .bold()
                        .foregroundColor(.renovarTeal)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)

                Text("Baseado na regra de troca de 3 dB (NIOSH): a cada aumento de 3 dB, o tempo seguro de exposicao cai pela metade. Use o medidor de decibeis na aba Ferramentas de Audio para medir o ambiente.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 24)
            .background(Color.renovarBackground.ignoresSafeArea())
            .navigationTitle("Calculadora")
        }
        .navigationViewStyle(.stack)
    }
}
