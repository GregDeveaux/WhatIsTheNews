//
//  New.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import Foundation

struct New: Codable {
    let title: String
    let urlToImage: String?
    let description: String
    let url: String
    let author: String?
    let source: Source
    let publishedAt: String
}

extension New {
    static let examples = [
        New(title: "Les joueuses jamaïcaines veulent faire pression sur la fédération",
             urlToImage: "https://sofoot.s3.eu-central-1.amazonaws.com/wp-content/uploads/2023/07/28111756/6171886-hd-1400x933.jpg",
             description: "La qualif pour fermer les bouches. Lister les sélections qualifiées pour la Coupe du monde féminine qui ont subi de…",
             url: "https://www.sofoot.com/breves/les-joueuses-jamaicaines-veulent-faire-pression-sur-la-federation",
             author: "Arthur CHARLIER",
             source: .init(name: "SO FOOT"),
             publishedAt: "2023-07-28T09:18:16Z"),
        New(title: "Angleterre - Danemark EN DIRECT",
             urlToImage: "https://dnl.eurosport.com/sd/img/orosport.jpg",
             description: "Eurosport est votre source privilégiée pour les dernières mises à jour des matches de Coupe du monde féminine. Obtenez le résumé complet du Angleterre - Danemark, avec les statistiques et les temps forts.",
             url: "https://www.eurosport.fr/football/coupe-du-monde-feminine/2023/live-angleterre-danemark_mtc1402991/live.shtml",
             author: nil,
             source: .init(name: "Eurosport.fr"),
             publishedAt: "2023-07-28T08:25:39Z"),
        New(title: "Pronostic Panama Jamaïque : Analyse, cotes et prono du match de la Coupe du monde féminine",
             urlToImage: "https://sofoot.s3.eu-central-1.amazonaws.com/wp-content/uploads/2023/07/27152841/pronostic-jamaique-1400x933.jpg",
             description: "La Jamaïque peut y croire Quelques heures après le choc entre la France et le Brésil, les deux outsiders de ce…",
             url: "https://www.sofoot.com/breves/pronostic-panama-jamaique-analyse-cotes-et-prono-du-match-de-la-coupe-du-monde-feminine",
             author: "Yann FERNANDEZ",
             source: .init(name: "SO FOOT"),
             publishedAt: "2023-07-28T08:15:53Z"),
        New(title: "Coupe du monde féminine : pour Haïti, un premier Mondial grâce à une génération née dans les ruines",
             urlToImage: "https://img.lemde.fr/2023/07/22/0/1/3954/2636/1440/960/60/0/6e4e01e_3404a424ee5445a3ae9bbe9c3a378fa4-0-7824b0580ed64995bccabccca0fc32ec.jpg",
             description: "Porté par une équipe dont l’émergence est toutefois menacée par la situation économique et sécuritaire du pays, Haïti a su rivaliser lors de son match contre l’Angleterre. Le pays affronte la Chine, vendredi 28 juillet, à 13 h 30 (heure de Paris).",
             url: "https://www.lemonde.fr/sport/article/2023/07/28/coupe-du-monde-feminine-pour-haiti-un-premier-mondial-grace-a-une-generation-nee-dans-les-ruines_6183684_3242.html",
             author: "Denis Ménétrier",
             source: .init(name: "Le Monde"),
             publishedAt: "2023-07-28T07:07:10Z"),
    ]
}

extension New: Identifiable {
    var id: UUID { return UUID() }
}
