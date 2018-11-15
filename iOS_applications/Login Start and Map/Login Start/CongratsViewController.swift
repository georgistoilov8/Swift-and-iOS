//
//  CongratsViewController.swift
//  Login Start
//
//  Created by Spas Bilyarski on 18.10.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit

final class CongratsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var username : String?
    var password : String?
    
    var locationModel : LocationModel?
    func setLabels(user : String, pass: String){
        username = user
        password = pass
    }
    
    override func viewDidLoad() {
        usernameLabel.text = username
        passwordLabel.text = password
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationModel = LocationModel()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // Задача 6: При всяко отваряне на CongratsViewController трябва да направите нова инстанция на LocationModel.
    
    // Задача 7: Бутонът "затваряне" трябва да извиква метода dismiss(_:), който ще затвори екрана.
    
    @IBAction func setMap(_ sender: Any) {
        if locationModel == nil {
            locationModel = LocationModel()
        }
        let mapController = MapViewController.init(nibName: "MapViewController", bundle: nil)
        mapController.locationModel = locationModel
        navigationController?.pushViewController(mapController, animated: true)
    }
    // Задача 8: Бутонът "напред" трабва да създаде програматично инстанция на MapViewController от nib файла. Също така трябва да му подадете вече създаденият LocationModel.
    
    override func didReceiveMemoryWarning() {
        locationModel = nil
    }
    
    // Задача 9: Ако получите известие, че паметта намалява освободете структората LocationModel и я създайте наново, ако потребителят натисне бутонът "напред".

}
