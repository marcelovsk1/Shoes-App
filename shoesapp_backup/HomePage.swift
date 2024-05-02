import SwiftUI

struct HomePage: View {
    @State private var searchText = ""
    @State private var tabSelectedValue = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30) // Ajuste a quantidade de preenchimento horizontal aqui
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 25)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 30) // Ajuste o preenchimento à esquerda do ícone de pesquisa aqui
                            Spacer()
                        }
                    )
                    .padding(.vertical, 13)
                    .padding(.top)

                
                if tabSelectedValue == 0 {
                    Running()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if tabSelectedValue == 1 {
                    Lifestyle()
                } else {
                    AllModels()
                }
                
                // Menu footer
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // Ação do botão HOME
                    }) {
                        VStack {
                            Image(systemName: "house")
                                .font(.title)
                                .foregroundColor(.black)
                            Text("HOME")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        // Ação do botão RUNNING
                        self.tabSelectedValue = 0
                    }) {
                        NavigationLink(destination: BagView()) {
                            VStack {
                                Image(systemName: "bag")
                                    .font(.title)
                                    .foregroundColor(.black)
                                Text("BAG")
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        // Ação do botão LIFESTYLE
                        self.tabSelectedValue = 1
                    }) {
                    NavigationLink(destination: ProfileView()) {
                            VStack {
                                Image(systemName: "person.circle")
                                    .font(.title)
                                    .foregroundColor(.black)
                                Text("ACOUNT")
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                }
//                .padding(.top)
                .background(Color(.white))

            }
            .navigationBarItems(
                leading: HStack {
                    Button(action: {}) {
                        Image("logo-black")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .padding(.bottom, -20)
                            .padding(.leading, 25)
                    }
                    .padding(.leading, 0)
                },
                trailing: VStack {
                    Picker("", selection: $tabSelectedValue) {
                        Text("Running").tag(0)
                        Text("Lifestyle").tag(1)
                        Text("All Models").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(20)
                    .padding(.top)
                }
            )
            .navigationBarTitle("", displayMode: .inline) // Para ajustar a posição da barra de navegação
        }
    }
}

struct RunningGrid: View {
    let shoesModel = ShoesModel()
    @State private var isImageTapped: String = ""

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(shoesModel.shoes.filter { $0.shoesType == "Running" }) { shoe in
                    RunningProductCell(shoe: shoe, isImageTapped: $isImageTapped)
                }
            }
            .padding()
        }
    }
}


struct LifestyleGrid: View {
    let shoesModel = ShoesModel()
    @State private var isImageTapped: String = ""

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(shoesModel.shoes.filter { $0.shoesType == "Lifestyle" }) { shoe in
                    RunningProductCell(shoe: shoe, isImageTapped: $isImageTapped)
                }
            }
            .padding()
        }
    }
}

struct AllModelsGrid: View {
    let shoesModel = ShoesModel()
    @State private var isImageTapped: String = ""

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(shoesModel.shoes.filter { $0.shoesType == "Lifestyle" }) { shoe in
                    RunningProductCell(shoe: shoe, isImageTapped: $isImageTapped)
                }
            }
            .padding()
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
