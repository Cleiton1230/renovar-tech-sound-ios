import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AudioToolsView()
                .tabItem {
                    Label("Audio", systemImage: "waveform")
                }

            RelaxingSoundsView()
                .tabItem {
                    Label("Relaxar", systemImage: "leaf.fill")
                }

            KaraokeView()
                .tabItem {
                    Label("Karaoke", systemImage: "mic.fill")
                }

            SyncView()
                .tabItem {
                    Label("Sincronizar", systemImage: "arrow.triangle.2.circlepath")
                }

            HearingTestView()
                .tabItem {
                    Label("Teste Auditivo", systemImage: "ear")
                }

            StoreAssistanceView()
                .tabItem {
                    Label("Loja", systemImage: "cart.fill")
                }

            SubscriptionView()
                .tabItem {
                    Label("Assinatura", systemImage: "star.fill")
                }

            LegalView()
                .tabItem {
                    Label("Legal", systemImage: "doc.text")
                }

            MyDevicesView()
                .tabItem {
                    Label("Dispositivos", systemImage: "headphones")
                }

            CalculatorView()
                .tabItem {
                    Label("Calculadora", systemImage: "function")
                }
        }
        .tint(.renovarTeal)
    }
}
