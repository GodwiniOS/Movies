//
//  ImageViewEx.swift
//  Moviez
//
//  Created by Godwin  on 17/01/21.
//

import UIKit


extension UIImageView {
    
    func loadImageFrom(urlString: String) {

        
        
        var imageURLString: String?
        let url = URL(string: urlString)
        image = nil
        

        imageURLString = urlString
        let imagesCache = NSCache<NSString, AnyObject>()


        if let image = imagesCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        
        if let url = url {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        if imageURLString == urlString {
                            self.image = image
                        }
                        imagesCache.setObject(image, forKey: urlString as NSString)
                    }
                }
                }.resume()
        } else {
            print("URL Empty")
        }
    }
}
