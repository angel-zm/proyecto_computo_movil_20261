//
//  ContentView.swift
//  computo_movil_pf
//
//  Created by Angel on 18/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    // Opacidad de marcas de agua
    private let greenOpacity: CGFloat = 0.12
    private let blueOpacity:  CGFloat = 0.30
    private let redOpacity:   CGFloat = 0.12

    private let sectionInsetV: CGFloat = 6
    private let sectionInsetH: CGFloat = 8

    // Variable para navegación automática
    @State private var navigateToMain = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradiente
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .green, location: 0.00),
                        .init(color: .green, location: 0.28),
                        .init(color: .blue,  location: 0.32),
                        .init(color: .blue,  location: 0.68),
                        .init(color: .red,   location: 0.72),
                        .init(color: .red,   location: 1.00)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Marcas de agua
                GeometryReader { proxy in
                    let w = proxy.size.width
                    let h = proxy.size.height

                    let greenH = h * 0.30
                    let blueH  = h * 0.40
                    let redH   = h * 0.30

                    VStack(spacing: 0) {
                        ZStack {
                            Image("aguila")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, sectionInsetV)
                                .padding(.horizontal, sectionInsetH)
                                .frame(maxWidth: w, maxHeight: greenH - 2*sectionInsetV)
                                .opacity(greenOpacity)
                        }
                        .frame(height: greenH, alignment: .center)

                        ZStack {
                            Image("estrella")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, sectionInsetV)
                                .padding(.horizontal, sectionInsetH)
                                .frame(maxWidth: w, maxHeight: blueH - 2*sectionInsetV)
                                .opacity(blueOpacity)
                        }
                        .frame(height: blueH, alignment: .center)

                        ZStack {
                            Image("hoja")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, sectionInsetV)
                                .padding(.horizontal, sectionInsetH)
                                .frame(maxWidth: w, maxHeight: redH - 2*sectionInsetV)
                                .opacity(redOpacity)
                        }
                        .frame(height: redH, alignment: .center)
                    }
                    .allowsHitTesting(false)
                }
                .ignoresSafeArea()

                // Contenido principal
                
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

                Image("logo_mundial")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .shadow(radius: 10)
                    .offset(y: -18)

                // NavigationLink invisible para redirección automática
                NavigationLink(destination: MainView(),
                               isActive: $navigateToMain) {
                    EmptyView()
                }
            }
            .onAppear {
                // Redirige automáticamente después de 3 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    navigateToMain = true
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
