//
//  QuoteView.swift
//  BBQuotes
//
//  Created by वैभव उपाध्याय on 19/11/25.
//

import SwiftUI

struct FetchView: View {
    let vm = ViewModel()
    let show: String
    
    @State var shouldShowCharacterView = false
    
    var body: some View {
        GeometryReader { geometryReader in
            ZStack {
                Image(show.removeCaseAndSpace)
                    .resizable()
                    .frame(width: geometryReader.size.width * 2.7, height: geometryReader.size.height * 1.2)
                
                VStack {
                    VStack {
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .successQuote:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geometryReader.size.width/1.1, height: geometryReader.size.height/1.8)
                                
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geometryReader.size.width/1.1, height: geometryReader.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture {
                                shouldShowCharacterView.toggle()
                            }
                        
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        Spacer(minLength: 20)
                    }
                    HStack(spacing: 30) {
                        Button {
                            Task {
                                await vm.getQuoteData(for: show)
                            }
                        } label: {
                            Text(Constants.getRandomQuote)
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces)Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces)Shadow"), radius: 2)
                        }
                        
                        Button {
                            Task {
                                await vm.getEpisode(for: show)
                            }
                        } label: {
                            Text(Constants.getRandomEpisode)
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces)Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces)Shadow"), radius: 2)
                        }
                    }
                    .padding(30)
                    
                    Spacer(minLength: 95)
                }
                .frame(width: geometryReader.size.width, height: geometryReader.size.height)
            }
            .frame(width: geometryReader.size.width, height: geometryReader.size.height)
        }
        .ignoresSafeArea()
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .sheet(isPresented: $shouldShowCharacterView) {
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    FetchView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
