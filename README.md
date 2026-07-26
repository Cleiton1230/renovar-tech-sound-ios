# Renovar Tech Sound App - iOS

App nativo em SwiftUI para iPhone do Renovar Tech Sound App, reaproveitando o mesmo backend (Supabase) do app Android e do app web.

## Antes de rodar (1 passo manual obrigatorio)

Abra o arquivo `Sources/RenovarTechSoundApp/Core/SupabaseConfig.swift` e troque o texto
`"COLE_AQUI_SUA_ANON_KEY_DO_SUPABASE"` pela sua chave "anon / public" do Supabase.

Onde encontrar a chave: painel do Supabase -> Project Settings -> API -> "Project API keys" -> chave marcada "anon" / "public".

## Como rodar no seu Mac (o mais facil possivel)

Abra o Terminal e cole este bloco inteiro de uma vez:

```bash
git clone https://github.com/Cleiton1230/renovar-tech-sound-ios.git
cd renovar-tech-sound-ios
chmod +x setup.sh
./setup.sh
```

O script `setup.sh` cuida de tudo sozinho:
- instala o XcodeGen (se precisar, via Homebrew)
- gera o projeto Xcode a partir do `project.yml`
- abre o projeto automaticamente no Xcode

Pre-requisitos que so voce pode instalar (uma vez so, no seu Mac):
1. Xcode (App Store, gratuito)
2. Homebrew (brew.sh) - se ainda nao tiver

## Depois que o Xcode abrir

1. Clique no icone azul do projeto (painel esquerdo) -> aba "Signing & Capabilities" -> escolha seu Team (seu Apple ID gratuito serve para testar).
2. Escolha um simulador de iPhone no menu do topo e clique em Play (▶).
3. Para testar no seu iPhone fisico: conecte por cabo, selecione o aparelho na lista, e de Play (pode pedir para confiar no desenvolvedor em Ajustes -> Geral -> VPN e Gerenciamento de Dispositivo).

## Publicar na App Store

Isso e feito por voce diretamente no Xcode / App Store Connect (certificados, ficha do app, aceite do contrato de desenvolvedor e dados de pagamento sao passos que voce mesma precisa concluir).
