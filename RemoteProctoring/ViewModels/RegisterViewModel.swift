//
//  RegisterViewModel.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import Navajo_Swift
import SwiftUI
import RemoteProctoringBackend
import RemoteProctoringModel
import Apollo

extension RegisterView {
    
func validateEmail(_ emailAddress: String) {
        withAnimation {
#if os(iOS)
            if let match = emailAddress.firstMatch(of: emailPattern) {
                let (wholeMatch, _, _) = match.output
                self.emailAddress = String(wholeMatch)
                self.emailAddressValid = true
            }
            else {
                self.emailAddressValid = false
            }
#else
            if emailPattern.firstMatch(in: emailAddress, options: [], range: NSRange(location: 0, length: emailAddress.count)) != nil {
                // TODO: Use matched value from NSTextCheckingResult
                self.emailAddressValid = true
            }
            else {
                self.emailAddressValid = false
            }
#endif
        }
    }
    
    func onPasswordChange(_ newPassword: String) {
        withAnimation {
            if passwordValdator.validate(newPassword) != nil {
                passwordValid = false
            }
            else {
                passwordValid = true
            }
        }
        calculatePasswordStrengthProgress(password: newPassword)
    }
    
    func onRepeatPasswordChange(_ newRepeatPassword: String) {
        withAnimation {
            if password != newRepeatPassword {
                passwordsMatch = false
            }
            else {
                passwordsMatch = true
            }
        }
    }
    
    func handleRegisteration() {
        guard !username.isEmpty else {
            focusedField = .usernameField
            return
        }
        guard !password.isEmpty else {
            focusedField = .passwordField
            return
        }
        guard !repeatPassword.isEmpty else {
            focusedField = .repeatPasswordField
            return
        }
        guard !givenName.isEmpty else {
            focusedField = .givenNameField
            return
        }
        guard !emailAddress.isEmpty else {
            focusedField = .emailAddressField
            return
        }
        guard !organization.isEmpty else {
            focusedField = .organizationField
            return
        }
        guard passwordValid else {
            focusedField = .passwordField
            return
        }
        guard emailAddressValid else {
            focusedField = .emailAddressField
            return
        }
        withAnimation {
            registerPressed = true
            recievedError = false
        }
        
        errorMessages.removeAll()
        
        let inputUser = UserRegisterationInput(
            username: username,
            password: password,
            role: role,
            prefix: prefix,
            givenName: givenName,
            middleName: middleName,
            lastName: lastName,
            email: emailAddress,
            organization: organization)
        
        GraphqlClient.shared.client.perform(
            mutation: RegisterMutation(user: inputUser))
        { res in
            registerPressed = false
            switch res {
            case .success(let gqRes):
                if let errors = gqRes.errors {
                    errorMessages.append("Error occurred while connecting to server, Please try again.")
#if DEBUG
                    for error in errors {
                        if let failureReason = error.failureReason {
                            errorMessages.append(failureReason)
                        }
                        else {
                            errorMessages.append(error.description)
                        }
                    }
#endif
                    withAnimation {
                        recievedError = true
                    }
                }
                if let data = gqRes.data {
                    guard let queryResponse = data.register.queryResponse else {
                        #if DEBUG
                        errorMessages.append(contentsOf: data.register.resultMap.values.compactMap {$0.debugDescription})
                        #endif
                        errorMessages.append("Unknown error occurred, Please try again.")
                        withAnimation {
                            recievedError = true
                        }
                        return
                    }
                    switch queryResponse.code {
                    case 200:
                        guard let recievedUser = data.register.user else {
                            errorMessages.append("Uknown error occured, Please try again.")
                            break
                        }
                        user.data.raw = recievedUser.fragments.userDetails
                        withAnimation {
                            SecureStore.shared.token = data.register.token
                        }
                        return
                    case 400:
                        errorMessages.append(contentsOf: queryResponse.message.split(separator: "\n").map { substr in String(substr) })
                    case 500:
                        errorMessages.append("Server error occurred. Please try again later.")
                    default:
                        errorMessages.append(queryResponse.message)
                    }
                    withAnimation {
                        recievedError = true
                    }
                }
            case .failure(let error):
                errorMessages.append("Error occurred while connecting to server, Please try again.")
#if DEBUG
                errorMessages.append(error.localizedDescription)
#endif
                withAnimation {
                    recievedError = true
                }
            }
        }
    }
    
    func calculatePasswordStrengthProgress(password: String) {
        let passwordStrength = Navajo.strength(ofPassword: password)
        withAnimation {
            switch passwordStrength {
            case .veryWeak:
                passwordStrengthProgress = 0
                passwordStrengthColor = .red
            case .weak:
                passwordStrengthProgress = 20
                passwordStrengthColor = .red
            case .reasonable:
                passwordStrengthProgress = 40
                passwordStrengthColor = .yellow
            case .strong:
                passwordStrengthProgress = 60
                passwordStrengthColor = .green
            case .veryStrong:
                passwordStrengthProgress = 80
                passwordStrengthColor = .green
            }
        }
    }
}
