//
//  CharacterView.swift
//  BBQuotes
//
//  Created by वैभव उपाध्याय on 24/11/25.
//
import SwiftUI

struct CharacterView: View {
    let character: MovieCharacter
    let show: String
    
    var body: some View {
        GeometryReader { geometryReader in
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    Image(show.removeCaseAndSpace)
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView(showsIndicators: false) {
                        TabView {
                            ForEach(character.images, id: \.self) { imageUrl in
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geometryReader.size.width/1.2,
                               height: geometryReader.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top, 60)
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.largeTitle)
                            Text("Portrayed by: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            Text("Born: \(character.birthday)")
                            Divider()
                            
                            ForEach(character.occupations, id: \.self) { occupation in
                                Text("• \(occupation)")
                                    .font(.subheadline)
                            }
                            Divider()
                            Text("Nicknames:")
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id: \.self) { alias in
                                    Text("• \(alias)")
                                        .font(.subheadline)
                                }
                            } else {
                                Text("none")
                                    .font(.subheadline)
                            }
                            Divider()
                            DisclosureGroup("Status: (spoiler alert!):") {
                                VStack(alignment: .leading) {
                                    Text(character.status)
                                        .font(.title2)
                                    
                                    if let death = character.death {
                                        AsyncImage(url: death.image) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear {
                                                    withAnimation {
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                    }
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        Text("How: \(death.details)")
                                            .padding(.bottom, 7)
                                        Text("Last word: \"\(death.lastWords)\"")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .tint(.primary)
                        }
                        .frame(width: geometryReader.size.width/1.25, alignment: .leading)
                        .padding(50)
                        .id(1)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
}
