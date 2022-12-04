//
//  SharedContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/4/22.
//

protocol Entity {}

protocol EntityController {
    func save(entity: Entity)

    func load(entity: Entity)
}

