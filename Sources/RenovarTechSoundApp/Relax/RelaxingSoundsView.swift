import SwiftUI

struct RelaxingSoundsView: View {
    @StateObject private var engine = RelaxingSoundsEngine()

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Escolha um som para relaxar")
                    .font(.headline)
                    .foregroundColor(.renovarTeal)

                Picker("Som", selection: $engine.selectedSound) {
                    ForEach(RelaxingSound.allCases) { sound in
                        Text(sound.rawValue).tag(sound)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: engine.selectedSound) { _ in
                    if engine.isPlaying {
                        engine.play()
                    }
                }

                VStack {
                    Text("Volume")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Slider(value: $engine.volume, in: 0...1)
                        .tint(.renovarOrange)
                }
                .padding(.horizontal)

                Button(engine.isPlaying ? "Parar" : "Tocar") {
                    engine.isPlaying ? engine.stop() : engine.play()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(engine.isPlaying ? Color.renovarOrange : Color.renovarTeal)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.renovarBackground.ignoresSafeArea())
            .navigationTitle("Sons Relaxantes")
        }
        .navigationViewStyle(.stack)
    }
}
