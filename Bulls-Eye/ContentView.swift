//
//  ContentView.swift
//  Bulls-Eye
//
//  Created by Randy Efan Jayaputra on 19/05/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isTapButton = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            Spacer()
            //Target View
            HStack {
                Text("Put the bullseye as close as you can to: ")
                Text("\(target).")
            }
            Spacer()
            
            //Slider View
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            
            //Hit Me View
            Button(action: {
                self.isTapButton = true
            }) {
                Text("Hit Me")
            }
            .alert(isPresented: $isTapButton) { () -> Alert in
                return Alert(title: Text("Hello There"), message: Text("The value you get is \(sliderValueRounded())\n" +
                    "You scored \(getPointforRound()) in this round"
                ), dismissButton: .default(Text("Keluar")))
            }
            Spacer()
            
            //Score View
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score: ")
                Text("999999")
                Spacer()
                Text("Round: ")
                Text("999")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            } .padding(.bottom, 30)
        }
    }
    
    func sliderValueRounded() -> Int {
         Int(sliderValue.rounded())
    }
    
    func getPointforRound() -> Int {
         100 - abs(target-sliderValueRounded())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
