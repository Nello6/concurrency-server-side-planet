//
//  File.swift
//
//
//  Created by Aniello Ambrosio on 23/03/22.
//

import Foundation
import Fluent
import Vapor

final class Planet: Model,Content{
    static let schema = "planets"
    
//    @ID(custom: "id", generatedBy: .database)
//    var id: Int?
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "url")
    var url: String
    
    init(){}
    
    init(id: UUID? = nil, title: String, url: String){
        self.id=id
        self.title=title
        self.url=url
    }
    
}
