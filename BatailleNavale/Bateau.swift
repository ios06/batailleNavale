//
//  Bateau.swift
//  CompteBancaireSwift
//
//  Created by AFPA01 on 04/08/2015.
//  Copyright (c) 2015 IOS01. All rights reserved.
//

import Foundation

/// <#Description#>
class Bateau
{
    private var position : [Bool]
    
    
    
    init(nombreCases:Int)
    {
        position = Array(count:nombreCases,repeatedValue: false)
        
        
    }
    
    /// <#Description#>
    var coule : Bool
    {
        get{
            var _coule : Bool = true
            
            if((find(position, false)) != nil)
            {
                _coule = false
            }

            return _coule
        }
        
    }
    
    
    /**
    <#Description#>
    
    :param: _case <#_case description#>
    */
    func toucher(_case:Int)->Bool
    {
        position[_case] = true
        return self.coule
    }
    
    func getPosition()-> [Bool]
    {
        return position
    }
    
}



class PorteAvion : Bateau
{
    init(){
        let nombreCases = 5
        super.init(nombreCases: nombreCases)
    }
    
}


class Cuirasse : Bateau
{
    init(){
        let nombreCases = 4
        super.init(nombreCases: nombreCases)
    }
    
}


class Torpilleur : Bateau
{
    init(){
        let nombreCases = 3
        super.init(nombreCases: nombreCases)
    }
    
}

class Croiseur : Bateau
{
    init(){
        let nombreCases = 2
        super.init(nombreCases: nombreCases)
    }
    
}

