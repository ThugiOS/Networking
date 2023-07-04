//
//  ContentView.swift
//  Networking
//
//  Created by Никитин Артем on 3.07.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var user: UserResaults.User?
    
    var body: some View {
        HStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 80.0, height: 80.0)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading) {
                Text("\(user?.name.first ?? "Name") \(user?.name.last ?? "")")
                    .bold()
                    .foregroundColor(.indigo)
                    .italic()
                    .font(.title2)
                Text("\(user?.email ?? "")")
                Text("Пол: \(user?.gender ?? "")")
            }
        }
        .onAppear {
            Task {
                let result = try await
                NetworkServiceWithAsync.shared.fetchData()
                self.user = result.results[0]
            }
            
//            NetworkServiseWithAlamofire.shared.fetchData { result in
//                switch result {
//                case .success(let userResult):
//                    let user = userResult.results[0]
//                    self.user = user
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
