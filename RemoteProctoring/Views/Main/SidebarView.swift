//
//  SidebarView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 06/08/2022.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            NavigationLink {
                MainContentView()
                    .navigationTitle("Home")
            } label: {
                Label {
                    Text("Home")
                        .allowsTightening(true)
                } icon: {
                    Image(systemName: "house")
                        .symbolVariant(.fill)
                        .symbolRenderingMode(.multicolor)
                }
            }
            Section("People") {
                NavigationLink {
                    ExamineesView()
                        .navigationTitle("Examinees")
                } label: {
                    Label {
                        Text("Examinees")
                            .allowsTightening(true)
                    } icon: {
                        Image(systemName: "person")
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                    }
                }
                NavigationLink {
                    ExamineesView()
                        .navigationTitle("Proctors")
                } label: {
                    Label {
                        Text("Proctors")
                            .allowsTightening(true)
                    } icon: {
                        Image(systemName: "person")
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                    }
                }
                
            }
            Section("Exam") {
                NavigationLink {
                    ExamineesView()
                        .navigationTitle("Exams")
                } label: {
                    Label {
                        Text("Exams")
                            .allowsTightening(true)
                    } icon: {
                        Image(systemName: "folder")
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                    }
                }
                NavigationLink {
                    ExamineesView()
                        .navigationTitle("Exams")
                } label: {
                    Label {
                        Text("Exam Groups")
                            .allowsTightening(true)
                    } icon: {
                        Image(systemName: "folder")
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                    }
                }
            }
            Spacer()
            NavigationLink {
                    ExamineesView()
                        .navigationTitle("Exams")
                } label: {
                    Label {
                        Text("Chat")
                            .allowsTightening(true)
                    } icon: {
                        Image(systemName: "bolt.horizontal")
                            .symbolVariant(.circle)
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                    .imageScale(.large)
                    .foregroundColor(.blue)
                    }
            }
            NavigationLink {
                    ExamineesView()
                        .navigationTitle("Exams")
                } label: {
                    Label {
                        Text("Activity")
                            .allowsTightening(true)
                    } icon: {
                        Image(systemName: "timelapse")
                            .imageScale(.large)
                            .foregroundColor(.indigo)
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                    }
            }
            NavigationLink {
                    ExamineesView()
                        .navigationTitle("Exams")
                } label: {
                    Label {
                        Text("Settings")
                            .allowsTightening(true)
                    } icon: {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                    }
            }
        }
        .listStyle(.sidebar)
        .padding([.top, .bottom])
        Spacer()
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
