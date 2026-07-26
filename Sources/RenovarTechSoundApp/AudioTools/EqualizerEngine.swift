import Foundation
import AVFoundation

/// Mixer/equalizador ao vivo: capta o microfone, aplica um equalizador de
/// 5 bandas e envia para a saida (fone/alto-falante), permitindo ajustar o
/// som ambiente em tempo real (graves, medios e agudos).
final class EqualizerEngine: ObservableObject {
    @Published var isActive: Bool = false
    @Published var errorMessage: String?
    @Published var bandGains: [Float] = [0, 0, 0, 0, 0] {
        didSet { applyGains() }
    }

    let bandFrequencies: [Float] = [60, 250, 1000, 4000, 12000]

    private let engine = AVAudioEngine()
    private let eq = AVAudioUnitEQ(numberOfBands: 5)

    init() {
        for (index, frequency) in bandFrequencies.enumerated() {
            let band = eq.bands[index]
            band.filterType = .parametric
            band.frequency = frequency
            band.bandwidth = 1.0
            band.gain = 0
            band.bypass = false
        }
    }

    func start() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(
                .playAndRecord,
                mode: .default,
                options: [.mixWithOthers, .defaultToSpeaker, .allowBluetooth, .allowBluetoothA2DP]
            )
            try session.setActive(true, options: .notifyOthersOnDeactivation)

            let input = engine.inputNode
            let format = input.inputFormat(forBus: 0)

            engine.attach(eq)
            engine.connect(input, to: eq, format: format)
            engine.connect(eq, to: engine.mainMixerNode, format: format)

            engine.prepare()
            try engine.start()

            isActive = true
            errorMessage = nil
        } catch {
            errorMessage = "Nao foi possivel iniciar o equalizador: \(error.localizedDescription)"
            isActive = false
        }
    }

    func stop() {
        engine.stop()
        engine.inputNode.removeTap(onBus: 0)
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        isActive = false
    }

    private func applyGains() {
        for (index, gain) in bandGains.enumerated() where index < eq.bands.count {
            eq.bands[index].gain = gain
        }
    }
}
