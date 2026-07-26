# Renovar Tech Sound App - iOS

App nativo para iPhone do Renovar Tech Sound App, escrito em Swift/SwiftUI.

## Como abrir este projeto no seu Mac

Este repositorio nao guarda o arquivo .xcodeproj (ele e gerado automaticamente
a partir do `project.yml` usando o XcodeGen). Para abrir no Xcode:

1. Instale o Xcode pela App Store (caso ainda nao tenha).
2. Instale o Homebrew (https://brew.sh), se ainda nao tiver.
3. No Terminal, instale o XcodeGen:
   ```
   brew install xcodegen
   ```
4. Clone este repositorio e entre na pasta dele.
5. Rode:
   ```
   xcodegen generate
   ```
6. Abra o arquivo `RenovarTechSoundApp.xcodeproj` que foi criado.
7. No Xcode, va em "Signing & Capabilities" e selecione o seu Time (Apple ID /
   Apple Developer Program) para poder rodar no seu iPhone ou publicar na
   App Store.

## Integracao continua (CI)

A cada push na branch main, o GitHub Actions compila o app automaticamente
em um runner macOS (sem assinatura, apenas para validar que o codigo
compila). Veja a aba "Actions" do repositorio.

## Publicacao na App Store

A publicacao (certificados, App Store Connect, aceite do Apple Developer
Agreement, dados de pagamento) deve ser feita diretamente por voce, pelo
Xcode ou Transporter, usando sua conta de desenvolvedor Apple.
