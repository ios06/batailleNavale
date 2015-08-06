//
//  ViewController.swift
//  BatailleNavale
//
//  Created by ios06 on 04/08/2015.
//  Copyright (c) 2015 ios06. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var partie = Partie()
    var scoring = 0
    let couleurOrigine = UIColor(red: 14/255, green: 188/255, blue: 206/255, alpha: 1)

    @IBOutlet weak var affichageCoups: UILabel!
    @IBOutlet weak var affichageScore: UILabel!
    @IBOutlet var boutonsGrille: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
    fonction gérant l'évènement de la tentative du joueur.
    Il change la couleur de la case selon l'état renvoyé.
    
    :param: sender bouton activé
    */
    @IBAction func touchDownGrille(sender: UIButton) {
        
        traitementAction(partie.getEtat(sender.tag), bouton : sender)
        afficherScore(partie.nombreDeCoups)
        
    }
    
    /**
    *  gestion de l'affichage du nombre de coups et du score
    */
    func afficherScore(nombreDeCoups : Int)
    {
        affichageCoups.text = "\(nombreDeCoups)"
        affichageScore.text = "\(scoring)"
    }
    
    
    /**
    gère l'affichage d'une pop-up indiquant si le joueur a raté, touché , coulé un bateau. si il a gagné , la pop-up sera différente
    
    :param: etat état renvoyé suite au touchDown
    */
    func traitementAction(etat : String, bouton : UIButton)
    {
        
        switch etat {
        case "Raté" :
            bouton.hidden = true
            scoring -= 10
            affichagePopUp(etat, message: "Tu n'as pas l'air très doué ! allez, essaie encore")
        case "Touché" :
            bouton.backgroundColor = UIColor.orangeColor()
            scoring += 100
            affichagePopUp(etat, message: "C'est pas mal, un coup de chance ?!")
        case "Coulé" :
            bouton.backgroundColor = UIColor.grayColor()
            scoring += 500
            affichagePopUp(etat, message: "Bon c'était pas un coup de chance")
        case "Gagné" :
            bouton.backgroundColor = UIColor.grayColor()
            scoring += 1000
            affichagePopUp(etat, message: "Bravo, tu m'as battu, voici ton score : \(scoring). C'est pas trop mal")
            nouvellePartie()
        default:
            break
        }

        
        
    }
    
    func affichagePopUp(titre : String, message : String)
    {
        var titreBouton : String
        
        titreBouton = "Continuer"
        if titre == "Gagné"
        {
            titreBouton = "Recommencer"
        }
        let alertController = UIAlertController(title: titre, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: titreBouton, style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func nouvellePartie()
    {
        partie = Partie()
        scoring = 0
        for a in boutonsGrille
        {
            a.hidden = false
            a.backgroundColor = couleurOrigine
        }
    }
}

