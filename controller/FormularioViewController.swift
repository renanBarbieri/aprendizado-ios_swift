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
    var contato:Contato!
    var delegate:FormularioViewControllerDelegate?
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
        dao = ContatoDao.ContatoDaoInstance()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if contato != nil {
            self.nameInput.text = contato.name
            self.phoneInput.text = contato.phone
            self.addressInput.text = contato.address
            self.siteInput.text = contato.site
            
            
            // selector com parametro: #selector( metodo(_:param1:param2:) )
            let botaoAlterar: UIBarButtonItem = UIBarButtonItem( title: "Confirmar", style: .plain, target: self, action: #selector(updateContato) )
            self.navigationItem.rightBarButtonItem = botaoAlterar
            self.navigationItem.title = "Editar Contato"
            
        }
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
        
        if self.delegate != nil {
            self.delegate?.addContatoDone(contato: contato)
        }
        
        
        //o '_' eh para ignorar o reultado
        _ = self.navigationController?.popViewController(animated: true)
        
        //se for feito um modal, utilizar dissmiss
    }
    
    func updateContato(){
        let name = nameInput.text!
        let phone = phoneInput.text!
        let address = addressInput.text!
        let site = siteInput.text!
        
        contato.updateValues(name, phone: phone, address: address, andSite: site)
        
        if self.delegate != nil {
            self.delegate?.editContatoDone(contato: contato)
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
}
