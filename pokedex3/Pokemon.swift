//
//  Pokemon.swift
//  pokedex3
//
//  Created by Apple Macbook Pro on 24.02.2017.
//  Copyright © 2017 happydayapps. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    private var _nextEvolutionName: String!
    
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _height
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }

    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }

    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
        
    }
    
    
    func downloadPokemonDetail (completed: @escaping DownloadComplete) {
       
        Alamofire.request(_pokemonURL).responseJSON { (response) in

            //print(response.result.value)
           if let dict = response.result.value as? Dictionary<String, Any> {
            
            if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
            
            if let height = dict["height"] as? String {
                self._height = height
            }
            
            if let attack = dict["attack"] as? Int {
                self._attack = "\(attack)"
            }
            
            if let defense = dict["defense"] as? Int {
                self._defense = "\(defense)"
            }
            
            if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                
                if let name = types[0]["name"] {
                    self._type = name.capitalized
                }
                
                if types.count > 1 {
                    for x in 1..<types.count {
                        if let name = types[x]["name"] {
                            
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                }
                
                
            } else {
                self._type = " "
            }
            
            print("description çekiliyopr")
            
            if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0  {
                
                 print(descArr)
                
                if let url = descArr[0]["resource_uri"] {
                    Alamofire.request(URL_BASE+url).responseJSON(completionHandler: { (response) in
                        
                        
                        
                        print(response.result.value)
                        
                        
                        if let descDict = response.result.value as? Dictionary<String, Any> {
                            
                            
                            if let description = descDict["description"] as? String {
                                
                                let newDesc = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                
                                self._description = newDesc
                                print("description: \(description)")
                            }
                            
                        } else {
                            self._description = ""
                        }
                        completed()
                })
                
            }
            }
            
            //evolution
            
            print("evolution çekiliyopr")
            
            if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>] , evolutions.count > 0  {
                
                print("evolutions \(evolutions)")
                
                if let url = evolutions[0]["resource_uri"] {
                    Alamofire.request("\(URL_BASE)\(url)").responseJSON(completionHandler: { (response) in
                        
                        
                        
                        print("evolutions dan gelen JSOn \(response.result.value)")
                        
                        
                        if let evolutionsDict = response.result.value as? Dictionary<String, Any> {
                            
                            
                            if let nextEvolutionPokedexId = evolutionsDict["pkdx_id"] as? Int {
                                
                                
                                
                                self._nextEvolutionTxt = "\(nextEvolutionPokedexId)"
                                print("nextEvolutionPokedexId: \(nextEvolutionPokedexId)")
                            }
                            
                            if let nextEvolutionName = evolutionsDict["name"] as? String {
                                self._nextEvolutionName = nextEvolutionName
                            }
                            
                        } else {
                            self._nextEvolutionTxt = ""
                        }
                        completed()
                    })
                    
                }
            }
            
            
            
            print("height: "+self._weight)
            print(self._height)
            print(self._attack)
            print(self._defense)
            
            }
           
            completed()
            
        }
        
        
    }
    
}
