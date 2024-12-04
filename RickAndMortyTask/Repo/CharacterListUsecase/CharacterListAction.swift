//
//  CharacterListAction.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation

enum CharacterListAction: NetworkAction {
    
    case characterList(page:Int,status:String?)
   
    var path: String {
        switch self {
        case .characterList:
            return "character"
        }
    }

    var parameters: [String: AnyHashable]? {
        switch self {
        default:
            return nil
        }
    }

    var headers: [String: String] {
        
        switch self {
        default:
            return [:]
        }
    }
    
    var urlParameters: [String: AnyHashable]? {
        switch self {
        case let  .characterList(page, status):
            var params: [String: AnyHashable] = [
                "page": page
            ]
            if let status = status {
                params["status"] = status
            }
            return params
        }
    }
}
