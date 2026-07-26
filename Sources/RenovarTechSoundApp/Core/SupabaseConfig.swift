import Foundation

/// Configuracao de acesso ao backend Supabase (o mesmo usado pelo web app e
/// pelo app Android). A anon key do Supabase e uma chave PUBLICA, feita para
/// ser embutida em apps cliente (protegida pelas regras de Row Level Security
/// no banco) - nao e um segredo como uma senha ou service_role key.
enum SupabaseConfig {
    static let projectURL = URL(string: "https://zznuhmskgruandrjjncq.supabase.co")!
    static let anonKey = "COLE_AQUI_SUA_ANON_KEY_DO_SUPABASE"

    static func functionURL(_ name: String) -> URL {
        projectURL.appendingPathComponent("functions/v1/\(name)")
    }
}
