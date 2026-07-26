import SwiftUI

struct AudioToolsView: View {
    @StateObject private var meter = DecibelMeterEngine()
    @StateObject private var equalizer = EqualizerEngine()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    decibelSection
                    equalizerSection
                }
                .padding()
            }
            .background(Color.renovarBackground.ignoresSafeArea())
            .navigationTitle("Ferramentas de Audio")
        }
        .navigationViewStyle(.stack)
    }

    private var decibelSection: some View {
        VStack(spacing: 12) {
            Text("Medidor de Decibeis")
                .font(.headline)
                .foregroundColor(.renovarTeal)

            Text("\(Int(meter.currentDecibels)) dB")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundColor(.renovarOrange)

            Button(meter.isRunning ? "Parar medicao" : "Iniciar medicao") {
                meter.isRunning ? meter.stop() : meter.start()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.renovarTeal)
            .foregroundColor(.white)
            .cornerRadius(12)

            if let message = meter.errorMessage {
                Text(message).foregroundColor(.red).font(.footnote)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }

    private var equalizerSection: some View {
        VStack(spacing: 12) {
            Text("Mixer / Equalizador ao vivo")
                .font(.headline)
                .foregroundColor(.renovarTeal)

            ForEach(0..<equalizer.bandFrequencies.count, id: \.self) { index in
                VStack {
                    Text(frequencyLabel(equalizer.bandFrequencies[index]))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Slider(
                        value: Binding(
                            get: { equalizer.bandGains[index] },
                            set: { equalizer.bandGains[index] = $0 }
                        ),
                        in: -12...12
                    )
                    .tint(.renovarOrange)
                }
            }

            Button(equalizer.isActive ? "Desativar mixer" : "Ativar mixer ao vivo") {
                equalizer.isActive ? equalizer.stop() : equalizer.start()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(equalizer.isActive ? Color.renovarOrange : Color.renovarTeal)
            .foregroundColor(.white)
            .cornerRadius(12)

            if let message = equalizer.errorMessage {
                Text(message).foregroundColor(.red).font(.footnote)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }

    private func frequencyLabel(_ frequency: Float) -> String {
        frequency >= 1000 ? String(format: "%.0f kHz", frequency / 1000) : String(format: "%.0f Hz", frequency)
    }
}
