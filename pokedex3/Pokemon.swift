//
//  Pokemon.swift
//  pokedex3
//
//  Created by Apple Macbook Pro on 24.02.2017.
//  Copyright © 2017 happydayapps. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _width: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
    
}
