//
//  GHFError.swift
//  GHF
//
//  Created by Yevhenii on 05.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import Foundation

enum GHFError: String, Error {

    case invalidUsername    = "This user name created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check yout Internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from server was invalid. Please try again."

    case unableToFavorite   = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "You've alredy favorited this user."

}

