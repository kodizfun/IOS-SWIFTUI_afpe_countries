import SwiftUI

struct CountryListView: View {
        
    @State var viewModel = CountryViewModel()
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            
            // Afficher un loader tant que les données n'ont pas été chargées
            if viewModel.isLoading {
                
                // Afficher un loader tant que les données n'ont pas été chargées
                ProgressView("Loading...")
                
            } else {
                // Affichage en liste les pays avec leur code et leur drapeau
                List(viewModel.countries) { country in
                    HStack {
                        
                        // Chargement de l'image du drapeau à partir d'un URL
                        AsyncImage(url: URL(string: country.fields.flag[0].url)) { result in
                            if let image = result.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                            }
                        }
                        
                        // Nom et code du pays
                        VStack(alignment: .leading) {
                            Text(country.fields.name).bold()
                            Text(country.fields.code.uppercased())
                        }
                    }
                    
                }
                
                Button("Refresh") {
                    // Appeler le service pour charger les données
                    fetchCountries()
                }
                
            }
            
        }
        .onAppear {
            // Appeler le service pour charger les données
            fetchCountries()
        }
    }
    
    // Fonction qui récupère les données via le viewmodel
    func fetchCountries() {
        Task {
            await viewModel.fetchCountries()
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
