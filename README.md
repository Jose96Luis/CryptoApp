# CryptoApp

CryptoApp es una aplicación móvil que muestra información sobre las principales criptomonedas del mercado. La aplicación utiliza la API de CoinGecko para obtener datos en tiempo real y los almacena de manera persistente usando UserDefaults.

![CryptoApp Screenshot](screenshot.png)

## Características

- Lista de criptomonedas con el precio, supply y porcentaje de cambio cada 24 hr.
- Persistencia de datos utilizando UserDefaults.
- Actualización en tiempo real de los datos de las criptomonedas.

## Arquitectura y Patrón de Diseño

### Arquitectura

La arquitectura utilizada en CryptoApp es MVVM (Model-View-ViewModel). Este enfoque separa claramente la lógica de negocio y la lógica de presentación, facilitando la mantenibilidad y testabilidad del código.

- **Model**: Contiene las estructuras de datos (`CoinGeckoCrypto`, `CryptoStorage`).
- **View**: Las vistas de SwiftUI que presentan la interfaz de usuario.
- **ViewModel**: Maneja la lógica de negocio y las interacciones con los servicios (`CryptoViewModel`).

### Patrón de Diseño

- **MVVM**: El patrón MVVM separa la lógica de presentación (View) de la lógica de negocio (ViewModel) y la lógica de datos (Model), facilitando así la prueba y el mantenimiento del código.
- **Service Layer**: La capa de servicios (`CoinGeckoService`) se encarga de realizar las solicitudes de red y decodificar las respuestas.

## Persistencia de Datos

Para la persistencia de datos, utilizamos `UserDefaults`. Los datos de las criptomonedas se guardan en `UserDefaults` para que estén disponibles incluso cuando la aplicación se cierra y se vuelve a abrir. La estructura `CryptoStorage` se utiliza para serializar y deserializar los datos de las criptomonedas.
**NOTA**: UserDefaults fue la mejor opción ya que para integrar CoreData se requerían más implementaciones y configuraciones en el proyecto.

## Consumo de Servicios

Para el consumo de servicios, utilizamos `URLSession` junto con `async` y `await` para realizar las solicitudes de red de manera asíncrona. Esta técnica permite que el código sea más legible y manejable, evitando el uso excesivo de closures y callbacks. A continuación se describe cómo se consume el servicio:

```swift
class CoinGeckoService {
    func fetchCryptos() async -> [CoinGeckoCrypto]? {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd") else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            if let cryptos = try? decoder.decode([CoinGeckoCrypto].self, from: data) {
                return cryptos
            } else if let errorResponse = try? decoder.decode([String: String].self, from: data) {
                print("Error response from API: \(errorResponse)")
                return nil
            } else {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Unexpected response format: \(responseString)")
                }
                return nil
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return nil
        }
    }

## Uso de SwiftUI
Se decidió utilizar SwiftUI para la construcción de la interfaz de usuario debido a sus ventajas significativas sobre UIKit:

Declarativo: SwiftUI permite construir interfaces de usuario de manera declarativa, lo que facilita la lectura y el mantenimiento del código.
Compatibilidad: SwiftUI se integra perfectamente con todas las plataformas de Apple, incluyendo iOS, macOS, watchOS y tvOS.
Actualización en Tiempo Real: SwiftUI proporciona vistas previas en tiempo real en Xcode, lo que acelera el desarrollo y permite iterar rápidamente sobre el diseño de la interfaz de usuario.
