//
//  Grille.swift
//  BatailleNavale
//
//  Created by ios06 on 05/08/2015.
//  Copyright (c) 2015 ios06. All rights reserved.
//

import UIKit

class Grille: NSObject {
    var lignes : Int
    var colonnes : Int
    var cases : [(bateau : Bateau!,id : Int!)]
    var flote : [Bateau]
    
    init(lignes : Int, colonnes : Int) {
        self.lignes = lignes
        self.colonnes = colonnes
        cases = Array(count : self.lignes*self.colonnes, repeatedValue : (nil,nil))
        self.flote = []
        self.flote.append(PorteAvion())
        self.flote.append(Cuirasse())
        self.flote.append(Torpilleur())
        self.flote.append(Croiseur())
        println("initialisation de la grille")
        

    }
    
    /**
    Initialise la position des bateaux sur la grille
    */
    func setBateauxSurGrille()
    {
        for bateau in self.flote
        {
            setPositionBateau(bateau)
        }
    }
    
    /**
    Placement de chaque bateau dans "cases[]".
    - la première boucle while :
        - génère une position et une direction (vertical / horizontal) aléatoire
        - vient tester s'il est positionable
        - tant que le bateau n'est pas positionnable, on regénère position et direction
    - A la suite du while, on vient placer dans "cases[]" :
        - la fonction "toucher" associée au bateau
        - l'id de la case du bateau
    
    :param: bateau bateau à placer
    */
    func setPositionBateau(bateau : Bateau)
    {
        var p = 0
        var verification = false
        var verticalOuHorizontal = 0
        
        while verification == false
        {
            p = Int(arc4random_uniform(100)) // nombre aléatoire compris entre 0 et 99
            verticalOuHorizontal = Int(arc4random_uniform(2)) // nombre aléatoire compris entre 0 et 1
            
            if verticalOuHorizontal == 1
            {
                verification = testHorizontal(p, tailleBateau: bateau.getPosition().count)
            }
            else
            {
                verification = testVertical(p, tailleBateau: bateau.getPosition().count)
            }
        }
        
        if verticalOuHorizontal == 1
        {
            placementHorizontal(p, bateau : bateau)
        }
        else
        {
            placementVertical(p, bateau : bateau)
        }
        
        
    }
    /**
    teste si le bateau est plaçable en verticale
    
    :param: pos          correspond au point de départ (la case la plus haute de notre bateau)
    :param: tailleBateau correspond à la taille du bateau (entre 2 et 5)
    
    :returns: retourne un booléen indiquant si la place est libre ou non
    */
    private func testVertical (pos : Int, tailleBateau : Int)->Bool
    {
        var libre = true
        
        if pos + tailleBateau * self.colonnes >= self.lignes*self.colonnes
        {
            println("le bateau va déborder vers le bas : \(pos + tailleBateau * 10)")
            return false
        }
        
        for var a = pos ; a < pos + (tailleBateau * self.lignes) ; a += self.lignes
        {
            if cases[a].bateau != nil
            {
                libre = false
                break
            }
            
        }
        
        return libre
    }
    
    /**
    teste si le bateau est plaçable en horizontale
    
    :param: pos          correspond au point de départ (la case la plus à gauche de notre bateau)
    :param: tailleBateau correspond à la taille du bateau (entre 2 et 5)
    
    :returns: retourne un booléen indiquant si la place est libre ou non
    */
    private func testHorizontal (pos : Int, tailleBateau : Int)->Bool
    {
        var libre = true
        
        if pos%self.colonnes + tailleBateau  >= self.lignes
        {
            println("le bateau va déborder vers la droite : \(pos) va déborder jusqu'à \(pos%self.colonnes + tailleBateau)")
            return false
        }
        
        for a in pos...(pos + (tailleBateau) - 1)
        {
            if cases[a].bateau != nil
            {
                libre = false
                break
            }
        }
        
        return libre
    }
    
    /**
    place le bateau à la verticale, dans "cases[]":
    - la fonction "toucher" associée au bateau
    - l'id de la case du bateau
    */
    private func placementVertical (pos : Int, bateau : Bateau)
    {
        for var a = pos ; a < pos + (bateau.getPosition().count * self.lignes) ; a += self.lignes
        {
            cases[a].bateau = bateau
            cases[a].id = (a - pos) / self.lignes
            
            println("Placement vertical : \(bateau.getPosition().count) à la position \(a). id : \(cases[a].id)")
        }
    }
    
    /**
    place le bateau à l'horizontale, dans "cases[]":
    - la fonction "toucher" associée au bateau
    - l'id de la case du bateau
    */
    private func placementHorizontal (pos : Int, bateau : Bateau)
    {
        for a in pos...(pos + (bateau.getPosition().count) - 1)
        {
            cases[a].bateau = bateau
            cases[a].id = (a - pos)
            println("Placement horizontal : \(bateau.getPosition().count) à la position \(a). id : \(cases[a].id)")
        }
    }
}
