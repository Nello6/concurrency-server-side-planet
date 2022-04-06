//
//  File.swift
//
//
//  Created by Aniello Ambrosio on 23/03/22.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreatePlanet:Migration{
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("planets")
            .id()
            .field("title",.string)
            .field("url",.string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("planets")
            .delete()
    }
}
