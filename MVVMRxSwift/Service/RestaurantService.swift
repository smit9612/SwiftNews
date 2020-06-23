//
//  RestaurantService.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import RxSwift

protocol RestaurantServiceProtocol {

    func fetchRestaurant() -> Observable<[Restaurant]>
    
}

final class RestaurantService: RestaurantServiceProtocol {
    

    func fetchRestaurant() -> Observable<[Restaurant]> {
        return Observable.create { observer -> Disposable in
            // If URL
//            let task = URLSession.shared.dataTask(with: URL(string: "url-here")!) { data, _, _ in
//                guard let data = data else {
//                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
//                    return
//                }
//
//                do {
//                    let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
//                    observer.onNext(restaurants)
//                } catch {
//                    observer.onError(error)
//                }
//            }
//
//            task.resume()
//            return Disposables.create {
//                task.cancel()
//            }

            // If Usin Mock Data
            guard let path = Bundle.main.path(forResource: "restaurants", ofType: "json") else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create()
            }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
                observer.onNext(restaurants)
            } catch {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }
}
