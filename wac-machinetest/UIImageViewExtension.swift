//
//  UIImageViewExtension.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//

import UIKit


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView{
    
    func loadImageUrl(urlString: String) {
        let imageUrl = urlString
        
        let url = URL(string: urlString)
        if url == nil{
            return
        }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                if  imageToCache == nil {
                    self.image = UIImage(systemName: "photo")
                    return
                }
                
                if imageUrl == urlString {
                    self.image = imageToCache
                }
                if let cacheImage:UIImage = imageToCache{
                    imageCache.setObject(cacheImage, forKey: urlString as NSString)
                }
            }
        }.resume()
    }
    
    func makeRoundCorner(_ radius:CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
}
