//
//  AddBandView.swift
//  istamusic
//
//  Created by Mariniello Umberto on 15/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddBandView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bandName: UITextField!
    @IBOutlet weak var musicalGenre: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var informations: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bandName.layer.borderColor = UIColor.lightGray.cgColor
        self.bandName.layer.borderWidth = 1.0
        self.bandName.layer.cornerRadius = 8
        self.musicalGenre.layer.borderColor = UIColor.lightGray.cgColor
        self.musicalGenre.layer.borderWidth = 1.0
        self.musicalGenre.layer.cornerRadius = 8
        self.location.layer.borderColor = UIColor.lightGray.cgColor
        self.location.layer.borderWidth = 1.0
        self.location.layer.cornerRadius = 8
        self.informations.layer.borderColor = UIColor.lightGray.cgColor
        self.informations.layer.borderWidth = 1.0
        self.informations.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
        print(dataBaseShared.bands.count)
        //dataBaseShared.bands.remove(at: dataBaseShared.bands.count - 1)

    }
    
    // Load image button
    @IBAction func load(_ sender: Any) {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.allowsEditing = false
        let alert: UIAlertController = UIAlertController(title: "Select Image from ...", message: nil, preferredStyle: .actionSheet)
        present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in self.gallery(picker)}))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in self.camera(picker)}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in self.imagePickerControllerDidCancel(picker)}))
    }
    
    // Select image from device gallery
    func gallery(_ picker: UIImagePickerController) {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // Select image from device camera
    func camera(_ picker: UIImagePickerController) {
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // Picker image delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected an image, but was provided the following error: \(info)")
        }
        image.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func entityIsEmpty(entity: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var count = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            let results:NSArray? = try context.fetch(request) as NSArray
        } catch {
            print("ERROR")
        }
        do {
            count = try context.count(for: request)
        } catch {
            print("ERROR2")
        }
        if count == 0
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func visualizzaAlertOk(){
        let alert = UIAlertController(title: "AGIIUNTA BAND", message: "Hai aggiunto la band con successo", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    

    // Cancel button in device gallery view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Cancel button to move to previous view
    @IBAction func cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        let newBand = Band()
        newBand.nomeGruppo = bandName.text
        newBand.image = bandName.text
        newBand.genereMusicale = musicalGenre.text
        newBand.location = location.text
        newBand.descrizione = informations.text
        dataBaseShared.addNewBand(newBand: newBand)

        if (entityIsEmpty(entity: "Image")) {
            print("TRUE")
        }
        else {
            print("FALSE")
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Image", in: context)
        let newImage = NSManagedObject(entity: entity!, insertInto: context)
        let imageData = NSData(data: image.image!.pngData()!)
        
        newImage.setValue(bandName.text, forKey: "name")
        newImage.setValue(imageData, forKey: "data")
        
        
        if (entityIsEmpty(entity: "Image")) {
            print("TRUE")
        }
        else {
            print("FALSE")
        }
        
        visualizzaAlertOk()
    }
}
