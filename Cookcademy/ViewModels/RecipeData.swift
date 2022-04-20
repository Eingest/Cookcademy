//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Andreas Kiesel on 20.04.22.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
}
