//
//  FormularioViewController.swift
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 15/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import UIKit
import CoreLocation

class FormularioViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoInput: UIButton!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var siteInput: UITextField!
    @IBOutlet weak var latText: UILabel!
    @IBOutlet weak var lngText: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var pinButton: UIButton!
    
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
            
            if contato.photo != nil {
                self.photoInput.setBackgroundImage(contato.photo, for: .normal)
                self.photoInput.setTitle(nil, for: .normal)
            }
            
            latText.text = contato.lat.description
            lngText.text = contato.lng.description
            
            
            // selector com parametro: #selector( metodo(_:param1:param2:) )
            let botaoAlterar: UIBarButtonItem = UIBarButtonItem( title: "Confirmar", style: .plain, target: self, action: #selector(updateContato) )
            self.navigationItem.rightBarButtonItem = botaoAlterar
            self.navigationItem.title = "Editar Contato"
            
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        findLocation(Void.self)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func selectPhoto2(_ sender: Any) {
        let pickerController:UIImagePickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //câmera disponível
            let alertController = UIAlertController(title: "Escolha a foto do contato", message: "Adicionar foto", preferredStyle: .actionSheet)
            
            let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            let tirarFoto: UIAlertAction = UIAlertAction(title: "Tirar Foto", style: .default){ (action) in
                pickerController.sourceType = .camera
                self.present(pickerController, animated: true, completion: nil)
        
            }
            
            let selecionarFoto: UIAlertAction = UIAlertAction(title: "Escolher da biblioteca", style: .default){(action) in
                pickerController.sourceType = .photoLibrary
                self.present(pickerController, animated: true, completion: nil)
                
            }
            
            alertController.addAction(cancelar)
            alertController.addAction(tirarFoto)
            alertController.addAction(selecionarFoto)
            self.present(alertController, animated: true, completion: nil)
            
           

        }
        else {
            //usar biblioteca
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
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
        
        if self.photoInput.backgroundImage(for: .normal) != nil {
            contato.photo = self.photoInput.backgroundImage(for: .normal)
        }
        
//        if(latText != nil){
//            contato.lat = Double(latText.text!)! as NSNumber!
//            contato.lng = NSNumber(value: Double(lngText.text!)! )
//        }
        
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
        let lat = latText.text
        let lng = lngText.text
        
        contato.updateValues(name, phone: phone, address: address, andSite: site)
        
        if self.photoInput.backgroundImage(for: .normal) != nil {
            contato.photo = self.photoInput.backgroundImage(for: .normal)
        }
        
        contato.lat = NSNumber(value: Double(lat!)! )
        contato.lng = NSNumber(value: Double(lng!)! )
        
        if self.delegate != nil {
            self.delegate?.editContatoDone(contato: contato)
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func findLocation(_ sender: Any) {
//        let callerButton = sender as! UIButton
//        callerButton.isHidden = true
        
        self.loadingView.isHidden = false
        self.pinButton.isHidden = true
        self.loadingView.startAnimating()
        
        let geocoder:CLGeocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(self.addressInput.text!) { (result, error) in
            
            if error == nil && (result?.count)! > 0 {
                let placemark:CLPlacemark = result![0]
                let coord: CLLocationCoordinate2D = (placemark.location?.coordinate)!
                
                self.latText.text = coord.latitude.description
                self.lngText.text = coord.longitude.description
                
            }
            self.loadingView.isHidden = true
            self.pinButton.isHidden = false
            self.loadingView.stopAnimating()
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageSelected: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.photoInput.setBackgroundImage(imageSelected, for: .normal)
        self.photoInput.setTitle(nil, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
    }
}
