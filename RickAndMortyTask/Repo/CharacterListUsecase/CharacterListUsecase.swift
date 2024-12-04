//
//  CharacterListUsecase.swift
//  RickAndMortyTask
//
//  Created by Eslam Mohamed on 04/12/2024.
//

import Foundation



protocol CharacterListUseCaseProtocol {
    func getCharacterList(page: Int, status:String?) async throws -> CharacterListModel
}


public final class CharacterListUseCase: CharacterListUseCaseProtocol, HTTPClient {
    var pathProvider = PathProvider(environmentProvider: ApiSettings())
    func getCharacterList(page: Int, status: String?) async throws -> CharacterListModel {
        let request = CharacterListAction.characterList(page: page, status: status)
        guard let url = pathProvider.createURL(type: request) else {
            throw Error.notFoundUrl
        }

        let endPoint = RequestEndpoint(
            url: url,
            urlParameters: request.urlParameters,
            authorizationType: .none,
            method: .get,
            parameterEncoding: .queryString
        )
        
        do {
            let response = try await sendRequest(endPoint, model: CharacterListModel.self)
            return response
        } catch {
            throw error
        }
        
    }
}

