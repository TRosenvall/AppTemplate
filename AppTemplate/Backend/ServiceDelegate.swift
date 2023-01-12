//
//  ServiceDelegate.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 1/12/23.
//

import Foundation

///------

protocol ServiceDelegate {
    func subscribe(_ object: ServiceResolvingBroadcaster)
}
