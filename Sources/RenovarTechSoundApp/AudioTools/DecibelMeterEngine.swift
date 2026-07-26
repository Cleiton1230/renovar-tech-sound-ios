import Foundation
import AVFoundation

/// Mede o nivel de audio ambiente em decibeis (dB SPL aproximado) usando o
/// microfone do iPhone. Uso indicativo, nao substitui um decibelimetro
/// profissional calibrado.
final class DecibelMeterEngine: ObservableObject {
    @Published var currentDecibels: Double = 0
    @Published var isRunning: Bool = false
    @Published var errorMessage: String?

    private var recorder: AVAudioRecorder?
    private var timer: Timer?

    func start() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.record, mode: .measurement, options: [])
            try session.setActive(true)

            let url = URL(fileURLWithPath: "/dev/null")
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
            ]
            let newRecorder = try AVAudioRecorder(url: url, settings: settings)
            newRecorder.isMeteringEnabled = true
            newRecorder.record()
            recorder = newRecorder

            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
                self?.tick()
            }
            isRunning = true
            errorMessage = nil
        } catch {
            errorMessage = "Nao foi possivel acessar o microfone: \(error.localizedDescription)"
            isRunning = false
        }
    }

    private func tick() {
        guard let recorder else { return }
        recorder.updateMeters()
        // averagePower(forChannel:) vai de -160 (silencio) a 0 (maximo).
        // Convertendo para uma estimativa aproximada de dB SPL.
        let power: Float = recorder.averagePower(forChannel: 0)
        let estimatedSPL: Float = max(0, power + 100)
        currentDecibels = Double(estimatedSPL)
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        recorder?.stop()
        recorder = nil
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        isRunning = false
    }
}
