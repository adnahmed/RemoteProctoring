//
//  RegisterView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 30/06/2022.
//

import Neumorphic
import RemoteProctoringUI
import RemoteProctoringModel
import SwiftUI
import Navajo_Swift

struct RegisterView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State var username: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    @State var passwordStrength: PasswordStrength? = nil
    @State var passwordStrengthProgress: Float = 0.0
    @State var passwordStrengthColor: Color = .red
    @State var prefix: String = ""
    @State var givenName: String = ""
    @State var middleName: String = ""
    @State var lastName: String = ""
    @State var emailAddress: String = ""
    @State var organization: String = ""
    @State var showPasswordRules: Bool = false
    @State var passwordValid: Bool = false
    @State var passwordsMatch: Bool = true
    @State var usernameTaken: Bool = false
    @State var role: Role = .administrator
    @State var registerPressed: Bool = false
    @State var recievedError: Bool = false
    @State var emailAddressValid: Bool = false
    @State var errorMessages: [String] = []
    @EnvironmentObject var user: User
    @FocusState var focusedField: RegisterFormField?
    
    var body: some View {
        VStack {
            Label {
                Text("New Registeration")
                    .fontWeight(.thin)
                    .kerning(2.0)
                    .font(.largeTitle)
                    .padding([.top, .leading])
            } icon: {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 100, maxWidth: 100)
                    .background(RoundedRectangle(cornerRadius: 24.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            }
            Divider()
                .padding(.bottom)
            Picker(selection: $role, label: Text("Role")) {
                ForEach(Role.allCases, id: \.self) { role in
                    Text(role.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            Form {
                Section(header: Text("Authentication").foregroundStyle(.secondary)) {
                    TextField("Username", text: $username)
                        .noSideEffects()
                        .focused($focusedField, equals: .usernameField)
                    SecureField("Password", text: $password)
                        .noSideEffects()
                        .focused($focusedField, equals: .passwordField)
                        .onChange(of: password) { newPassword in
                            onPasswordChange(newPassword)
                        }
                        .overlay {
                            HStack {
                                Spacer()
                                if password.isEmpty {
                                    InfoButton(showInfo: $showPasswordRules)
                                        .padding(.trailing)
                                        .frame(minHeight: 20)
                                }
                                else {
                                    TickCross(value: $passwordValid)
                                        .padding(.trailing)
                                        .frame(minHeight: 20)
                                }
                            }
                        }
                    if showPasswordRules {
                        InfoView(
                            InfoText: .constant("Must contain atleast one uppercase letter, one lowercase letter, one digit and one symbol (i.e. %, @, $ etc.)."),
                            showInfo: $showPasswordRules)
                            .frame(minHeight: 50)
                    }
                    ProgressView(value: passwordStrengthProgress, total: 80) {
                        Text("Password Strength")
                            .foregroundStyle(.secondary)
                            .font(.caption2)
                    }
                    .tint(passwordStrengthColor)
                    SecureField("Repeat Password", text: $repeatPassword)
                        .noSideEffects()
                        .focused($focusedField, equals: .repeatPasswordField)
                        .overlay {
                            if !repeatPassword.isEmpty {
                                HStack {
                                    Spacer()
                                    TickCross(value: $passwordsMatch)
                                        .padding(.trailing)
                                }
                            }
                        }
                        .onChange(of: repeatPassword) { newRepeatPassword in
                            onRepeatPasswordChange(newRepeatPassword)
                        }
                }
                Section(header: Text("Information").foregroundStyle(.secondary)) {
                    TextField("Prefix", text: $prefix)
                        .textFieldStyle(.roundedBorder)
                    TextField("Given Name", text: $givenName)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusedField, equals: .givenNameField)
                    Group {
                        TextField("Middle Name", text: $middleName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Last Name", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Email Address", text: $emailAddress)
                            .noSideEffects()
                            .foregroundColor(!emailAddressValid && !emailAddress.isEmpty ? .red : colorScheme == .light ? .black : .white)
                            .focused($focusedField, equals: .emailAddressField)
                            .onChange(of: emailAddress) { newEmailAddress in
                                validateEmail(newEmailAddress)
                            }
                        TextField("Organization", text: $organization)
                            .focused($focusedField, equals: .organizationField)
                            .textFieldStyle(.roundedBorder)
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            Button(action: handleRegisteration) {
                Text("Register")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            .padding()
            if registerPressed {
                ProgressView()
                    .controlSize(.large)
                    .padding()
            }
            if recievedError {
                ErrorMessagesView(errorMessages: $errorMessages, recievedError: $recievedError)
            }
        }
        .frame(minWidth: 640, maxWidth: 640, minHeight: 750, maxHeight: 900)
        .onAppear {
            focusedField = .usernameField
        }
        .padding()
        .eraseToAnyView()
    }
    
#if DEBUG
    @ObservedObject var iO = injectionObserver
#endif
}

#if DEBUG
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
#endif
