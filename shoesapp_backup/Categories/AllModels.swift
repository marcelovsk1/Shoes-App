import SwiftUI
import SceneKit

struct AllModels: View {
    let shoesModel = ShoesModel() // Criar uma instância do modelo fora da visualização de visualização rápida

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Banner
                    ZStack {
                        Image("justdoit")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 20)
                    }
                    
                    Button(action: {
                        // Ação do botão
                    }) {
                        Text("ALL MODELS")
                            .font(Font.custom("Futura-CondensedExtraBold", size: 34))
                            .italic()
                            .foregroundColor(.black)
                            .padding(.bottom, -20)
                    }
                    .padding(.horizontal)
                    
                    // Referência para a view Products com todos os sapatos
                    ProductsAllModels(shoesModel: shoesModel)
                }
            }
            .navigationBarTitle("", displayMode: .inline) // Para ajustar a posição da barra de navegação
        }
    }
}

struct AllModels_Previews: PreviewProvider {
    static var previews: some View {
        AllModels()
    }
}

struct ProductsAllModels: View {
    let shoesModel: ShoesModel // Receber o modelo como argumento
    @State private var searchText = ""

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(shoesModel.shoes.filter {
                    searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
                }) { shoe in
                    ProductCellAllModels(shoe: shoe)
                }
            }
            .padding()
        }
    }
}

struct ProductCellAllModels: View {
    let shoe: Shoe
    @State private var scene: SCNScene?

    private func loadScene() {
        scene = SCNScene(named: shoe.sceneName)
    }

    var body: some View {
        VStack {
            if let scene = scene {
                SceneView(scene: scene, options: [.autoenablesDefaultLighting, .allowsCameraControl])
                    .frame(width: 150, height: 150)
            } else {
                Image(shoe.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }

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
