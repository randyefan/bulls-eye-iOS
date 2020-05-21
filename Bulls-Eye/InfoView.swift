//
//  InfoView.swift
//  Bulls-Eye
//
//  Created by Randy Efan Jayaputra on 21/05/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    let backgroundColour = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct Heading: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 32))
                .foregroundColor(Color.black)
                .padding([.top, .bottom], 20)
        }
    }
    
    struct TextViews: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding([.leading, .trailing], 60)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
            Group {
            VStack {
                Text("🐃 Bulls Eye 🐃").modifier(Heading())
                Text("This is Bullseye, the game where you can earn points and earn fame by dragging a slider.").modifier(TextViews())
                Text("Your goal is to place the slider as clone as possible to the target value, the closer you are, the more point you score").modifier(TextViews())
                Text("Enjoy!").modifier(TextViews())
                
            }.navigationBarTitle("About")
            .background(backgroundColour)
        }.background(Image("Background"))
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().previewLayout(.fixed(width: 896, height: 414))
    }
}
