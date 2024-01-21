//
//  UIImageView+Extension.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import UIKit

extension UIImageView {
    func load(from urlString: String) {
        // 이미지 캐시 확인
        let cacheKey = NSString(string: urlString)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        // 이미지 로딩 및 캐싱
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                        self?.image = image
                    }
                }
            }
            
            task.resume()
        }
    }
}

