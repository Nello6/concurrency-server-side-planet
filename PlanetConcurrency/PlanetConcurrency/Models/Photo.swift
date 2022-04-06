//
//  Photo.swift
//  PlanetConcurrency
//
//  Created by Antonio Iacono on 31/03/22.
//


import Foundation

struct Photo: Codable, Identifiable{
    let id : UUID
    let title : String
    let url : String
}
