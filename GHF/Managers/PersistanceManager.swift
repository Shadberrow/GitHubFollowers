//
//  PersistanceManager.swift
//  GHF
//
//  Created by Yevhenii on 08.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {

    static private let defaults = UserDefaults.standard

    enum Keys {
        static let favorites = "favorites"
    }

    /// Updates users favorites according to type parameter
    /// - Parameters:
    ///   - favorite: The favorite to update.
    ///   - type: The type of update. See `PersistanceActionType` for more.
    ///   - completion: A result of update. Error may occur
    static func updateWith(favorite: Follower,
                           actionType type: PersistanceActionType,
                           completion: @escaping (GHFError?) -> Void)
    { retreiveFavorites { (result) in

            switch result {
            case var .success(favorites):
                switch type {
                case .add:
                    guard !favorites.contains(favorite) else { completion(.alreadyInFavorites); return }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll(where: { $0.login == favorite.login })
                }
                completion(save(favorites: favorites))
            case let .failure(error):
                completion(error)
            }
        }

    }

    /// <#Description#>
    /// - Parameter completed: <#completed description#>
    static func retreiveFavorites(completed: @escaping (Result<[Follower], GHFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    /// <#Description#>
    /// - Parameter favorites: <#favorites description#>
    /// - Returns: <#description#>
    static func save(favorites: [Follower]) -> GHFError? {
        do {
            let encoder = JSONEncoder()
            let favoritesData = try encoder.encode(favorites)

            defaults.set(favoritesData, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }

}
