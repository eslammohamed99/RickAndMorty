//
//  CharacterInfo.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation

public struct PresentedDataViewModel {
    static let dummy = PresentedDataViewModel(model: .dummy)
    public var id: Int
    public var name: String
    public var image: String
    public var species: String
    public var status: RemoteFilterStatus
    public var gender: String
    public var location: LocationModel
    
    init(model: CharacterInfo) {
        self.id = model.id ?? 0
        self.name = model.name ?? ""
        self.image = model.image ?? ""
        self.species = model.species ?? ""
        self.status = model.status ?? .Alive
        self.gender = model.gender ?? ""
        self.location = model.location ?? LocationModel(name: "", url: "")
    }
}
public extension Array where Element == CharacterInfo {
    func toModels() -> [PresentedDataViewModel] {
        return self.map {
            PresentedDataViewModel(model: $0)
        }
    }
}


public struct PresentablePagination {
    public var paginationEnds: Bool
    
    public init(paginationEnds: Bool) {
        self.paginationEnds = paginationEnds
    }
}

public struct CharacterListModel: Codable {
    public let info: PaginationModel?
    public let results: [CharacterInfo]?
}

public struct PaginationModel: Codable {
    var pageCount: Int?
    var count: Int?
    var next: String?
    var pages: Int?
    var prev: String?
}

public struct CharacterInfo: Codable {
    static let dummy = CharacterInfo(
        gender: "",
        id: 0,
        image: "",
        location: LocationModel(name: "", url: ""),
        name: "",
        species: "",
        status: .Alive
    )
    
    var created: String?
    var episode: [String]?
    var gender: String?
    var id: Int?
    var image: String?
    var location: LocationModel?
    var name: String?
    var origin: Origin?
    var species: String?
    var status: RemoteFilterStatus?
    var type: String?
    var url: String?
}

public struct LocationModel: Codable {
    public let name: String
    public let url: String
}

public struct Origin: Codable {
    public let name: String
    public let url: String
}

public enum RemoteFilterStatus: String, Codable, CaseIterable {
    case Alive
    case Dead
    case unknown
}
