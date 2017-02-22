//
//  LongPressActionManager.swift
//  swiftTranning
//
//  Created by Thaciana Soares Goes de Lima on 21/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import Foundation
import UIKit

class LongPressActionManager:NSObject{
    let contato:Contato
    var controller:UIViewController!
    
    init(withContato contato:Contato, andController controller:UIViewController) {
        self.contato = contato
        self.controller = controller
    }
    
    func defineActions(){
        let alertController:UIAlertController = UIAlertController(title: contato.name, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        let device:UIDevice = UIDevice.current;
        if(device.model == "iPhone"){
            let call = UIAlertAction(title: "Ligar", style: .default) { (action) in
                self.call()
            }
            alertController.addAction(call)
        }
        
        let openSite = UIAlertAction(title: "Visualizar Site", style: .default){(action) in
            self.openSite();
        }
        
        let openMap = UIAlertAction(title: "Ver no Mapa", style: .default){(action) in
            self.openMap();
        }
        
        alertController.addAction(cancel)
        alertController.addAction(openSite)
        alertController.addAction(openMap)
        
        self.controller.present(alertController, animated: true, completion: nil)
        
    }
    
    func call(){
        var callUrl = contato.phone
        callUrl = "tel://"+callUrl!
        openApp(withUrl: callUrl!)
    }
    
    func openSite(){
        var siteUrl = contato.site
        if !(siteUrl?.hasPrefix("http://"))!{
            siteUrl = "http://"+siteUrl!
        }
        openApp(withUrl: siteUrl!)
    }
    
    func openMap(){
        var mapUrl = contato.address
        mapUrl = "https://maps.apple.com/?q="+(mapUrl?.replacingOccurrences(of: " ", with: "+", options: .literal))!
        openApp(withUrl: mapUrl!)
    }
    
    private func openApp(withUrl url:String){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(URL(string: url)!)
        }
    }
}
