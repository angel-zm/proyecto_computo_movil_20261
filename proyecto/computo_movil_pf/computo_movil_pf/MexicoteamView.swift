import SwiftUI

struct MexicoteamView: View {
    var body: some View {
        ZStack {
            // Fondo verde bandera
            Color.green
                .ignoresSafeArea()
            
            VStack {
                // Encabezado
                HStack {
                    Image("mexicoTeam")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .frame(width: 200, height: 200)
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                    
                    Text("México")
                        .font(.system(size: 48, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .lineLimit(1) // evita salto de línea
                        .minimumScaleFactor(0.5) // si no cabe, se reduce el tamaño
                        .padding(.top, 45)
                        .offset(x: -50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                
                // Menú horizontal
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        NavigationLink(destination: JugadoresMexicoView()) {
                            //Button(action: { print("Jugadores") }) {
                                Text("Jugadores")
                                    .font(.system(size: 24, weight: .bold, design: .rounded)) // <- Aquí aumentas tamaño y estilo
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.3))
                                    .cornerRadius(10)
                           // }
                        }
                        Button(action: { print("Resultados") }) {
                            Text("Resultados")
                                .font(.system(size: 24, weight: .bold, design: .rounded)) // <- Aquí aumentas tamaño y estilo
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(10)
                        }
                        
                        Button(action: { print("Calendario") }) {
                            Text("Calendario")
                                .font(.system(size: 24, weight: .bold, design: .rounded)) // <- Aquí aumentas tamaño y estilo
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 10)
                
                Spacer() // Para empujar todo hacia arriba
            }
        }
    }
}

#Preview {
    NavigationStack {
        MexicoteamView()
    }
}

