import Fluent
import Vapor

func routes(_ app: Application) throws {
    //CRUD
    
    app.get("plan"){ req -> String in
        return """
[
  {
    "ciao": "aaaaa",
    "id": 1,
    "title": "Mercury",
    "url": "https://i.pinimg.com/originals/98/09/66/9809666c323d35c266117428dd495791.jpg",
  },
  {
    "ciao":"aaaa",
    "id": 2,
    "title": "Venus",
    "url": "https://www.astronomitaly.com/wp-content/uploads/2019/09/venere-pianeta.jpg",
  },
  {
    "id": 3,
    "title": "Earth",
    "url": "https://bloximages.newyork1.vip.townnews.com/dailyastorian.com/content/tncms/assets/v3/editorial/c/4a/c4a1620a-0d8f-5ceb-8daf-b18b61cf436b/5cbe3e694523e.image.jpg?resize=400%2C400",
  },
  {
    "id": 4,
    "title": "Mars",
    "url": "https://www.karmanews.it/wp-content/uploads/2021/01/Marte.jpg",
  },
  {
    "id": 5,
    "title": "Jupiter",
    "url": "https://d2pn8kiwq2w21t.cloudfront.net/images/jpegPIA00029.width-1024.jpg",
  },
  {
    "id": 6,
    "title": "Saturn",
    "url": "https://hd2.tudocdn.net/161140?w=610&h=487",
  },
  {
    "id": 7,
    "title": "Uranus",
    "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Uranus.jpg/600px-Uranus.jpg",
  },
  {
    "id": 8,
    "title": "Neptune",
    "url": "https://upload.wikimedia.org/wikipedia/commons/5/56/Neptune_Full.jpg",
  },
  {
    "id": 9,
    "title": "Pluto",
    "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Nh-pluto-in-true-color_2x.jpg/1200px-Nh-pluto-in-true-color_2x.jpg",
  },
  {
    "title": "Sun",
    "id": 0,
    "url": "https://www.technologyreview.it/_media/9663/image/Solar_Orbiter-EUI-PHI-FullSun.gif",
  }

]
"""
            
    }
    
    //get (/planets)
    app.get("planets"){ req -> EventLoopFuture<[Planet]> in
        return Planet.query(on: req.db).all()
    }
    
    //get by id (/planets/id)
    app.get("planets",":planetId"){ req -> EventLoopFuture<Planet> in
        Planet.find(req.parameters.get("planetId"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    //post (/planets)
    app.post("planets"){ req -> EventLoopFuture<Planet> in
        
        let planet = try req.content.decode(Planet.self)
        
        return planet.create(on: req.db).map{planet}
    }
    
    //put (/planets)
    app.put("planets"){ req -> EventLoopFuture<HTTPStatus> in
        
        let planet = try req.content.decode(Planet.self)
        
        return Planet.find(planet.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.title = planet.title
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    //delete (/planets/id)
    app.delete("planets",":planetsId"){ req -> EventLoopFuture<HTTPStatus> in
        
        Planet.find(req.parameters.get("planetsId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.delete(on: req.db)
            }.transform(to: .ok)
        
    }
    
}
