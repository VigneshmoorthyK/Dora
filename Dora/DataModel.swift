//
//  DataModel.swift
//  Dora
//
//  Created by Aravind on 16/03/24.
//

import Foundation
struct Product : Identifiable{
    let id: Int;
    let name : String;
    let location : String;
    let price : String;
    let image : String;
}

struct CreateUser : Codable {
    let name: String;
    let image_url: String;
    let mobile: String;
    let email: String;
    let password: String;
}

struct TokenResponse : Codable {
    let access_token : String;
    let refresh_token : String;
}

struct ErrorMsg : Codable{
    let msg : String;
    let type : String;
    let loc:[String]
}

struct EmailPassword : Codable{
    let email : String;
    let password : String;
}
struct Errors : Codable{
    let detail: String
}
