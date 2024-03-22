//
//  ApiService.swift
//  Dora
//
//  Created by Aravind on 16/03/24.
//

import Foundation
enum APIType: String {
    case POST
    case GET
    case PUT
    case PATCH
    case DELETE
    
    var stringValue: String {
        return self.rawValue.uppercased()
    }
}
enum RequestError: Error {
    case invalidURL
}

class ApiService {
    private var baseUrl = "http://192.168.5.57:8007/"
    func createRequest<T>(url : String, type : APIType, data : T) throws -> URLRequest where T: Encodable{
        guard let apiUrl = URL(string: (baseUrl+url)) else {
            throw RequestError.invalidURL
        }
        var newRequest = URLRequest(url: apiUrl);
        newRequest.httpMethod = type.stringValue;
        newRequest.setValue("application/json", forHTTPHeaderField: "Content-Type");
        let jsonData = try? JSONSerialization.data(withJSONObject: data)
        newRequest.httpBody = jsonData
        return newRequest;
    }
    
    func login(email : String, password : String, onSuccess : @escaping(TokenResponse)->Void, onFailure : @escaping(String)->Void){
        let credential = ["email" : email , "password" : password];
        do {
            let loginRequest = try createRequest(url: "auth/token", type: .POST, data: credential)
            let task = URLSession.shared.dataTask(with: loginRequest){ data, response, error in
                if error != nil {
                    onFailure("Something went wrong")
                    return
                }
                guard let data = data else {
                    onFailure("No data found")
                    return
                }
                do {
                    let tokenData = try JSONDecoder().decode(TokenResponse.self, from: data)
                    onSuccess(tokenData)
                } catch {
                    onFailure("Invalid data")
                    return
                }
            }
            task.resume()
        } catch RequestError.invalidURL{
            onFailure("Invalid url")
        } catch{
            onFailure("Something went wrong!")
        }
    }
    
    func signUp(email : String, name: String, phoneNumber : String, password : String, onSuccess : @escaping(TokenResponse)->Void, onFailure: @escaping(String)->Void){
        let body = ["email" : email, "name" : name, "password" : password, "image_url": "image",
                    "mobile": phoneNumber]
        do{
            let singupRequest = try createRequest(url: "create_user", type: .POST, data: body);
            let task = URLSession.shared.dataTask(with: singupRequest){data,res,error in
                if error != nil {
                    onFailure("Something went wrong")
                    return
                }
                guard let data = data else {
                    onFailure("No data found")
                    return
                }
                do {
                    let errorData = try JSONDecoder().decode(Errors.self, from: data)
                    if(!errorData.detail.isEmpty){
                        onFailure(errorData.detail)
                        return
                    }
                } catch {}
                do {
                    let tokenData = try JSONDecoder().decode(TokenResponse.self, from: data)
                    onSuccess(tokenData)
                } catch {
                    onFailure("Invalid data")
                    return
                }
            }
            task.resume()
        }catch RequestError.invalidURL{
            onFailure("Invalid url")
        }catch{
            onFailure("Invalid data")
        }
        
    }
}
