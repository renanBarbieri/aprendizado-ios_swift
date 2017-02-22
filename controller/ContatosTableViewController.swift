//
//  ContatosTableViewController.swift
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 16/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import UIKit

class ContatosTableViewController: UITableViewController, FormularioViewControllerDelegate {
    
    private var dao:ContatoDao!
    static let cellIdentifier:String = "cell"
    var selectedContato:Contato!
    var highlightRow: Int?
    var actionsManager:LongPressActionManager!
    
    // Metodo chamado quando a tela eh instanciada pela primeira vez.
    // Soh eh chamado quando nao ha nenhuma instancia da tela
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
        dao = ContatoDao.ContatoDaoInstance()
        highlightRow = -1
    }
    
    
    /// Metodo chamado quando os elementos de tela (views/outlets) estao pronto para uso
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let gestureLongPress = UILongPressGestureRecognizer(target: self, action: #selector(showMoreActions(_:)))
        
        self.tableView.addGestureRecognizer(gestureLongPress)
    }
    
    /// Metodo da viewController. Chamado apos o metodo viewDidLoad
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        if(dao.getContatos().count>0){
            self.navigationItem.leftBarButtonItem = self.editButtonItem
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.highlightRow! >= 0 {
            let indexPath:IndexPath = IndexPath(row: highlightRow!, section: 0)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            self.highlightRow = -1
        }
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
            tableView.deleteRows(at: [indexPath], with: .left)
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
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        
        return .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedContato = dao.getContatoAt(position: indexPath.row)
        self.showContato()
    }
    
    func showContato(){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let form:FormularioViewController = storyboard.instantiateViewController(withIdentifier: "form_view") as! FormularioViewController
        form.contato = selectedContato
        form.delegate = self
        self.navigationController?.pushViewController(form, animated: true)
    }
    
    
    /// Metodo chamado ao realizar a transicao de tela
    ///
    /// - Parameters:
    ///   - segue: <#segue description#>
    ///   - sender: <#sender description#>
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_form" {
            let form:FormularioViewController = segue.destination as! FormularioViewController
            form.delegate = self
        }
    }
    
    func addContatoDone(contato: Contato) {
        print("contato adicionado: \(contato.name!)")
        self.highlightRow = dao.getPositionOf(contato: contato)
    }
    
    func editContatoDone(contato: Contato) {
        print("contato editado: \(contato.name!)")
        self.highlightRow = dao.getPositionOf(contato: contato)
    }
    
    func showMoreActions(_ gesture: UIGestureRecognizer){
        if(gesture.state == .began){
            let screenPosition:CGPoint = gesture.location(in: self.tableView)
            //associa a variavel o possivel valor se encontrar
            if let indexPath:IndexPath = self.tableView.indexPathForRow(at: screenPosition){
                self.selectedContato = self.dao.getContatoAt(position: indexPath.row)
                
                self.actionsManager = LongPressActionManager(withContato: self.selectedContato, andController: self)
                self.actionsManager.defineActions()
                
            }
        }
    }
}
