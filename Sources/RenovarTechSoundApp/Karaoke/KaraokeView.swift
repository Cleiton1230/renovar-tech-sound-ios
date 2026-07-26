import SwiftUI
import AVFoundation

struct KaraokeView: View {
    @StateObject private var engine = KaraokeEngine()
    @State private var micPermissionDenied = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Karaoke")
                .font(.title)
                .bold()
                .foregroundColor(.renovarTeal)

            Text("Toque a musica no seu app favorito (Spotify, YouTube, Musica) e cante junto usando o microfone ao vivo. A musica no outro app continua tocando.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Button(action: toggleMic) {
                Text(engine.isActive ? "Desativar microfone" : "Ativar microfone ao vivo")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(engine.isActive ? Color.renovarOrange : Color.renovarTeal)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            if let message = engine.errorMessage {
                Text(message)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.horizontal)
            }

            if micPermissionDenied {
                Text("Permissao de microfone negada. Ative em Ajustes > Privacidade > Microfone.")
                    .foregroundColor(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.renovarBackground.ignoresSafeArea())
    }

    private func toggleMic() {
        if engine.isActive {
            engine.stop()
            return
        }
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            engine.start()
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        engine.start()
                    } else {
                        micPermissionDenied = true
                    }
                }
            }
        case .denied:
            micPermissionDenied = true
        @unknown default:
            break
        }
    }
}
