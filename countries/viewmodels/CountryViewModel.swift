import Foundation

@Observable
class CountryViewModel {
    var countries = [Country]()
    var isLoading = false
    
    private let apiUrl = "https://api.airtable.com/v0/apphgJYWqwp0W3V0H/countries"
    private let apiToken = "patABn8ym35gbHwcb.d044573b2c5416864a57eeaae0f925bf10f288a294c9da6be415ef94c98ce8dc"
    
    @MainActor
    func fetchCountries() async {
            
            // Objet URL pour la requête
            let url = URL(string: apiUrl)!
            
            // Objet requête contenant des en-têtes ou d'autres métadonnées
            var request = URLRequest(url: url)
            request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
            
            // Mis à jour de l'état de chargement des données : les données sont en cours de chargement
            isLoading = true
            
            do {
                
                // Tentative d'exécution de la requête vers l'API
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Décodage ou conversion des données reçues au format CountriesResponse
                let decodedData = try JSONDecoder().decode(CountriesResponse.self, from: data)
                
                // Mettre à jour l'état de la variable
                self.countries = decodedData.records
                
                // Mis à jour de l'état de chargement des données : les données sont complètement chargées et converties
                self.isLoading = false
                
            } catch {
                
                // Mis à jour de l'état de chargement des données : les données n'ont pas été chargées, fin de la requête
                self.isLoading = false
                
                print(error.localizedDescription)
                print(error)
            }
        }
    
    
}
