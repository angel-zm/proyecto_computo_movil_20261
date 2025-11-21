//
//  IaView.swift
//  computo_movil_pf
//
//  Created by Angel on 20/10/25.
//  Modificado: Vista para cargar y previsualizar un video (< 60s) y simular análisis de técnica.
//

import SwiftUI
import Combine
import PhotosUI
import AVFoundation
import AVKit

// Modelo de un mensaje en el chat (conservado por compatibilidad aunque ya no se use en UI principal)
struct ChatMessage: Identifiable, Equatable {
    enum Role {
        case user
        case assistant
        case system
    }

    let id = UUID()
    let role: Role
    let content: String
    let timestamp: Date
}

@MainActor
final class IaViewModel: ObservableObject {
    // Estado para el nuevo flujo de video
    @Published var pickedItem: PhotosPickerItem?
    @Published var pickedVideoURL: URL?
    @Published var player: AVPlayer?
    @Published var isAnalyzing: Bool = false
    @Published var errorMessage: String?
    @Published var feedback: String?
    @Published var extraNotes: String = "" // instrucciones opcionales del usuario

    // Validación de duración
    private let maxDuration: Double = 60.0

    // Cargar el recurso del PhotosPicker y validar duración
    func loadPickedVideo() async {
        resetFeedback()
        errorMessage = nil
        player = nil
        pickedVideoURL = nil

        guard let pickedItem else { return }

        do {
            // Obtener archivo temporal como .mov/.mp4
            if let url = try await pickedItem.loadTransferable(type: URL.self) {
                // A veces PhotosPicker entrega un URL sandbox temporal; validar duración
                try await validateAndPrepare(url: url)
            } else if let data = try await pickedItem.loadTransferable(type: Data.self) {
                // Como fallback, escribir data a un archivo temporal
                let tmpURL = FileManager.default.temporaryDirectory
                    .appendingPathComponent(UUID().uuidString)
                    .appendingPathExtension("mov")
                try data.write(to: tmpURL)
                try await validateAndPrepare(url: tmpURL)
            } else {
                throw NSError(domain: "IaViewModel",
                              code: -10,
                              userInfo: [NSLocalizedDescriptionKey: "No se pudo leer el video seleccionado."])
            }
        } catch {
            errorMessage = (error as NSError).localizedDescription
        }
    }

    private func validateAndPrepare(url: URL) async throws {
        let asset = AVURLAsset(url: url)
        let durationSeconds = try await asset.load(.duration).seconds
        if durationSeconds > maxDuration {
            throw NSError(domain: "IaViewModel",
                          code: -11,
                          userInfo: [NSLocalizedDescriptionKey: "El video dura \(Int(durationSeconds))s. Debe ser menor a 60s."])
        }

        pickedVideoURL = url
        player = AVPlayer(url: url)
    }

    // Opción B: Siempre genera feedback didáctico inmediato, sin requerir video ni esperar.
    func analyzeVideo() async {
        errorMessage = nil
        feedback = nil
        isAnalyzing = true
        defer { isAnalyzing = false }

        let notas = extraNotes.trimmingCharacters(in: .whitespacesAndNewlines)
        let notasTexto = notas.isEmpty ? "" : "\n\nNotas del jugador: \(notas)"

        feedback = """
        Análisis técnico (didáctico):
        - Control y conducción: Coordina toques cortos y suaves; alterna mirar el balón y levantar la vista para leer el juego.
        - Cambio de ritmo: Practica una aceleración explosiva tras el primer amague para ganar separación.
        - Golpeo de balón: Inclina ligeramente el tronco hacia adelante y acompaña el golpe con el empeine para mayor precisión.
        - Apoyo y balance: Asegura el apoyo del pie no dominante apuntando hacia el objetivo para estabilizar la cadera.

        Drills sugeridos:
        1) Conducción en zigzag con conos (3 series de 5 repeticiones).
        2) Amague + sprint 10m (4 series, recupera caminando).
        3) Finalización al arco: 10 tiros con enfoque en postura y seguimiento.

        Resultado general: Buen potencial. Prioriza postura al rematar y lectura del espacio antes del toque decisivo.

        \(notasTexto)
        """
    }

    func resetFeedback() {
        feedback = nil
    }
}

struct IaView: View {
    @StateObject private var vm = IaViewModel()
    @FocusState private var isNotesFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    headerSection

                    pickerSection

                    previewSection

                    notesSection

                    analyzeButton

                    feedbackSection
                }
                .padding(16)
            }
        }
        .navigationTitle("Análisis de Jugada")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Cerrar") { isNotesFocused = false }
            }
        }
        .alert("Error", isPresented: .constant(vm.errorMessage != nil)) {
            Button("OK") { vm.errorMessage = nil }
        } message: {
            Text(vm.errorMessage ?? "")
        }
        .onChange(of: vm.pickedItem) { _, _ in
            Task { await vm.loadPickedVideo() }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Sube tus mejores jugadas")
                .font(.title2.bold())
            Text("Graba una jugada de fútbol y súbela para recibir retroalimentación técnica. Procura buena iluminación y mantener el encuadre del cuerpo completo.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var pickerSection: some View {
        HStack(spacing: 12) {
            PhotosPicker(selection: $vm.pickedItem, matching: .videos, preferredItemEncoding: .automatic) {
                Label("Seleccionar video", systemImage: "video.badge.plus")
                    .font(.headline)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(.blue.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }

            if vm.pickedVideoURL != nil {
                Button {
                    vm.pickedItem = nil
                    vm.pickedVideoURL = nil
                    vm.player = nil
                    vm.resetFeedback()
                } label: {
                    Label("Quitar", systemImage: "trash")
                        .foregroundStyle(.red)
                }
                .buttonStyle(.borderless)
            }

            Spacer()
        }
    }

    private var previewSection: some View {
        Group {
            if let player = vm.player {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Previsualización")
                        .font(.headline)
                    VideoPlayer(player: player)
                        .frame(height: 260)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        }
                }
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Previsualización")
                        .font(.headline)
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.gray.opacity(0.08))
                            .frame(height: 120)

                        VStack(spacing: 6) {
                            Image(systemName: "video")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundStyle(.secondary)
                            Text("Aún no has seleccionado un video")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }

    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Notas opcionales")
                .font(.headline)
            TextField("Cuéntanos contexto: posición, pie dominante, qué quisiste practicar…", text: $vm.extraNotes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .focused($isNotesFocused)
                .lineLimit(2...4)
        }
    }

    private var analyzeButton: some View {
        Button {
            Task { await vm.analyzeVideo() }
        } label: {
            HStack {
                if vm.isAnalyzing {
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: "sparkles")
                }
                Text(vm.isAnalyzing ? "Analizando…" : "Analizar técnica")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(vm.isAnalyzing ? Color.blue.opacity(0.6) : Color.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        // Opción B: no deshabilitar por falta de video
        .disabled(vm.isAnalyzing)
        .padding(.top, 4)
    }

    private var feedbackSection: some View {
        Group {
            if let feedback = vm.feedback {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Retroalimentación")
                        .font(.headline)
                    Text(feedback)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .padding(12)
                        .background(Color.gray.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .animation(.easeOut(duration: 0.2), value: feedback)
            }
        }
        .padding(.top, 4)
    }
}

#Preview {
    NavigationStack {
        IaView()
    }
}
