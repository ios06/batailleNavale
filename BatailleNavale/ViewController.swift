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

    @IBOutlet weak var affichageCoups: UILabel!
    @IBOutlet weak var affichageScore: UILabel!
    
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
        case "raté" :
            bouton.hidden = true
            scoring -= 10
        case "touché" :
            bouton.backgroundColor = UIColor.orangeColor()
            scoring += 100
        case "coulé" :
            bouton.backgroundColor = UIColor.grayColor()
            scoring += 500
        case "gagné" :
            bouton.backgroundColor = UIColor.grayColor()
            scoring += 1000
        default:
            break
        }

        
        let alertController = UIAlertController(title: "Bataille Navalle !!", message:
            "\(etat)!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Continuer", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

