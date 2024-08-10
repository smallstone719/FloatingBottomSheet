//
//  ContentView.swift
//  FloatingBottomSheet
//
//  Created by Nguyen Trong Thach on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlertSheet: Bool = false
    @State private var showQuestionSheet: Bool = false
    @State private var showRequestSheet: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                GroupBox {
                    HStack(spacing: 16) {
                        CustomButton(title: "Alert", backgroundColor: .red) {
                            showAlertSheet = true
                        }
                        
                        CustomButton(title: "Question", backgroundColor: .blue) {
                            showQuestionSheet = true
                        }
                        
                        CustomButton(title: "Request", backgroundColor: .green) {
                            showRequestSheet = true
                        }
                    }
                }.padding(.bottom, 200)
//                HStack(spacing: 16) {
//                    CustomButton(title: "Alert", backgroundColor: .red) {
//                        showAlertSheet = true
//                    }
//                    
//                    CustomButton(title: "Question", backgroundColor: .blue) {
//                        showQuestionSheet = true
//                    }
//                    
//                    CustomButton(title: "Request", backgroundColor: .green) {
//                        showRequestSheet = true
//                    }
//                }
//                .padding()
//                .background(.gray.gradient.opacity(0.2))
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .shadow(color: .black.opacity(0.1), radius: 15)
//                .padding(.bottom, 200)
            }
            .navigationTitle("Floating Bottom Sheets")
        }
        .floatingBottomSheet(isPresented: $showAlertSheet) {
            SheetView(
                title: "Ooops!",
                content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                image: .init(
                    content: "exclamationmark.triangle",
                    tint: .red,
                    foreground: .white
                ),
                button1: .init(
                    content: "Done",
                    tint: .red,
                    foreground: .white
                )
            )
            .presentationDetents([.height(260)])
            ///.presentationBackgroundInteraction(.enabled(upThrough: .height(330)))
        }
        .floatingBottomSheet(isPresented: $showQuestionSheet) {
            SheetView(
                title: "Replace Existing Folder?",
                content: "Are you sure you want to replace the existing folder?",
                image: .init(
                    content: "questionmark.folder.fill",
                    tint: .blue,
                    foreground: .white
                ),
                button1: .init(
                    content: "Replace",
                    tint: .blue,
                    foreground: .white
                ),
                button2: .init(
                    content: "Cancel",
                    tint: Color.primary.opacity(0.08),
                    foreground: Color.primary
                )
            )
            .presentationDetents([.height(330)])
            ///.presentationBackgroundInteraction(.enabled(upThrough: .height(330)))
        }
        .floatingBottomSheet(isPresented: $showRequestSheet) {
            SheetView(
                title: "Request from iJustine",
                content: "Do you really want to overwrite the current folder with this new one?",
                image: .init(
                    content: "person.fill.checkmark",
                    tint: .green,
                    foreground: .white
                ),
                button1: .init(
                    content: "Replace",
                    tint: .green,
                    foreground: .white
                ),
                button2: .init(
                    content: "Cancel",
                    tint: .red,
                    foreground: .white
                )
            )
            .presentationDetents([.height(330)])
            ///.presentationBackgroundInteraction(.enabled(upThrough: .height(330)))
        }
        
    }
}

struct CustomButton: View {
    var title: String
    var backgroundColor: Color
    var action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(10)
                .background(backgroundColor.gradient)
                .clipShape(.rect(cornerRadius: 10))
                .tint(.white)
                .fontWeight(.semibold)
        }
    }
}

/// Sampple View
struct SheetView: View {
    var title: String
    var content: String
    var image: Config
    var button1: Config
    var button2: Config?
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: image.content)
                .font(.title)
                .foregroundStyle(image.foreground)
                .frame(width: 65, height: 65)
                .background(image.tint.gradient, in: .circle)
            
            Text(title)
                .font(.title3.bold())
            Text(content)
                .font(.callout)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(.gray)
            
            ButtonView(button1)
            if let button2 {
                ButtonView(button2)
            }
        }
        .padding([.horizontal, .bottom], 15)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
                .padding(.top, 30)
        }
        ///.background(.background, in: .rect(cornerRadius: 15))
        
        .shadow(color: .black.opacity(0.12), radius: 8)
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func ButtonView(_ config: Config) -> some View {
        Button {
            
        } label: {
            Text(config.content)
                .fontWeight(.bold)
                .foregroundStyle(config.foreground)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(config.tint.gradient, in: .rect(cornerRadius: 10))
        }
        
    }
    
    struct Config {
        var content: String
        var tint: Color
        var foreground: Color
    }
}


#Preview {
    ContentView()
}
