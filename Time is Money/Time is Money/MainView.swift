//
//  ContentView.swift
//  Time is Money
//
//  Created by Victor S Melo on 10/10/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var value: String = "R$ 100,00"
    var body: some View {
        VStack {
            
            //header
            Text("Você terá que trabalhar")
                .padding(.top, 120)
            Text("2 horas")
            Text("para pagar estes R$ 200,00")
            // image
            Image("table0")
                .padding(.top,36)
            // input
            Spacer()
            TextField("", text: $value)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(width: nil, height: 100, alignment: .center)
                .background(Color(.sRGB, red: 94/255.0, green: 128/255.0, blue: 142/255.0, opacity: 1))
        }
        .background(Color(.sRGB, red: 255/255.0, green: 254/255.0, blue: 240/255.0, opacity: 1))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
