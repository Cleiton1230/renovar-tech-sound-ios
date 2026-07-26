import SwiftUI
import AVFoundation

/// Mostra os dispositivos de audio atualmente conectados (fones Bluetooth,
/// alto-falante do iPhone, etc.) usando a rota de audio real do sistema.
struct MyDevicesView: View {
    @State private var outputs: [String] = []
    @State private var inputs: [String] = []

    var body: some View {
        NavigationView {
            List {
                Section("Saida de audio (fones / alto-falantes)") {
                    if outputs.isEmpty {
                        Text("Nenhum dispositivo encontrado").foregroundColor(.secondary)
                    } else {
                        ForEach(outputs, id: \.self) { name in
                            Label(name, systemImage: "headphones")
                        }
                    }
                }

                Section("Entrada de audio (microfones)") {
                    if inputs.isEmpty {
                        Text("Nenhum dispositivo encontrado").foregroundColor(.secondary)
                    } else {
                        ForEach(inputs, id: \.self) { name in
                            Label(name, systemImage: "mic")
                        }
                    }
                }
            }
            .navigationTitle("Meus Dispositivos")
            .onAppear(perform: refresh)
            .refreshable { refresh() }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Atualizar", action: refresh)
                }
            }
        }
        .navigationViewStyle(.stack)
    }

    private func refresh() {
        let session = AVAudioSession.sharedInstance()
        let route = session.currentRoute
        outputs = route.outputs.map { $0.portName }
        inputs = route.inputs.map { $0.portName }
        if inputs.isEmpty, let builtIn = session.availableInputs {
            inputs = builtIn.map { $0.portName }
        }
    }
}
