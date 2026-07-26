import SwiftUI
import AVFoundation

/// Gera tons puros em varias frequencias para um teste auditivo simples e
/// indicativo (nao substitui uma avaliacao audiologica profissional).
final class ToneGenerator: ObservableObject {
    @Published var isPlaying: Bool = false

    private let engine = AVAudioEngine()
    private var sourceNode: AVAudioSourceNode?
    private var currentFrequency: Float = 1000
    private var phase: Float = 0

    func play(frequency: Float) {
        stop()
        currentFrequency = frequency
        phase = 0

        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
        try? AVAudioSession.sharedInstance().setActive(true)

        let sampleRate: Float = 44100
        let format = AVAudioFormat(standardFormatWithSampleRate: Double(sampleRate), channels: 1)!

        let node = AVAudioSourceNode { [weak self] _, _, frameCount, audioBufferList -> OSStatus in
            guard let self else { return noErr }
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            let increment = 2 * Float.pi * self.currentFrequency / sampleRate

            for frame in 0..<Int(frameCount) {
                let sample = sin(self.phase) * 0.2
                self.phase += increment
                if self.phase > 2 * Float.pi { self.phase -= 2 * Float.pi }
                for buffer in ablPointer {
                    let bufferPointer = UnsafeMutableBufferPointer<Float>(buffer)
                    bufferPointer[frame] = sample
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
        if let sourceNode {
            engine.disconnectNodeInput(sourceNode)
            engine.detach(sourceNode)
        }
        sourceNode = nil
        if engine.isRunning {
            engine.stop()
        }
        isPlaying = false
    }
}

struct HearingTestView: View {
    @StateObject private var tone = ToneGenerator()
    @State private var results: [Int: Bool] = [:]

    private let frequencies: [Int] = [250, 500, 1000, 2000, 4000, 8000]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Teste Auditivo Simples")
                    .font(.headline)
                    .foregroundColor(.renovarTeal)

                Text("Use fones de ouvido em um ambiente silencioso. Toque cada frequencia e diga se voce consegue ouvi-la com clareza.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                List(frequencies, id: \.self) { frequency in
                    HStack {
                        Text("\(frequency) Hz")
                        Spacer()
                        Button("Tocar") {
                            tone.play(frequency: Float(frequency))
                        }
                        .buttonStyle(.bordered)
                        .tint(.renovarTeal)

                        Button("Ouvi") {
                            results[frequency] = true
                            tone.stop()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(results[frequency] == true ? .green : .gray)
                    }
                }
                .listStyle(.plain)

                Button("Parar som") {
                    tone.stop()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.renovarOrange)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.top, 16)
            .background(Color.renovarBackground.ignoresSafeArea())
            .navigationTitle("Teste Auditivo")
        }
        .navigationViewStyle(.stack)
    }
}
