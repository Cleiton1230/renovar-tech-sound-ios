#!/bin/bash
set -e

echo "=== Renovar Tech Sound App (iOS) - Setup ==="
echo ""

if ! command -v brew &> /dev/null; then
  echo "Homebrew nao encontrado."
  echo "Instale primeiro em https://brew.sh e depois rode este script de novo."
  exit 1
fi

if ! command -v xcodegen &> /dev/null; then
  echo "Instalando XcodeGen (via Homebrew)..."
  brew install xcodegen
fi

echo "Gerando o projeto Xcode a partir do project.yml..."
xcodegen generate

echo "Abrindo o projeto no Xcode..."
open RenovarTechSoundApp.xcodeproj

echo ""
echo "Pronto! Quando o Xcode abrir:"
echo "1. Clique no icone azul do projeto (painel esquerdo) -> aba 'Signing & Capabilities' -> escolha seu Team (seu Apple ID)."
echo "2. Escolha um simulador de iPhone no menu do topo e clique no botao Play."
