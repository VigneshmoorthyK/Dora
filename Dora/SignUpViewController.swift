//
//  SignUpViewController.swift
//  Dora
//
//  Created by Aravind on 19/03/24.
//

import Foundation

class SignUpViewController : ObservableObject {
    @Published var errorMessage : String = "";
    @Published var showLoader : Bool = false;
    
    func handleSignUp(email : String, userName : String,phoneNumber : String, password : String,confirmPassword : String, termsAndPolicy : Bool,onSuccess : @escaping(TokenResponse)->Void, onFailure: @escaping(_ value: String) -> ()){
        if email.isEmpty{
            errorMessage = "Please enter email the address";
            onFailure(errorMessage)
            return
        }else if userName.isEmpty{
            errorMessage = "Please enter user the name";
            onFailure(errorMessage)
            return
        }else if phoneNumber.isEmpty{
            errorMessage = "Please enter phone the number";
            onFailure(errorMessage)
            return
        }else if password.isEmpty{
            errorMessage = "Please enter the password";
            onFailure(errorMessage)
            return
        }else if password != confirmPassword{
            errorMessage = "Password and confirm password should match";
            onFailure(errorMessage)
            return
        }else if !termsAndPolicy{
            errorMessage = "Please agree the terms and conditions";
            onFailure(errorMessage)
            return
        }else if phoneNumber.count != 10{
            errorMessage = "Please enter the valid phone number";
            onFailure(errorMessage)
            return
        }
        showLoader = true;
        let api = ApiService();
        api.signUp(email: email, name: userName,phoneNumber: phoneNumber, password: password,onSuccess: onSuccess){
            [weak self]error in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.errorMessage = error
            }
            onFailure(error);
        }
    }
}

