

import SwiftUI

struct GuillermoOchoaView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Foto del jugador (desde Assets con nombre "guillermo_ochoa")
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)

                    // Si tienes la imagen en Assets con ese nombre, se mostrará;
                    // si no, verás el placeholder del sistema.
                    if UIImage(named: "guillermo_ochoa") != nil {
                        Image("guillermo_ochoa")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 260)
                            .clipped()
                            .cornerRadius(16)
                    } else {
                        VStack(spacing: 8) {
                            Image(systemName: "person.crop.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundStyle(.secondary)
                            Text("Añade la foto en Assets con el nombre:")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Text("guillermo_ochoa")
                                .font(.footnote.monospaced())
                                .foregroundStyle(.secondary)
                        }
                        .frame(height: 260)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 260)
                .padding(.horizontal)

                // Ficha de datos
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Guillermo Ochoa")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                        Spacer()
                        // Número de camiseta destacado
                        ZStack {
                            Circle()
                                .fill(Color.green.opacity(0.15))
                                .frame(width: 56, height: 56)
                            Text("13")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(.green)
                        }
                    }

                    Divider()

                    // Información principal
                    fichaRow(titulo: "Posición", valor: "Portero")
                    fichaRow(titulo: "Club", valor: "Salernitana")
                    fichaRow(titulo: "Selección", valor: "México")
                    fichaRow(titulo: "Edad", valor: "39")
                    fichaRow(titulo: "Estatura", valor: "1.85 m")
                    fichaRow(titulo: "Peso", valor: "78 kg")

                    Divider()

                    // Bio o descripción corta
                    Text("Arquero histórico de la Selección Mexicana, reconocido por sus reflejos y actuaciones destacadas en torneos internacionales.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                )
                .padding(.horizontal)

                // Acciones
                HStack(spacing: 12) {
                    Button {
                        // Acción: marcar favorito
                    } label: {
                        Label("Favorito", systemImage: "star")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow.opacity(0.2))
                            .foregroundStyle(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    Button {
                        // Acción: compartir
                    } label: {
                        Label("Compartir", systemImage: "square.and.arrow.up")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.2))
                            .foregroundStyle(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            
        }
        .background(Color(.systemGroupedBackground))
    }

    @ViewBuilder
    private func fichaRow(titulo: String, valor: String) -> some View {
        HStack {
            Text(titulo)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Spacer()
            Text(valor)
                .font(.body)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        GuillermoOchoaView()
    }
}
