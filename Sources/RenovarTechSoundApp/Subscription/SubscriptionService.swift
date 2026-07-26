import Foundation

enum SubscriptionServiceError: Error {
    case invalidResponse
    case noCheckoutURL
}

/// Chama a mesma Edge Function do Supabase ("create-payment") ja usada pelo
/// web app e pelo app Android para criar uma cobranca no Mercado Pago e
/// devolve a URL de checkout para o usuario finalizar o pagamento com
/// seguranca dentro do proprio app do Mercado Pago / navegador.
enum SubscriptionService {
    static func createCheckoutURL(plan: String) async throws -> URL {
        var request = URLRequest(url: SupabaseConfig.functionURL("create-payment"))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(SupabaseConfig.anonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(SupabaseConfig.anonKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONSerialization.data(withJSONObject: ["plan": plan])

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw SubscriptionServiceError.invalidResponse
        }

        guard
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            throw SubscriptionServiceError.invalidResponse
        }

        let candidateKeys = ["init_point", "checkoutUrl", "checkout_url", "url"]
        for key in candidateKeys {
            if let urlString = json[key] as? String, let url = URL(string: urlString) {
                return url
            }
        }

        throw SubscriptionServiceError.noCheckoutURL
    }
}
