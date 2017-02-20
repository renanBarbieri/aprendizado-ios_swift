//
//  FormularioViewControllerDelegate.swift
//  swiftTranning
//
//  Created by Thaciana Soares Goes de Lima on 20/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import Foundation

protocol FormularioViewControllerDelegate {
    func addContatoDone(contato:Contato)
    func editContatoDone(contato:Contato)
}
