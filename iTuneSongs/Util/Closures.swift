//
//  Closures.swift
//  DevoeQuakeLocator
//
//  Created by Dana Devoe on 5/11/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation

typealias Closure = () -> Void
typealias ClosureWithError = ( _ error: iTunesErrors ) -> Void
typealias ClosureWithBool = ( _ success: Bool ) -> Void
typealias ClosureWithiTunes = ( _ items: [iTunesItem] ) -> Void
typealias ClosureWithString = ( _ xml: String ) -> Void

