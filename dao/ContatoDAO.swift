//
//  ContatoDAO.swift
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 16/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import Foundation

class ContatoDao: NSObject{
    
    //singleton da classe
    static private var instance:ContatoDao!
    
    var contatos:Array<Contato>!
    
    
    /// Rertorna a instancia do do singleton aplicado
    ///
    /// - Returns: singleton setado
    static func ContatoDaoInstance() -> ContatoDao{
        if(instance == nil){
            instance = ContatoDao()
        }
        
        return instance
    }
    
    
    override private init() {
        self.contatos = Array()
    }
    
    
    /// Adiciona à listagem de contatos um novo contato
    ///
    /// - Parameters:
    ///   - contato: contato a ser adicionado
    func addContato(_ contato:Contato){
        contatos.append(contato)
    }
    
    func removeAt(position:Int){
        contatos.remove(at: position)
    }
    
    
    /// Retorna a listagem de contatos
    ///
    /// - Returns: contatos salvos no singleton
    func getContatos()->Array<Contato>{
        print(contatos.count)
        return contatos
    }
    
    
    /// Pega um contato pelo nome
    ///
    /// - Parameter position: nome do contato a ser pego
    func getContatoAt(position:Int)-> Contato {
        return contatos[position]
    }
    
}
