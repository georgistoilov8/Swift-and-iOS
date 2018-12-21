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
            cell.onErrorLabel.text = "Sorry. We need photos permission"
            cell.onErrorLabel.lineBreakMode = .byWordWrapping
            cell.onErrorLabel.numberOfLines = 0
            cell.settingsButton.text = "Settings"
            
            cell.settingsButton.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
            cell.settingsButton.addGestureRecognizer(gesture)
            // Don't why the text is not wrapping...
            return cell
        }
    }
    
    @objc func labelClicked(){
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
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
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Create the Activity Indicator
        
        // Add it to the view where you want it to appear
        view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        
        // Start the loading animation
        activityIndicator.startAnimating()
        
        // To remove it, just call removeFromSuperview()
        //activityIndicator.removeFromSuperview()
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
            self.activityIndicator.removeFromSuperview()
            self.tableView.reloadData()
        }
    }

    func showErrorCell() {
        DispatchQueue.main.async {
            self.activityIndicator.removeFromSuperview()
            self.tableView.reloadData()
        }
    }

}

