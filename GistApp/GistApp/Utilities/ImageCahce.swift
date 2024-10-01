//
//  ImageCache.swift
//  GistApp
//
//  Created by nastasya on 29.09.2024.
//

import Foundation
import UIKit

struct ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
