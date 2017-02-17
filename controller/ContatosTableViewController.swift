//
//  ContatosTableViewController.swift
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 16/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import UIKit

class ContatosTableViewController: UITableViewController {
    
    private var dao:ContatoDao!
    static let cellIdentifier:String = "cell"
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
        dao = ContatoDao.ContatoDaoInstance()
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dao.contatos.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            self.dao.removeAt(position: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    /// Carrega a view da linha
    ///
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#return value description#>
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: ContatosTableViewController.cellIdentifier)
        
        if (cell == nil) {
            //obter uma nova instancia
            // existem 4 tipos de estilo definidos pelo enum importado do tableViewController
           cell = UITableViewCell(style: .default, reuseIdentifier: ContatosTableViewController.cellIdentifier)
        }
        
        let contato:Contato = self.dao.getContatoAt(position: indexPath.row)
        cell?.textLabel?.text = contato.name
        
        return cell!
    }
    
    
    /// Para desabilitar a opcao de deletar
    ///
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: posicao a ser carregada
    /// - Returns: <#return value description#>
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        if tableView.isEditing {
//            return .delete
//        }
//        
//        return .none
//    }
}
