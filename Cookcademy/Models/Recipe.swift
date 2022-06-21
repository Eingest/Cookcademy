//
//  Recipe.swift
//  Cookcademy
//
//  Created by Andreas Kiesel on 17.04.22.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID()
    
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    var isFavorite = false
    
    var isValid: Bool {
        mainInformation.isValid && !ingredients.isEmpty && !directions.isEmpty
    }
    
    init(mainInformation: MainInformation, ingredients: [Ingredient], directions: [Direction]) {
        self.mainInformation = mainInformation
        self.ingredients = ingredients
        self.directions = directions
    }
    
    init() {
        self.init(mainInformation: MainInformation(name: "", description: "", author: "", category: .breakfast), ingredients: [], directions: [])
    }
    
    func index(of direction: Direction, excludingOptionalDirections: Bool) -> Int? {
        let directions = directions.filter { excludingOptionalDirections ? !$0.isOptional : true }
        let index = directions.firstIndex { $0.description == direction.description }
        return index 
    }
}

struct MainInformation: Codable {
    var name: String
    var description: String
    var author: String
    var category: Category
    
    var isValid: Bool {
        !name.isEmpty && !description.isEmpty && !author.isEmpty
    }
    
    enum Category: String, CaseIterable, Codable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
}

struct Ingredient: RecipeComponent {
    var name: String
    var quantity: Double
    var unit: Unit
    
    var description: String {
        let formattedQuantity = String(format: "%g", quantity)
        switch unit {
        case .none:
            let formattedName = quantity == 1 ? name : "\(name)s"
            return "\(formattedQuantity) \(formattedName)"
        default:
            if quantity == 1 {
                return "1 \(unit.singularName) \(name)"
            } else {
                return "\(formattedQuantity) \(unit.rawValue) \(name)"
            }
        }
    }
    
    enum Unit: String, CaseIterable, Codable {
        case oz = "Ounces"
        case g = "Grams"
        case cups = "Cups"
        case tbs = "Tablespoons"
        case tsp = "Teaspoons"
        case none = "No units"
        
        var singularName: String { String(rawValue.dropLast()) }
    }
    
    init(name: String, quantity: Double, unit: Unit) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
    
    init() {
        self.init(name: "", quantity: 1.0, unit: .none)
    }
}

struct Direction: RecipeComponent {
    var description: String
    var isOptional: Bool
    
    init(description: String, isOptional: Bool) {
        self.description = description
        self.isOptional = isOptional
    }
    
    init() {
        self.init(description: "", isOptional: false)
    }
}
