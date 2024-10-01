//
//  GistDetailState.swift
//  GistApp
//
//  Created by nastasya on 29.09.2024.
//

struct GistDetailState {
    var status: Status
    
    enum Status {
        case loading
        case loaded(Gist)
        case error
    }
}
