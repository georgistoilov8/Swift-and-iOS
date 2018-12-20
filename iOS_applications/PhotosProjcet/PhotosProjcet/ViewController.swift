//
//  ViewController.swift
//  PhotosProjcet
//
//  Created by Georgi Stoilov on 20.12.18.
//  Copyright © 2018 Georgi Stoilov. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var size: CGSize{ return CGSize(width: tableView.frame.width, height: tableView.frame.width*3/4)}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized{
            print("Hello")
            return photos.count
        } else {
            print("World!")
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell")! as! ImageCell
            PHCachingImageManager.default().requestImage(for: photos[indexPath.row], targetSize: size, contentMode: .aspectFill, options: nil) { (image, _) in
                cell.photoCellView.image = image
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell")! as! ErrorCell
            cell.onErrorLabel.text = "Sorry. You need to give us permission to use your photos."
            cell.onErrorLabel.lineBreakMode = .byWordWrapping
            cell.onErrorLabel.numberOfLines = 0
            cell.settingsButton.text = "Settings"
            // Don't why the text is not wrapping...
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return size.height
    }
    
    @IBOutlet weak var tableView: UITableView!
    var photos = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //checkStatus()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        checkStatus()
    }
    
    func checkStatus(){
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .denied:
            print("You don't have permission")
            showErrorCell()
        case .authorized:
            print("You have permission to use photos")
            getImages()
        case .notDetermined:
            print("Status not determined")
            PHPhotoLibrary.requestAuthorization { (newStatus) in
                if(newStatus == .denied){
                    print("You don't have permission again")
                    self.showErrorCell()
                }else if(newStatus == .authorized){
                    print("You have access.")
                    self.getImages()
                }
            }
        default:
            print("Undefined.")
            showErrorCell()
        }
        
    }
    
    func getImages(){
        PHAsset.fetchAssets(with: nil).enumerateObjects { (asset, _, _) in
            if self.photos.count < 3 {
                self.photos.append(asset)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showErrorCell() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

