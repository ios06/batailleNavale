//
//  Partie.swift
//  BatailleNavale
//
//  Created by ios06 on 05/08/2015.
//  Copyright (c) 2015 ios06. All rights reserved.
//

import UIKit

class Partie: NSObject {
    var nombreDeCoups : Int
    var grille : Grille
    
    override init () {
        nombreDeCoups = 0
        grille = Grille(lignes: 10, colonnes: 10)
        grille.setBateauxSurGrille()
        println("initialisation de la partie")
    }
    
    /**
    Fonction déterminant l'état de la partie selon le coup qui vient d'être joué
    
    :param: tag le tag correspond à la case qui vient d'être tappée
    
    :returns: retourne l'état sous forme de String : "raté", "touché", "coulé", "gagné"
    */
    func getEtat(tag : Int) -> String
    {
        nombreDeCoups++
        var etat : Bool!
        var f :(Int->Bool)!
        var i : Int!
        let raté = "raté"
        let touché = "touché"
        let coulé = "coulé"
        let gagné = "gagné"
        
        (f,i) = grille.cases[tag]
        etat = toucheCoule(function: f,id: i)
        
        switch etat {
        case nil :
            return raté
        case false :
            return touché
        case true :
            if (grille.porteAvion.coule && grille.cuirasse.coule && grille.torpilleur.coule && grille.croiseur.coule){
                return gagné
            } else {
                return coulé
            }
        default:
            return raté
        }
    }
    
    /**
    fonction générique traitant la fonction se trouvant dans la case selectionnée
    
    :param: function fonction "bateau.toucher" du bateau à traiter.
    :param: id       id de bateau.case à mettre à true (true = touché)
    
    :returns: la fonction renvoi un booléen nilable : 
    - nil si il n'y a pas de fonction (et donc pas de bateau) à cette case. 
    - false si un bateau a été touché mais pas coulé. 
    - true si le bateau a été coulé
    */
    func toucheCoule (#function :(Int->Bool)!, id : Int!)->Bool!
    {
        if id == nil
        {
            return nil
        }
        else
        {
            println("id : \(id)")
            return function(id)
        }
    }
}
