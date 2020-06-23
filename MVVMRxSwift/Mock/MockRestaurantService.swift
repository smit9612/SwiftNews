//
//  MockRestaurantService.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import RxSwift

final class MockResaurantService: RestaurantServiceProtocol {
    func fetchRestaurant() -> Observable<[Restaurant]> {
            return Observable.create { observer -> Disposable in
                // If Usin Mock Data
                guard let path = Bundle.main.path(forResource: "mockswiftnews", ofType: "json") else {
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
