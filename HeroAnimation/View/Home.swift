//
//  Home.swift
//  HeroAnimation
//
//  Created by Simec Sys Ltd. on 5/12/20.
//

import SwiftUI

struct Home: View {
    @State private var hero: Bool = false
    @State private var cards = [
        Card(id: 0, image: "p2", title: "USA", details: "The U.S. is a country of 50 states covering a vast swath of North America, with Alaska in the northwest and Hawaii extending the nation’s presence into the Pacific Ocean. Major Atlantic Coast cities are New York, a global finance and culture center, and capital Washington, DC. Midwestern metropolis Chicago is known for influential architecture and on the west coast, Los Angeles' Hollywood is famed for filmmaking.", expand: false),
        Card(id: 1, image: "p3", title: "Canada", details: "Canada is a country in the northern part of North America. Its ten provinces and three territories extend from the Atlantic to the Pacific and northward into the Arctic Ocean, covering 9.98 million square kilometres, making it the world's second-largest country by total area.", expand: false),
        Card(id: 2, image: "p4", title: "Australia", details: "Australia, officially the Commonwealth of Australia, is a sovereign country comprising the mainland of the Australian continent, the island of Tasmania, and numerous smaller islands. It is the largest country in Oceania and the world's sixth-largest country by total area.", expand: false),
        Card(id: 3, image: "p5", title: "Germany", details: "Germany is a Western European country with a landscape of forests, rivers, mountain ranges and North Sea beaches. It has over 2 millennia of history. Berlin, its capital, is home to art and nightlife scenes, the Brandenburg Gate and many sites relating to WWII. Munich is known for its Oktoberfest and beer halls, including the 16th-century Hofbräuhaus. Frankfurt, with its skyscrapers, houses the European Central Bank.", expand: false),
        Card(id: 4, image: "p6", title: "Dubai", details: "Dubai is a city and emirate in the United Arab Emirates known for luxury shopping, ultramodern architecture and a lively nightlife scene. Burj Khalifa, an 830m-tall tower, dominates the skyscraper-filled skyline. At its foot lies Dubai Fountain, with jets and lights choreographed to music. On artificial islands just offshore is Atlantis, The Palm, a resort with water and marine-animal parks.", expand: false),
        
        Card(id: 5, image: "p1", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false)
    ]
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Friday, May 2020")
                            Text("Today")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Spacer(minLength: 0)
                        Image("pic")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .padding()
                    VStack {
                        ForEach(0..<cards.count) { index in
                            GeometryReader { geometry in
                                CardView(data: $cards[index], hero: $hero)
                                    .offset(y: cards[index].expand ? -geometry.frame(in: .global).minY : 0)
                                    .opacity(hero ? (cards[index].expand ? 1 : 0) : 1)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)) {
                                            hero.toggle()
                                            cards[index].expand.toggle()
                                        }
                                    }
                            }
                            .frame(height: cards[index].expand ? UIScreen.main.bounds.height : 250)
                            .simultaneousGesture(DragGesture(minimumDistance: cards[index].expand ? 0 : 500).onChanged({ (_) in
                                print("Dragging")
                            }))
                        }
                    }
                }
            }
        }
    }
}

struct CardView: View {
    @Binding var data: Card
    @Binding var hero: Bool
    @State private var loadContent: Bool = false
    
    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .frame(height: self.data.expand ? 350 : 250)
                .cornerRadius(data.expand ? 0 : 25)
            if data.expand {
                VStack {
                    HStack {
                        Text(data.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    Text(data.details)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Details")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    HStack(spacing: 0) {
                        Button(action: {}) {
                            Image("mcard1")
                        }
                        Spacer(minLength: 0)
                        Button(action: {}) {
                            Image("mcard2")
                        }
                        Spacer(minLength: 0)
                        Button(action: {}) {
                            Image("mcard3")
                        }
                        Spacer(minLength: 0)
                        Button(action: {}) {
                            Image("mcard4")
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .frame(height: loadContent ?  nil : 0)
                .opacity(loadContent ? 1 : 0)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, data.expand ? 0 : 20)
        .contentShape(Rectangle())
        .onAppear {
            withAnimation(Animation.spring().delay(0.45)) {
                loadContent.toggle()
            }
        }
    }
}
