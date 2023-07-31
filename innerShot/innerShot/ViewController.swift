//
//  ViewController.swift
//  innerShot
//
//  Created by Meet Shingala on 22/07/23.
//

import UIKit
import Photos


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: BTNEvents
    @IBAction func btnTakeScreenshot(_ sender: Any) {
        takeScreenshotAndSave()
    }
    
    //MARK: Functions
    func takeScreenshotAndSave() {
        
        guard let view = UIApplication.shared.windows.first?.rootViewController?.view else {
            return
        }
        
        // Create an image renderer
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        
        // Render the view into an image
        let screenshotImage = renderer.image { context in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        // Save the screenshot to the Photos library
        UIImageWriteToSavedPhotosAlbum(screenshotImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}

extension ViewController {
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        if let error = error {
            // Handle error saving the image
            showToast(message: "Error saving image: \(error.localizedDescription)")
        } else {
            // Image saved successfully
            showToast(message: "ScreenShot Taken")
        }
    }
    
    func showToast(message: String) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        UIApplication.shared.keyWindow?.rootViewController?.present(toast, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                toast.dismiss(animated: true)
            }
        })
    }
}
