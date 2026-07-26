import Foundation
import AVFoundation

enum RelaxingSound: String, CaseIterable, Identifiable {
    case whiteNoise = "Ruido Branco"
    case rain = "Chuva"
    case ocean = "Ondas do Mar"

    var id: String { rawValue }
}

/// Gera sons relaxantes de forma sintetica (ruido branco, chuva, ondas),
/// sem depender de arquivos de audio externos.
final class RelaxingSoundsEngine: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var selectedSound: RelaxingSound = .whiteNoise
    @Published var volume: Float = 0.5 {
        didSet { playerNode.volume = volume }
    }

    private let engine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    private var sourceNode: AVAudioSourceNode?

    func play() {
        stopInternal()

        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
        try? session.setActive(true)

        let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)!
        var lastOutput: Float = 0
        let sound = selectedSound

        let node = AVAudioSourceNode { [weak self] _, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            let volume = self?.volume ?? 0.5

            for frame in 0..<Int(frameCount) {
                let white = Float.random(in: -1...1)
                var sample: Float

                switch sound {
                case .whiteNoise:
                    sample = white * 0.3
                case .rain:
                    // Ruido rosa aproximado: filtro passa-baixa simples, mais suave que o branco.
                    lastOutput = (lastOutput + (0.02 * white)) / 1.02
                    sample = lastOutput * 3.0
                case .ocean:
                    // Modulacao lenta em amplitude para simular ondas.
                    let t = Float(frame) / 44100.0
                    let wave = (sin(2 * Float.pi * 0.15 * t) + 1) / 2
                    lastOutput = (lastOutput + (0.02 * white)) / 1.02
                    sample = lastOutput * 3.0 * (0.4 + 0.6 * wave)
                }

                for buffer in ablPointer {
                    let bufferPointer = UnsafeMutableBufferPointer<Float>(buffer)
                    bufferPointer[frame] = sample * volume
                }
            }
            return noErr
        }

        engine.attach(node)
        engine.connect(node, to: engine.mainMixerNode, format: format)
        sourceNode = node

        engine.prepare()
        try? engine.start()
        isPlaying = true
    }

    func stop() {
        stopInternal()
        isPlaying = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    private func stopInternal() {
        if let sourceNode {
            engine.disconnectNodeInput(sourceNode)
            engine.detach(sourceNode)
        }
        sourceNode = nil
        if engine.isRunning {
            engine.stop()
        }
    }
}
