//
//  ImageLoader.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

protocol ImageCaching {
    func saveImagetoCache(image: UIImage?, url: URL)
    
    func imageFromCachedWithUrl(url: URL) -> UIImage?
}

final class ImageCache: ImageCaching {
    
    var cachedDictionary = Dictionary <String, UIImage>()
    
    func saveImagetoCache(image: UIImage?, url: URL) {
        if let image = image {
            cachedDictionary[url.absoluteString] = image
        }
    }
    
    func imageFromCachedWithUrl(url: URL) -> UIImage? {
        return cachedDictionary[url.absoluteString]
    }
}

protocol ImageLoaderProtocol {
    
    func loadImage(url: URL) -> Observable<UIImage?>
}

final class ImageLoader: ImageLoaderProtocol, ManagerInjected {
    
    func loadImage(url: URL) -> Observable<UIImage?> {
        NetworkService.shared.executeBinaryRequest(url: url)
    }
}
