import SwiftUI
import SceneKit

struct Running: View {
    @State private var isImageTapped: String = "" // Variável para controlar qual imagem foi tocada

    let shoesModel = ShoesModel() // Criar uma instância do modelo fora da visualização de visualização rápida

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Banner
                    ZStack {
                        Image("wpnike")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 20)
                    }

                    Button(action: {
                        // Ação do botão
                    }) {
                        Text("RUNNING SHOES")
                            .font(Font.custom("Futura-CondensedExtraBold", size: 34))
                            .italic()
                            .foregroundColor(.black)
                            .padding(.bottom, -20)
                    }
                    .padding(.horizontal)

                    // Referência para a view Products com filtros aplicados
                    ProductsRunning(shoesModel: shoesModel, filter: "Running", isImageTapped: $isImageTapped)

                    // Outros elementos da sua view Running
                }
            }
            .navigationBarTitle("", displayMode: .inline) // Para ajustar a posição da barra de navegação
        }
    }
}

struct Running_Previews: PreviewProvider {
    static var previews: some View {
        Running()
    }
}

struct ProductsRunning: View {
    let shoesModel: ShoesModel // Receber o modelo como argumento
    @State private var searchText = ""
    let filter: String
    @Binding var isImageTapped: String // Adicionar binding para controlar a navegação

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(shoesModel.shoes.filter {
                    ($0.shoesType == filter) && (searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText))
                }) { shoe in
                    RunningProductCell(shoe: shoe, isImageTapped: $isImageTapped)
                }
            }
            .padding()
        }
    }
}

struct RunningProductCell: View {
    let shoe: Shoe
    @State private var scene: SCNScene?
    @Binding var isImageTapped: String // Adicionar binding para controlar a navegação

    private func loadScene() {
        scene = SCNScene(named: shoe.sceneName)
    }

    var body: some View {
        VStack {
            Button(action: {
                // Defina a ação do botão aqui, se necessário
                isImageTapped = shoe.name // Defina a string isImageTapped para o nome do sapato
            }) {
                if let scene = scene {
                    SceneView(scene: scene, options: [.autoenablesDefaultLighting, .allowsCameraControl])
                        .frame(width: 150, height: 150)
                } else {
                    Image(shoe.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .fullScreenCover(isPresented: .constant(shoe.name == isImageTapped), content: {
                Home()
            })

            Text(shoe.name)
                .font(.headline)
                .multilineTextAlignment(.center)

            if shoe.price > 0 {
                Text("$\(shoe.price)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .onAppear {
            loadScene()
        }
    }
}
