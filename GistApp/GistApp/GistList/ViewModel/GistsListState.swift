//
//  GistsListState.swift
//  GistApp
//
//  Created by nastasya on 27.09.2024.
//

struct GistsListState {
    var status: Status
    
    enum Status {
        case loading
        case loaded([GistMainInformation])
        case error
    }
}
