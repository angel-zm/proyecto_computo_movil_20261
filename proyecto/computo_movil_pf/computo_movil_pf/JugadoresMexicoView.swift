import SwiftUI

struct JugadoresMexicoView: View {
    var body: some View {
        List {
            Section("Porteros") {
                NavigationLink(destination: GuillermoOchoaView()) {
                    Text("Guillermo Ochoa")
                }
                Text("Luis Malagón")
            }
            Section("Defensas") {
                Text("Johan Vásquez")
                Text("César Montes")
            }
            Section("Mediocampistas") {
                Text("Edson Álvarez")
                Text("Luis Chávez")
            }
            Section("Delanteros") {
                Text("Hirving Lozano")
                Text("Santiago Giménez")
            }
        }
        .navigationTitle("México")
    }
}

#Preview {
    NavigationStack {
        JugadoresMexicoView()
    }
}
