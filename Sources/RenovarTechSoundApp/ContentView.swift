import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            KaraokeView()
                .tabItem {
                    Label("Karaoke", systemImage: "mic.fill")
                }

            PlaceholderView(title: "Ferramentas de Audio")
                .tabItem {
                    Label("Audio", systemImage: "waveform")
                }

            PlaceholderView(title: "Sons Relaxantes")
                .tabItem {
                    Label("Relaxar", systemImage: "leaf.fill")
                }

            PlaceholderView(title: "Assinatura")
                .tabItem {
                    Label("Assinatura", systemImage: "star.fill")
                }

            PlaceholderView(title: "Mais")
                .tabItem {
                    Label("Mais", systemImage: "ellipsis")
                }
        }
        .tint(.renovarTeal)
    }
}

struct PlaceholderView: View {
    let title: String

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.renovarTeal)
            Text("Em construcao nesta versao do app para iPhone.")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.renovarBackground.ignoresSafeArea())
    }
}
