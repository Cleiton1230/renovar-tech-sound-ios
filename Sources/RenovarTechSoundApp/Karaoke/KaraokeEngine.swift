import Foundation
import AVFoundation

/// Motor de audio do Karaoke.
///
/// Diferente da primeira tentativa (web app), aqui usamos a categoria
/// .playAndRecord com a opcao .mixWithOthers para que a musica tocando em
/// outro app (Spotify, YouTube, Musica, etc.) NAO seja pausada quando o
/// microfone ao vivo for ativado - ela apenas pode ser "duckada" (abaixada)
/// pelo proprio sistema, nunca pausada.
final class KaraokeEngine: ObservableObject {
    @Published var isActive: Bool = false
    @Published var errorMessage: String?

    private let audioEngine = AVAudioEngine()

    func start() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(
                .playAndRecord,
                mode: .default,
                options: [.mixWithOthers, .defaultToSpeaker, .allowBluetooth, .allowBluetoothA2DP]
            )
            try session.setActive(true, options: .notifyOthersOnDeactivation)

            let input = audioEngine.inputNode
            let format = input.inputFormat(forBus: 0)
            let mainMixer = audioEngine.mainMixerNode
            audioEngine.connect(input, to: mainMixer, format: format)
            mainMixer.outputVolume = 1.0

            audioEngine.prepare()
            try audioEngine.start()

            isActive = true
            errorMessage = nil
        } catch {
            errorMessage = "Nao foi possivel ativar o microfone: \(error.localizedDescription)"
            isActive = false
        }
    }

    func stop() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        let session = AVAudioSession.sharedInstance()
        try? session.setActive(false, options: .notifyOthersOnDeactivation)
        isActive = false
    }
}
