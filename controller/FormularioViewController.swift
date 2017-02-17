//
//  FormularioViewController.swift
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 15/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import UIKit

class FormularioViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var siteInput: UITextField!
    
    var dao:ContatoDao!
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
        dao = ContatoDao.ContatoDaoInstance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Metodo que adiciona um contato à lista de contatos
    ///
    /// - Parameter sender: um elemento da tela qualquer
    @IBAction func addContato(_ sender: Any) {
        let name = nameInput.text!
        let phone = phoneInput.text!
        let address = addressInput.text!
        let site = siteInput.text!
        
        let contato:Contato = Contato.init(name: name, phone: phone, address: address, andSite: site)
        print(contato)
        
        dao.addContato(contato)
        
        //o '_' eh para ignorar o reultado
        _ = self.navigationController?.popViewController(animated: true)
        
        //de for feito um modal, utilizar dissmiss
    }
}
