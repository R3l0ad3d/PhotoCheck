//
//  ViewController.swift
//  PhotoCheck
//
//  Created by Solution Cat Sadik on 17/8/20.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var ivBottom: UIImageView!
    @IBOutlet weak var ivTop: UIImageView!
    
    var isTop : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else { return }
            
            // Use PHPhotoLibrary.shared().performChanges(...) to add assets.
        }

        
    }
    @IBAction func compareImage(_ sender: Any) {
        if let top = ivTop.image,let bottom = ivBottom.image{
            if top.pngData() == bottom.pngData(){
                print("image are equal")
            }else {
                print("image are not equal")
            }
        }
    }
    @IBAction func saveImage(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(ivTop.image!, self, #selector(saveError), nil)
    }
    
    @IBAction func topGalleryOpen(_ sender: Any) {
        isTop = true
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true) {
            
        }
    }
    @IBAction func bottomGalleryOpen(_ sender: Any) {
        isTop = false
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true) {
            
        }
    }
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        // save complete
        print("save")
    }
}

extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = (info[.originalImage] as? UIImage){
            if isTop{
                ivTop.image = img
            }else{
                ivBottom.image = img
            }
            let imagedata = img.jpegData(compressionQuality: 1)
            let source: CGImageSource = CGImageSourceCreateWithData(imagedata! as CFData, nil)!
            if let dictionary = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) {
                if let dic = dictionary as? [String:AnyObject]{
                    for (key,item) in dic.enumerated(){
                        print(key,item.value)
                    }
                }
            }
            
            
            
        }
        picker.dismiss(animated: true) {
            
        }
    }
    
}
