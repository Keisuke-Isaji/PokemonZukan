import SwiftData
import Foundation

@MainActor
class FavoriteRepository: ObservableObject {
    var container: ModelContainer?

    init() {
        self.container = try? ModelContainer(for: FavoriteData.self)
    }

    func append(with content: FavoriteData) async {
        container?.mainContext.insert(content)
    }

    func fetchAll() async -> [FavoriteData] {
        var result = [FavoriteData]()
        let descriptor = FetchDescriptor<FavoriteData>(sortBy: [SortDescriptor(\FavoriteData.pokemonId)])
        do {
            result = try container?.mainContext.fetch(descriptor) ?? []
        } catch {
            print(error)
        }
        return result
    }
//
//    func update(content: FavoriteData, with pokemonId: Int) async {
//        let descriptor = FetchDescriptor<FavoriteData>(sortBy: [SortDescriptor(\FavoriteData.pokemonId)]) // ソート対象のプロパティを指定
//        let list = (try? container?.mainContext.fetch(descriptor)) ?? []
//        let target = list.first(where: { $0.pokemonId == content.pokemonId })
//        target?.pokemonId = pokemonId
//    }

    func delete(content: FavoriteData) async {
        let descriptor = FetchDescriptor<FavoriteData>(sortBy: [SortDescriptor(\FavoriteData.pokemonId)]) // ソート対象のプロパティを指定
        let list = (try? container?.mainContext.fetch(descriptor)) ?? []
        guard let target = list.first(where: { $0.pokemonId == content.pokemonId }) else { return }
        container?.mainContext.delete(target)
    }
}
