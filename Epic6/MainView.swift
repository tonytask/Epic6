//
//  MainView.swift
//  Epic6
//
//  Created by Tony on 6/19/24.
//

import SwiftUI

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
       static let screenHeight = UIScreen.main.bounds.size.height
       static let screenSize = UIScreen.main.bounds.size
}

struct MainView: View {
    var gameWorld: GameWorld
    
    @State private var showHomeScreen = true
    @State private var showParty = false
    @State private var showHeroDetails = false
    @State private var showSwitchScreen = false
    @State private var showMissionTypeScreen = false
    @State private var selectedMissionType = ""
    @State private var showChapterScreen = false
    @State private var selectedChapter = ""
    @State private var showMissionScreen = false
    @State private var selectedMission = ""
    @State private var showMissionDetails = false
    @State private var showBattleScreen = false
    @State private var showVictoryScreen = false
    @State private var showSkills = false
    @State private var showStats = true
    @State private var showEquipment = false
    @State private var showSwapEquips = false
    @State private var selectedEquip: EquipmentType = .Weapon
    @State private var showShop = false
    @State private var shopOption = 0
    @State private var showRates = false
    
    @State private var currentHero = Hero(idLabel: 0, name: "", element: .Fire, role: .Archer, position: .Front, rarity: 0, baseHP: 0, baseATT: 0, baseDEF: 0, baseSPATT: 0, baseSPDEF: 0, baseSPD: 0, baseCRITRATE: 0, baseCRITDAMAGE: 0, baseACC: 0, baseRES: 0, abilities: [])
    private var heroColor: Color{
        switch(currentHero.element){
        case .Fire:
            return Color.red
        case .Water:
            return Color.teal
        case .Nature:
            return Color.green
        case .Holy:
            return Color.yellow
        case .Dark:
            return Color.black
        }
    }
    var body: some View {
        ZStack{
            
            if(showHomeScreen == true){
                LinearGradient(colors: [.brown,.white,.brown], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea(.all)
                VStack{
                    //Player Level, Energy, Gems, Cash, EXP
                    VStack(spacing:5){
                        
                        
                        //Top of the Screen: Level, Energy, Cash
                        HStack(spacing:5){
                            VStack(spacing:1){
                                Text("Player")
                                    .foregroundStyle(.black)
                                Text("Lv \(gameWorld.player.level)")
                                    .font(.caption)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                            VStack(alignment:.leading, spacing:1){
                                HStack(spacing:5){
                                    Text("\(gameWorld.player.currentEnergy)/\(gameWorld.player.maximumEnergy)")
                                        .foregroundStyle(.black)
                                    Image("bolt.fill")
                                }
                                Text(String(format: "  %02d:%02d", gameWorld.player.energyTime/60, gameWorld.player.energyTime % 60))
                                    .font(.caption)
                                    .foregroundStyle(.black)
                            }
                            .onTapGesture{
                                /*withAnimation{
                                    showEnergyPurchase = true
                                }*/
                                
                            }
                            
                            Spacer()
                            
                            Text("\(gameWorld.player.gems)")
                                .foregroundStyle(.black)
                            Image("sparkle")
                            Spacer()
                            
                            Text("\(gameWorld.player.cash)")
                                .foregroundStyle(.black)
                            Image("dollarsign.square.fill")
                        }
                        .padding(10)
                        .background(.white.opacity(0.25))
                        .padding(.top,5)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        //Right below: EXP Bar
                        ZStack{
                            
                            Text("Exp:\(gameWorld.player.currentExp)/\(gameWorld.gameData.expToNextLevel[gameWorld.player.level])")
                                .font(.subheadline)
                                .frame(maxWidth:.infinity)
                            
                                .background(.white)
                                .cornerRadius(5)
                            
                            GeometryReader { geometry in
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: geometry.size.width * CGFloat(gameWorld.player.currentExp) / CGFloat(gameWorld.gameData.expToNextLevel[gameWorld.player.level]), height: 18)
                                    .cornerRadius(5)
                                    .shadow(radius: 3)
                                //.animation(.linear, value: gameWorld.enemy.currentHP)
                            }
                            Text("Exp:\(gameWorld.player.currentExp)/\(gameWorld.gameData.expToNextLevel[gameWorld.player.level])")
                                .font(.subheadline)
                                .foregroundStyle(.black)
                        }
                        .frame(height: 10)
                        
                        
                    }
                    
                    Spacer()
                    //Buttons
                    HStack{
                        ForEach(gameWorld.player.party, id:\.self){ hero in
                            ZStack(alignment: .topLeading){
                                Image(hero.name.lowercased())
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.08,height:UIScreen.screenWidth*0.08)
                                    .background(rarityColorGradient(for: hero.rarity))
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                Image(elementImage(for: hero.element))
                            }
                            
                        }
                    }
                    .padding()
                    .background(.white.opacity(0.25))
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    
                    Spacer()
                    HStack{
                        Button {
                            withAnimation{
                                showHomeScreen = false
                                showParty = true
                            }
                            
                        } label: {
                            VStack{
                                Image("person.3.fill")
                                Text("Party")
                                    .font(.caption)
                            }
                            
                            .frame(width: UIScreen.screenWidth*0.12, height: UIScreen.screenWidth*0.08)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        
                        Button {
                            withAnimation{
                                showHomeScreen = false
                                showMissionTypeScreen = true
                            }
                            
                        } label: {
                            VStack{
                                Image("globe.desk.fill")
                                Text("Battle")
                                    .font(.caption)
                            }
                            
                            .frame(width: UIScreen.screenWidth*0.12, height: UIScreen.screenWidth*0.08)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        Button {
                            withAnimation{
                                showHomeScreen = false
                                shopOption = 0
                                showShop = true
                            }
                            
                        } label: {
                            VStack{
                                Image("dollarsign")
                                Text("Shop")
                                    .font(.caption)
                            }
                            
                            .frame(width: UIScreen.screenWidth*0.12, height: UIScreen.screenWidth*0.08)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                    }
                    
                    Spacer()
                }
            }
            
            else if showBattleScreen == true{
                VStack{
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .foregroundColor(.orange)
                            .opacity(0.60)
                        HStack{
                            Spacer()
                            Text("Turn Meter")
                                .foregroundColor(.black)
                                .font(.caption)
                            Spacer()
                        }
                        // Player heroes
                        ForEach(gameWorld.player.party, id:\.self) { hero in
                            if(hero.currentHP > 0){
                                Image(hero.name.lowercased())
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                    
                                    //.border(borderColor(for:hero.element), width: 2)
                                    .offset(x: CGFloat(hero.turnMeter) / CGFloat(gameWorld.turnThreshold) * (UIScreen.main.bounds.width - 40) - 20, y: 0)
                                    .animation(.linear, value: hero.turnMeter)
                                    
                            }
                            
                        }
                        
                        ForEach(gameWorld.enemyParty, id: \.self){ hero in
                            if(hero?.currentHP ?? 0 > 0){
                                Image(hero?.name.lowercased() ?? "")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                        
                                        //.border(borderColor(for:hero.element), width: 2)
                                        .offset(x: CGFloat((hero?.turnMeter ?? 0)) / CGFloat(gameWorld.turnThreshold) * (UIScreen.main.bounds.width - 40) - 20, y: 0)
                                        .animation(.linear, value: hero?.turnMeter)
                                        
                            }
                            
                        }
                        
                        // Enemy heroes
                        /*ForEach(gameWorld.enemyParty, id:\.self){ optionalHero in
                            if let hero = optionalHero {
                                Image(hero.name.lowercased())
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .offset(x: CGFloat(hero.turnMeter / gameWorld.turnThreshold) * (UIScreen.main.bounds.width - 40) - 20, y: 0)
                            }
                        }*/
                    }
                    .padding(.top, 5)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                    .cornerRadius(10)
                    .shadow(radius: 3)


                    Spacer()
                    
                    HStack{
                        //Contribution
                        Spacer()
                        VStack{
                            Text("Contribution")
                                .foregroundStyle(.black)
                                .font(.caption)
                            VStack{
                                ForEach(gameWorld.player.party.sorted(by: {$0.contribution > $1.contribution}), id:\.self){ hero in
                                    if(hero.name != "Default"){
                                        HStack{
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:UIScreen.screenWidth*0.04, height:UIScreen.screenWidth*0.04)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                            Spacer()
                                            Text("\(hero.contribution)")
                                                .foregroundStyle(.black)
                                                .font(.caption)
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        .padding(5)
                        .frame(width: UIScreen.screenWidth*0.12)
                        .background(.white.opacity(0.50))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        Spacer()
                        //Player Party
                        HStack(spacing:5){
                            //party back
                            VStack{
                                ForEach(gameWorld.player.party, id:\.self){hero in
                                    if(hero.position == .Back && hero.name != "Default"){
                                        VStack(spacing:0){
                                            HStack(spacing:1){
                                                ForEach(hero.statChange,id:\.self){ statChange in
                                                    Image(statChange?.image ?? "")
                                                        .resizable()
                                                        .frame(width: UIScreen.screenWidth*0.0175, height: UIScreen.screenWidth*0.0175)
                                                    
                                                }
                                                .frame(height: UIScreen.screenWidth*0.02)
                                                
                                            }
                                            .padding(.bottom,4)
                                            .frame(height: UIScreen.screenWidth*0.02)
                                            
                                            ProgressView(value: Double(hero.currentHP) / Double(hero.actualHP))
                                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                                .frame(width:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .padding(.bottom, 4)
                                                .animation(.linear, value: hero.currentHP)
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:UIScreen.screenWidth*0.06, height:UIScreen.screenWidth*0.06)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(hero.currentHP > 0 ? 1 : 0.2)
                                        }
                                        
                                    }
                                }
                            }
                            
                            
                            //party middle
                            VStack{
                                ForEach(gameWorld.player.party, id:\.self){hero in
                                    if(hero.position == .Middle && hero.name != "Default"){
                                        VStack(spacing:0){
                                            HStack(spacing:1){
                                                ForEach(hero.statChange,id:\.self){ statChange in
                                                    Image(statChange?.image ?? "")
                                                        .resizable()
                                                        .frame(width: UIScreen.screenWidth*0.0175, height: UIScreen.screenWidth*0.0175)
                                                }
                                                .frame(height: UIScreen.screenWidth*0.02)
                                                
                                            }
                                            .padding(.bottom,4)
                                            .frame(height: UIScreen.screenWidth*0.02)
                                            
                                            ProgressView(value: Double(hero.currentHP) / Double(hero.actualHP))
                                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                                .frame(width:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .padding(.bottom, 4)
                                                .animation(.linear, value: hero.currentHP)
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:UIScreen.screenWidth*0.06, height:UIScreen.screenWidth*0.06)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(hero.currentHP > 0 ? 1 : 0.2)
                                        }
                                        
                                    }
                                }
                            }
                            
                            //party front
                            VStack{
                                ForEach(gameWorld.player.party, id:\.self){hero in
                                    if(hero.position == .Front && hero.name != "Default"){
                                        VStack(spacing:0){
                                            HStack(spacing:1){
                                                ForEach(hero.statChange,id:\.self){ statChange in
                                                    Image(statChange?.image ?? "")
                                                        .resizable()
                                                        .frame(width: UIScreen.screenWidth*0.0175, height: UIScreen.screenWidth*0.0175)
                                                }
                                                .frame(height: UIScreen.screenWidth*0.02)
                                                
                                            }
                                            .padding(.bottom,4)
                                            .frame(height: UIScreen.screenWidth*0.02)
                                            
                                            ProgressView(value: Double(hero.currentHP) / Double(hero.actualHP))
                                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                                .frame(width:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .padding(.bottom, 4)
                                                .animation(.linear, value: hero.currentHP)
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:UIScreen.screenWidth*0.06, height:UIScreen.screenWidth*0.06)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(hero.currentHP > 0 ? 1 : 0.2)
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
                        .padding(5)
                        .frame(minWidth:UIScreen.screenWidth*0.30,minHeight:UIScreen.screenHeight*0.60)
                        .background(.white.opacity(0.25))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        //Enemy Party
                        HStack(spacing: 5){
                            //enemyparty front
                            VStack{
                                ForEach(gameWorld.enemyParty, id:\.self){ optionalHero in
                                    if let hero = optionalHero, hero.position == .Front && hero.name != "Default"{
                                        VStack(spacing:0){
                                            HStack(spacing:1){
                                                ForEach(hero.statChange,id:\.self){ statChange in
                                                    Image(statChange?.image ?? "")
                                                        .resizable()
                                                        .frame(width: UIScreen.screenWidth*0.0175, height: UIScreen.screenWidth*0.0175)
                                                }
                                                .frame(height: UIScreen.screenWidth*0.02)
                                                
                                            }
                                            .padding(.bottom,4)
                                            .frame(height: UIScreen.screenWidth*0.02)
                                            
                                            ProgressView(value: Double(hero.currentHP) / Double(hero.actualHP))
                                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                                .frame(width:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .padding(.bottom, 4)
                                                .animation(.linear, value: hero.currentHP)
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width: hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06, height:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(hero.currentHP > 0 ? 1 : 0.2)
                                                .scaleEffect(x: -1)
                                            
                                        }
                                        
                                    }
                                }
                            }
                            
                            
                            
                            //enemy party middle
                            VStack{
                                ForEach(gameWorld.enemyParty, id:\.self){ optionalHero in
                                    if let hero = optionalHero, hero.position == .Middle && hero.name != "Default"{
                                        VStack(spacing:0){
                                            HStack(spacing:1){
                                                ForEach(hero.statChange,id:\.self){ statChange in
                                                    Image(statChange?.image ?? "")
                                                        .resizable()
                                                        .frame(width: UIScreen.screenWidth*0.0175, height: UIScreen.screenWidth*0.0175)
                                                }
                                                .frame(height: UIScreen.screenWidth*0.02)
                                                
                                            }
                                            .padding(.bottom,4)
                                            .frame(height: UIScreen.screenWidth*0.02)
                                            
                                            ProgressView(value: Double(hero.currentHP) / Double(hero.actualHP))
                                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                                .frame(width:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .padding(.bottom, 4)
                                                .animation(.linear, value: hero.currentHP)
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06, height:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(hero.currentHP > 0 ? 1 : 0.2)
                                                .scaleEffect(x: -1)
                                        }
                                        
                                    }
                                }
                            }
                            
                            
                            //enemy party back
                            VStack{
                                ForEach(gameWorld.enemyParty, id:\.self){ optionalHero in
                                    if let hero = optionalHero, hero.position == .Back && hero.name != "Default"{
                                        VStack(spacing:0){
                                            HStack(spacing:1){
                                                ForEach(hero.statChange,id:\.self){ statChange in
                                                    Image(statChange?.image ?? "")
                                                        .resizable()
                                                        .frame(width: UIScreen.screenWidth*0.0175, height: UIScreen.screenWidth*0.0175)
                                                }
                                                
                                                
                                            }
                                            .padding(.bottom,4)
                                            .frame(height: UIScreen.screenWidth*0.02)
                                            
                                            ProgressView(value: Double(hero.currentHP) / Double(hero.actualHP))
                                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                                .frame(width:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .padding(.bottom, 4)
                                                .animation(.linear, value: hero.currentHP)
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06, height:hero.rarity == 5 ? UIScreen.screenWidth*0.12 : UIScreen.screenWidth*0.06)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(hero.currentHP > 0 ? 1 : 0.2)
                                                .scaleEffect(x: -1)
                                        }
                                        
                                    }
                                }
                            }
                             
                        }
                        .padding(5)
                        .frame(minWidth:UIScreen.screenWidth*0.30,minHeight:UIScreen.screenHeight*0.60)
                        .background(.white.opacity(0.25))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        Spacer()
                        
                        
                        
                    }
                    
                    Spacer()
                    if(gameWorld.yourTurn == true){
                        HStack{
                            Spacer()
                            HStack{
                                Image(gameWorld.currentHero.name.lowercased())
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.07, height:UIScreen.screenWidth*0.07)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                VStack{
                                    HStack{
                                        Text("\(gameWorld.currentHero.name)")
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                        
                                    }
                                    HStack{
                                        Text("\(gameWorld.currentHero.currentHP)/\(gameWorld.currentHero.actualHP)")
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                        ZStack(alignment: .leading) {
                                            Rectangle()
                                                .frame(width: UIScreen.screenWidth*0.15, height: 12)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(0.3)
                                                .foregroundColor(Color.gray)
                                            
                                            Rectangle()
                                                .frame(width: healthBarWidth(maxWidth: UIScreen.screenWidth*0.15), height: 12)
                                                .foregroundColor(healthBarColor())
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                            

                                        }
                                        .frame(height: 12)
                                        
                                        
                                    }
                                    .padding(10)
                                    .background(.white.opacity(0.80))
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                    .opacity(0.80)
                                }
                                    
                                
                            }
                            
                            Spacer()
                            HStack{
                                ForEach(gameWorld.currentHero.abilities, id:\.self){ability in
                                    if(ability?.currentCooldown ?? 0 > 0){
                                        ZStack{
                                            Image(ability?.name.lowercased() ?? "")
                                                .resizable()
                                                .frame(width:UIScreen.screenWidth*0.06, height:UIScreen.screenWidth*0.06)
                                                .background(.blue)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(0.2)
                                            
                                            Text("\(ability?.currentCooldown ?? 0)")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.black)
                                        }
                                        
                                    }
                                    else{
                                        Image(ability?.name.lowercased() ?? "")
                                            .resizable()
                                            .frame(width:UIScreen.screenWidth*0.06, height:UIScreen.screenWidth*0.06)
                                            .background(.blue)
                                            .cornerRadius(10)
                                            .shadow(radius: 3)
                                            .onTapGesture{
                                                if(gameWorld.yourTurn == true){
                                                    gameWorld.selectedAbility = ability
                                                    withAnimation{
                                                        gameWorld.useAbility()
                                                    }
                                                    
                                                    
                                                }
                                            }
                                    }
                                    
                                        
                                    
                                }
                            }
                            .padding(5)
                            .frame(width:UIScreen.screenWidth*0.30, height:UIScreen.screenWidth*0.08)
                            .background(.white.opacity(0.80))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            
                            Spacer()
                        }
                        //.padding(5)
                        .background(.clear)
                        .cornerRadius(10)
                    }
                    else{
                        HStack{
                            Spacer()
                            Text("\(gameWorld.currentEnemy.name) used \(gameWorld.enemySelectedAbility?.name ?? "")")
                                .font(.subheadline)
                                .foregroundStyle(.black)
                                .frame(width:UIScreen.screenWidth*0.30, height:UIScreen.screenWidth*0.07)
                                .background(.white.opacity(0.50))
                            
                                .cornerRadius(10)
                                .shadow(radius: 3)
                            Spacer()
                            HStack{
                                
                                VStack{
                                    HStack{
                                        Text("\(gameWorld.currentEnemy.name)")
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                        
                                    }
                                    HStack{
                                        Text("\(gameWorld.currentEnemy.currentHP)/\(gameWorld.currentEnemy.actualHP)")
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                        ZStack(alignment: .leading) {
                                            Rectangle()
                                                .frame(width: UIScreen.screenWidth*0.15, height: 12)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .opacity(0.3)
                                                .foregroundColor(Color.gray)
                                            
                                            Rectangle()
                                                .frame(width: healthBarWidthEnemy(maxWidth: UIScreen.screenWidth*0.15), height: 12)
                                                .foregroundColor(healthBarColorEnemy())
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                            
                                                
                                            
                                        }
                                        .frame(height: 12)
                                        
                                        
                                    }
                                    .padding(10)
                                    .background(.white.opacity(0.80))
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                    .opacity(0.80)
                                }
                                Image(gameWorld.currentEnemy.name.lowercased())
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.07, height:UIScreen.screenWidth*0.07)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                
                            }

                        }
                        .padding(5)
                        .background(.clear)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .opacity(gameWorld.enemyTurn ? 1.0 : 0.0)
                        
                    }
                    
                    
                    
                    
                }
                .padding()
                .frame(width:UIScreen.screenWidth*1)
                .background(LinearGradient(colors: [.brown,.white,.brown], startPoint: .leading, endPoint: .trailing)).opacity(0.90)
                
                
                if(gameWorld.youWon == true){
                    VStack{
                        Text("Victory!")
                            .font(.title3)
                            .foregroundStyle(.black)
                        
                        Divider()
                        
                        Text("Rewards:")
                            .foregroundStyle(.black)
                        HStack{
                            Text("\(gameWorld.gameData.mission[selectedMission]?.expReward ?? 0) EXP")
                                .foregroundStyle(.black)
                        }
                        
                        HStack{
                            Text("\(gameWorld.gameData.mission[selectedMission]?.cashReward ?? 0)")
                                .foregroundStyle(.black)
                            Image("dollarsign.square.fill")
                                
                        }
                        VStack{
                            if(gameWorld.equipmentReward.name != ""){
                                Image(gameWorld.equipmentReward.name.lowercased())
                                    .resizable()
                                    .background(rarityColorGradient(for: gameWorld.equipmentReward.rarity))
                                    .frame(width:UIScreen.screenWidth*0.05,height:UIScreen.screenWidth*0.05)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                            }
                        }
                        
                        Divider()
                        
                        Button{
                            withAnimation{
                                gameWorld.youWon = false
                                showBattleScreen = false
                            }
                            
                        } label: {
                            Text("Collect")
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }
            }
            
            else if(showParty == true){
                LinearGradient(colors: [Color(red: 0/255, green: 51/255, blue: 0),.white,Color(red: 0/255, green: 51/255, blue: 0)], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea(.all)
                
                VStack{
                    HStack{
                        Button {
                            withAnimation{
                                showParty = false
                                showHomeScreen = true
                            }
                            
                        } label: {
                            Image("arrow.left.square.fill")
                                
                        }
                        Spacer()
                        Text("Party")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Spacer()
                        Image("arrow.left.square.fill")
                            .opacity(0)
                    }
                    Divider()
                    
                    HStack{
                        
                        //Col 1 Back
                        VStack(spacing:1){
                            Text("Back")
                                .padding(5)
                                .frame(minWidth:UIScreen.screenWidth*0.12)
                                .foregroundColor(.black)
                                .background(.orange)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                            VStack{
                                ForEach(gameWorld.player.party, id:\.self){hero in
                                    if(hero.position == .Back && hero.name != "Default"){
                                        ZStack(alignment: .topLeading){
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:UIScreen.screenWidth*0.06, height:UIScreen.screenWidth*0.06)
                                                .background(rarityColorGradient(for: hero.rarity))
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                            Image(elementImage(for: hero.element))
                                        }
                                        
                                    }
                                }
                                
                            }
                            .padding()
                            .frame(minWidth:UIScreen.screenWidth*0.12,minHeight:UIScreen.screenHeight*0.60)
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        
                        
                        //Col 2 Middle
                        VStack(spacing:1){
                            Text("Mid")
                                .padding(5)
                                .frame(minWidth:UIScreen.screenWidth*0.12)
                                .foregroundColor(.black)
                                .background(.orange)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                            VStack{
                                ForEach(gameWorld.player.party, id:\.self){hero in
                                    if(hero.position == .Middle && hero.name != "Default"){
                                        ZStack(alignment: .topLeading){
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:UIScreen.screenWidth*0.06, height:UIScreen.screenWidth*0.06)
                                                .background(rarityColorGradient(for: hero.rarity))
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                            Image(elementImage(for: hero.element))
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(minWidth:UIScreen.screenWidth*0.12,minHeight:UIScreen.screenHeight*0.60)
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        
                        
                        //Col 3 Front
                        VStack(spacing:1){
                            Text("Front")
                                .padding(5)
                                .frame(minWidth:UIScreen.screenWidth*0.12)
                                .foregroundColor(.black)
                                .background(.orange)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                            VStack{
                                ForEach(gameWorld.player.party, id:\.self){hero in
                                    if(hero.position == .Front && hero.name != "Default"){
                                        ZStack(alignment: .topLeading){
                                            Image(hero.name.lowercased())
                                                .resizable()
                                                .frame(width:UIScreen.screenWidth*0.06, height:UIScreen.screenWidth*0.06)
                                                .background(rarityColorGradient(for: hero.rarity))
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                            Image(elementImage(for: hero.element))
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(minWidth:UIScreen.screenWidth*0.12,minHeight:UIScreen.screenHeight*0.60)
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        
                        
                        Spacer()
                        
                        //Hero List
                        VStack{
                            ScrollView {
                                // Define the grid layout
                                let columns = [
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ]
                                
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(gameWorld.player.teamList.indices, id: \.self) { index in
                                        if let hero = gameWorld.player.teamList[index] {
                                            VStack{
                                                ZStack(alignment: .topLeading){
                                                    Image(hero.name.lowercased())
                                                        .resizable()
                                                        .frame(width: UIScreen.screenWidth*0.08, height: UIScreen.screenWidth*0.08)
                                                        .background(rarityColorGradient(for: hero.rarity))
                                                        .cornerRadius(10)
                                                        .shadow(radius: 3)
                                                    Image(elementImage(for: hero.element))
                                                }
                                                
                                                Text(hero.name)
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                            }
                                            .padding()
                                            .background(Color.white.opacity(0.8))
                                            .cornerRadius(5)
                                            .shadow(radius: 3)
                                            .onTapGesture {
                                                currentHero = hero
                                                withAnimation {
                                                    showParty = false
                                                    showHeroDetails = true
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        .padding()
                        .frame(minWidth:UIScreen.screenWidth*0.39,minHeight:UIScreen.screenHeight*0.60)
                        .background(.gray.opacity(0.25))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        
                    }
                    
                    Spacer()
                }
                .padding()
            }
            
            else if showHeroDetails == true{
                
                VStack{
                    HStack{
                        Button {
                            withAnimation{
                                showHeroDetails = false
                                showParty = true
                                
                            }
                            
                        } label: {
                            Image("arrow.left.square.fill")
                                
                        }
                        Spacer()
                        Text("\(currentHero.name)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Spacer()
                        Button {
                            withAnimation{
                                showHeroDetails = false
                                showParty = false
                                showHomeScreen = true
                                
                            }
                            
                        } label: {
                            Image("x.square.fill")
                                
                        }
                    }
                    Divider()
                    HStack{
                        
                        VStack{
                            ZStack(alignment: .topLeading){
                                Image(currentHero.name.lowercased())
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.11, height:UIScreen.screenWidth*0.11)
                                    .background(rarityColorGradient(for: currentHero.rarity))
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                Image(elementImage(for: currentHero.element))
                            }
                            
                            Text("Level: \(currentHero.level)")
                                .foregroundStyle(.black)
                            Text("Exp: \(currentHero.currentEXP)/\(currentHero.baseStats*currentHero.level*Int(log2(Float(currentHero.level)))/4+100)")
                                .font(.caption2)
                                .foregroundStyle(.black)
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: UIScreen.screenWidth*0.18, height: 8)
                                    .opacity(0.3)
                                    .foregroundColor(Color.gray)
                                
                                Rectangle()
                                    .frame(width: progressWidth(maxWidth: CGFloat(UIScreen.screenWidth*0.18)), height: 8)
                                    .foregroundColor(Color.green)
                            }
                                        .frame(height: 8)
                        }
                        Divider()
                        Spacer()
                        
                        if(showStats == true){
                            Divider()
                            VStack{
                                Spacer()
                                HStack{
                                    Text("HP")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualHP)")
                                        .foregroundStyle(.black)
                                }
                                Divider()
                                HStack{
                                    Text("ATT")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualATT)")
                                        .foregroundStyle(.black)
                                }
                                Divider()
                                HStack{
                                    Text("DEF")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualDEF)")
                                        .foregroundStyle(.black)
                                }
                                Divider()
                                HStack{
                                    Text("SPATT")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualSPATT)")
                                        .foregroundStyle(.black)
                                }
                                Divider()
                                HStack{
                                    Text("SPDEF")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualSPDEF)")
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                                
                            }
                            .frame(width:UIScreen.screenWidth*0.16)
                            
                            Divider()
                            VStack{
                                Spacer()
                                HStack{
                                    Text("SPD")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualSPD)")
                                        .foregroundStyle(.black)
                                }
                                Divider()
                                HStack{
                                    Text("CRIT")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualCRITRATE)")
                                        .foregroundStyle(.black)
                                }
                                Divider()
                                HStack{
                                    Text("CDMG")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualCRITDAMAGE)")
                                        .foregroundStyle(.black)
                                }
                                Divider()
                                HStack{
                                    Text("ACC")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualACC)")
                                        .foregroundStyle(.black)
                                }
                                Divider()
                                HStack{
                                    Text("RES")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(currentHero.actualRES)")
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                            }
                            .frame(width:UIScreen.screenWidth*0.16)
                            
                            Divider()
                        }
                          
                        
                        else if(showSkills == true){
                            Divider()
                                HStack{
                                    ForEach(currentHero.abilities,id:\.self){abil in
                                        if let ability = abil{
                                            ScrollView{
                                                VStack{
                                                    Image("\(ability.name.lowercased())")
                                                        .resizable()
                                                        .frame(width:UIScreen.screenWidth*0.06,height:UIScreen.screenWidth*0.06)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 3)
                                                    Text("\(ability.name)")
                                                        .font(.subheadline)
                                                        .foregroundStyle(.black)
                                                        .fontWeight(.bold)
                                                    Spacer()
                                                    Text("Type: \(ability.abilityType)")
                                                        .font(.caption)
                                                        .foregroundStyle(.black)
                                                    if(ability.attackTarget == .All){
                                                        Text("Target: \(ability.attackTarget)")
                                                            .font(.caption)
                                                            .foregroundStyle(.black)
                                                    }
                                                    else if(ability.attackTarget == .LowestHealth){
                                                        Text("Target: Lowest Health")
                                                            .font(.caption)
                                                            .foregroundStyle(.black)
                                                    }
                                                    else{
                                                        Text("Target: \(ability.attackTarget) \(ability.attackPos)")
                                                            .font(.caption)
                                                            .foregroundStyle(.black)
                                                    }
                                                    HStack{
                                                        Text("Stat:")
                                                            .font(.caption)
                                                            .foregroundStyle(.black)
                                                        ForEach(ability.statMultiplier, id:\.self){ statMult in
                                                            Text("\(statMult.stat)")
                                                                .font(.caption)
                                                                .foregroundStyle(.black)
                                                        }
                                                    }
                                                    if(ability.cooldown > 0){
                                                        Text("Cooldown: \(ability.cooldown)")
                                                            .font(.caption)
                                                            .foregroundStyle(.black)
                                                    }
                                                    if(ability.statChange.count > 0){
                                                            ForEach(ability.statChange, id:\.self){ statChange in
                                                                HStack{
                                                                    Text("[\(statChange?.name ?? "")]")
                                                                        .font(.caption)
                                                                        .foregroundStyle(.black)
                                                                Text("\(ability.statChangeChance)%")
                                                                    .font(.caption)
                                                                    .foregroundStyle(.black)
                                                                }
                                                                    
                                                            }
                                                        
                                                    }
                                                    Spacer()
                                                    
                                                }
                                                .frame(width:UIScreen.screenWidth*0.16)
                                            }
                                            
                                            Divider()
                                        }
                                        
                                    }
                                    
                                }
                                
                            .padding()
                        }
                        
                        else if (showEquipment == true ){
                            Divider()
                            HStack{
                                VStack{
                                    
                                    if(currentHero.weapon.name == "Empty"){
                                        Text("Weapon")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                        Text("Empty")
                                            .font(.caption)
                                            .foregroundStyle(.black)
                                        
                                    }
                                    else{
                                        Text("\(currentHero.weapon.name)")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                        HStack{
                                            ForEach(0..<currentHero.weapon.rarity, id:\.self){ num in
                                                Image("star.fill")
                                            }
                                        }
                                        Image(currentHero.weapon.name.lowercased())
                                            .resizable()
                                            .frame(width:UIScreen.screenWidth*0.06,height:UIScreen.screenWidth*0.06)
                                            .background(rarityColorGradient(for: currentHero.weapon.rarity))
                                            .cornerRadius(10)
                                        ForEach(currentHero.weapon.stats, id:\.self){ stat in
                                            HStack{
                                                Text("\(stat.stat)")
                                                    .font(.caption)
                                                    .foregroundStyle(.black)
                                                Spacer()
                                                Text("\(stat.bonus)")
                                                    .font(.caption)
                                                    .foregroundStyle(.black)
                                            }
                                        }
                                        
                                    }
                                    Spacer()
                                    VStack{
                                        HStack{
                                            if(currentHero.weapon.name != "Empty"){
                                                Button{
                                                    gameWorld.equipLevelUp(hero: currentHero, equip: currentHero.weapon)
                                                    if let heroIndex = gameWorld.player.teamList.firstIndex(where: {$0?.name == currentHero.name}){
                                                        if let weapon = gameWorld.player.teamList[heroIndex]?.weapon{
                                                            withAnimation{
                                                                currentHero.weapon = weapon
                                                            }
                                                        }
                                                        
                                                        
                                                    }
                                                } label:{
                                                    Text("Enhance")
                                                        .font(.caption2)
                                                        .padding(5)
                                                        .background(.blue)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 3)
                                                }
                                                
                                                
                                                Button{
                                                    gameWorld.player.inventoryEquips.append(currentHero.weapon)
                                                    if let heroIndex = gameWorld.player.teamList.firstIndex(where: {$0?.name == currentHero.name}){
                                                        gameWorld.player.teamList[heroIndex]?.weapon = Equipment(type: .Weapon, name: "Empty", rarity: 1, stats: [], equippable: [])
                                                    }
                                                    withAnimation{
                                                        currentHero.weapon = Equipment(type: .Weapon, name: "Empty", rarity: 1, stats: [], equippable: [])
                                                    }
                                                    
                                                } label: {
                                                    Text("Remove")
                                                        .font(.caption2)
                                                        .padding(5)
                                                        .background(.red)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 3)
                                                }
                                            }
                                        }
                                        
                                        
                                        Button{
                                            selectedEquip = .Weapon
                                            showSwapEquips = true
                                        } label: {
                                            Text("Swap")
                                                .font(.caption)
                                                .padding(5)
                                                .background(.blue)
                                                .foregroundStyle(.white)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                                .frame(width:UIScreen.screenWidth*0.16)
                                Divider()
                                VStack{
                                    if(currentHero.armor.name == "Empty"){
                                        Text("Armor")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                        Text("Empty")
                                            .font(.caption)
                                            .foregroundStyle(.black)
                                    }
                                    else{
                                        Text("\(currentHero.armor.name)")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                        HStack{
                                            ForEach(0..<currentHero.armor.rarity, id:\.self){ num in
                                                Image("star.fill")
                                            }
                                        }
                                        Image(currentHero.armor.name.lowercased())
                                            .resizable()
                                            .frame(width:UIScreen.screenWidth*0.06,height:UIScreen.screenWidth*0.06)
                                            .background(rarityColorGradient(for: currentHero.armor.rarity))
                                            .cornerRadius(10)
                                        ForEach(currentHero.armor.stats, id:\.self){ stat in
                                            HStack{
                                                Text("\(stat.stat)")
                                                    .font(.caption)
                                                    .foregroundStyle(.black)
                                                Spacer()
                                                Text("\(stat.bonus)")
                                                    .font(.caption)
                                                    .foregroundStyle(.black)
                                            }
                                        }
                                    }
                                    Spacer()
                                    VStack{
                                        HStack{
                                            if(currentHero.armor.name != "Empty"){
                                                Button{
                                                    gameWorld.equipLevelUp(hero: currentHero, equip: currentHero.armor)
                                                    if let heroIndex = gameWorld.player.teamList.firstIndex(where: {$0?.name == currentHero.name}){
                                                        if let armor = gameWorld.player.teamList[heroIndex]?.armor{
                                                            withAnimation{
                                                                currentHero.armor = armor
                                                            }
                                                        }
                                                        
                                                        
                                                    }
                                                } label:{
                                                    Text("Enhance")
                                                        .font(.caption2)
                                                        .padding(5)
                                                        .background(.blue)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 3)
                                                }
                                                
                                                Button{
                                                    gameWorld.player.inventoryEquips.append(currentHero.armor)
                                                    if let heroIndex = gameWorld.player.teamList.firstIndex(where: {$0?.name == currentHero.name}){
                                                        gameWorld.player.teamList[heroIndex]?.armor = Equipment(type: .Armor, name: "Empty", rarity: 1, stats: [], equippable: [])
                                                    }
                                                    withAnimation{
                                                        currentHero.armor = Equipment(type: .Armor, name: "Empty", rarity: 1, stats: [], equippable: [])
                                                    }
                                                    
                                                } label: {
                                                    Text("Remove")
                                                        .font(.caption2)
                                                        .padding(5)
                                                        .background(.red)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 3)
                                                }
                                            }
                                        }
                                        Button{
                                            selectedEquip = .Armor
                                            showSwapEquips = true
                                        } label: {
                                            Text("Swap")
                                                .font(.caption)
                                                .padding(5)
                                                .background(.blue)
                                                .foregroundStyle(.white)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                                .frame(width:UIScreen.screenWidth*0.16)
                                Divider()
                                VStack{
                                    if(currentHero.accessory.name == "Empty"){
                                        Text("Accessory")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                        Text("Empty")
                                            .font(.caption)
                                            .foregroundStyle(.black)
                                    }
                                    else{
                                        Text("\(currentHero.accessory.name)")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                        HStack{
                                            ForEach(0..<currentHero.accessory.rarity, id:\.self){ num in
                                                Image("star.fill")
                                            }
                                        }
                                        Image(currentHero.accessory.name.lowercased())
                                            .resizable()
                                            .frame(width:UIScreen.screenWidth*0.06,height:UIScreen.screenWidth*0.06)
                                            .background(rarityColorGradient(for: currentHero.accessory.rarity))
                                            .cornerRadius(10)
                                        ForEach(currentHero.accessory.stats, id:\.self){ stat in
                                            HStack{
                                                Text("\(stat.stat)")
                                                    .font(.caption)
                                                    .foregroundStyle(.black)
                                                Spacer()
                                                Text("\(stat.bonus)")
                                                    .font(.caption)
                                                    .foregroundStyle(.black)
                                            }
                                        }
                                    }
                                    Spacer()
                                    VStack{
                                        HStack{
                                            if(currentHero.accessory.name != "Empty"){
                                                Button{
                                                    gameWorld.equipLevelUp(hero: currentHero, equip: currentHero.accessory)
                                                    if let heroIndex = gameWorld.player.teamList.firstIndex(where: {$0?.name == currentHero.name}){
                                                        if let accessory = gameWorld.player.teamList[heroIndex]?.accessory{
                                                            withAnimation{
                                                                currentHero.accessory = accessory
                                                            }
                                                        }
                                                        
                                                        
                                                    }
                                                } label: {
                                                    Text("Enhance")
                                                        .font(.caption2)
                                                        .padding(5)
                                                        .background(.blue)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 3)
                                                }
                                                
                                                Button{
                                                    gameWorld.player.inventoryEquips.append(currentHero.accessory)
                                                    if let heroIndex = gameWorld.player.teamList.firstIndex(where: {$0?.name == currentHero.name}){
                                                        gameWorld.player.teamList[heroIndex]?.accessory = Equipment(type: .Accessory, name: "Empty", rarity: 1, stats: [], equippable: [])
                                                    }
                                                    withAnimation{
                                                        currentHero.accessory = Equipment(type: .Accessory, name: "Empty", rarity: 1, stats: [], equippable: [])
                                                    }
                                                    
                                                } label: {
                                                    Text("Remove")
                                                        .font(.caption2)
                                                        .padding(5)
                                                        .background(.red)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 3)
                                                }
                                            }
                                        }
                                        Button{
                                            selectedEquip = .Accessory
                                            showSwapEquips = true
                                        } label: {
                                            Text("Swap")
                                                .font(.caption)
                                                .padding(5)
                                                .background(.blue)
                                                .foregroundStyle(.white)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                                .frame(width:UIScreen.screenWidth*0.16)
                                Divider()
                                Spacer()
                            }
                        }
                        
                        
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    Divider()
                    HStack{
                        
                        Button {
                            withAnimation{
                                showSkills = false
                                showEquipment = false
                                showStats = true
                            }
                            
                        } label: {
                            Text("Stats")
                                .font(.title3)
                            .frame(width: UIScreen.screenWidth*0.15, height: UIScreen.screenWidth*0.05)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        
                        Button {
                            withAnimation{
                                showStats = false
                                showEquipment = false
                                showSkills = true
                                
                            }
                            
                        } label: {
                            Text("Skills")
                                .font(.title3)
                            .frame(width: UIScreen.screenWidth*0.15, height: UIScreen.screenWidth*0.05)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        
                        Button {
                            withAnimation{
                                showStats = false
                                showSkills = false
                                showEquipment = true
                            }
                            
                        } label: {
                            Text("Equipment")
                                .font(.title3)
                            .frame(width: UIScreen.screenWidth*0.15, height: UIScreen.screenWidth*0.05)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        Button {
                            withAnimation{
                                showHeroDetails = false
                                
                                showSwitchScreen = true
                            }
                            
                        } label: {
                            Text("Switch")
                                .font(.title3)
                            .frame(width: UIScreen.screenWidth*0.15, height: UIScreen.screenWidth*0.05)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                    }
                    
                }
                .padding()
                .background(LinearGradient(colors: [heroColor,.white,heroColor], startPoint: .leading, endPoint: .trailing)).opacity(0.90)
                
                if(showSwapEquips == true){
                    VStack{
                        HStack{
                            Button {
                                withAnimation{
                                    showSwapEquips = false
                                }
                                
                            } label: {
                                Image("arrow.left.square.fill")
                                    
                            }
                            Spacer()
                            Text("Swap")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            Spacer()
                            Button {
                                withAnimation{
                                    showSwapEquips = false
                                    showHeroDetails = false
                                    showParty = false
                                    showHomeScreen = true
                                    
                                }
                                
                            } label: {
                                Image("x.square.fill")
                                    
                            }
                        }
                        Divider()
                        VStack{
                            ScrollView {
                                // Define the grid layout
                                let columns = [
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ]
                                
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(gameWorld.player.inventoryEquips.indices, id: \.self) { index in
                                        if(gameWorld.player.inventoryEquips[index].type == selectedEquip){
                                            if(gameWorld.player.inventoryEquips[index].equippable.contains(.All) || gameWorld.player.inventoryEquips[index].equippable.contains(currentHero.role)){
                                                VStack{
                                                    Text("\(gameWorld.player.inventoryEquips[index].name)")
                                                        .font(.subheadline)
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.black)
                                                    HStack{
                                                        ForEach(0..<gameWorld.player.inventoryEquips[index].rarity, id:\.self){ num in
                                                            Image("star.fill")
                                                        }
                                                    }
                                                    Image(gameWorld.player.inventoryEquips[index].name.lowercased())
                                                        .resizable()
                                                        .frame(width:UIScreen.screenWidth*0.05,height:UIScreen.screenWidth*0.05)
                                                        .background(rarityColorGradient(for: gameWorld.player.inventoryEquips[index].rarity))
                                                        .cornerRadius(10)
                                                    ForEach(gameWorld.player.inventoryEquips[index].stats, id:\.self){ stat in
                                                        HStack{
                                                            Text("\(stat.stat)")
                                                                .font(.caption)
                                                                .foregroundStyle(.black)
                                                            Spacer()
                                                            Text("\(stat.bonus)")
                                                                .font(.caption)
                                                                .foregroundStyle(.black)
                                                        }
                                                    }
                                                    Spacer()
                                                    Button{
                                                        gameWorld.swapEquips(type: selectedEquip, hero: currentHero, equip: gameWorld.player.inventoryEquips[index], index: index)
                                                        if let heroIndex = gameWorld.player.teamList.firstIndex(where: {$0?.name == currentHero.name}){
                                                            if let hero = gameWorld.player.teamList[heroIndex]{
                                                                currentHero = hero
                                                            }
                                                            
                                                        }
                                                        showSwapEquips = false
                                                        
                                                    } label:{
                                                        Text("Select")
                                                            .font(.caption)
                                                            .padding(5)
                                                            .foregroundStyle(.white)
                                                            .background(.blue)
                                                            .cornerRadius(10)
                                                            .shadow(radius: 3)
                                                        
                                                    }
                                                }
                                                .padding()
                                                .frame(width:UIScreen.screenWidth*0.20,height:UIScreen.screenWidth*0.20)
                                                .background(.gray.opacity(0.50))
                                                
                                                
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        
                        
                    }
                    .padding()
                    .background(.white)
                }
            }
            
            else if showSwitchScreen == true{
                LinearGradient(colors: [Color(red: 0/255, green: 51/255, blue: 0/255),.white,Color(red: 0/255, green: 51/255, blue: 0/255),], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea(.all)
                
                VStack{
                    HStack{
                        Button {
                            withAnimation{
                                showSwitchScreen = false
                                showHeroDetails = true
                            }
                            
                        } label: {
                            Image("arrow.left.square.fill")
                                
                        }
                        Spacer()
                        Text("Switch")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Spacer()
                        Button {
                            withAnimation{
                                showSwitchScreen = false
                                showHeroDetails = false
                                showParty = false
                                showHomeScreen = true
                                
                            }
                            
                        } label: {
                            Image("x.square.fill")
                                
                        }
                    }
                    Divider()
                    
                    HStack{
                        ForEach(gameWorld.player.party, id: \.self){hero in
                            VStack{
                                if(hero.name != "Default"){
                                    Text("\(hero.name)")
                                    
                                    Image(hero.name.lowercased())
                                        .resizable()
                                        .frame(width:UIScreen.screenWidth*0.10,height:UIScreen.screenWidth*0.10)

                                    HStack{
                                        Text("Lv ")
                                        Text("\(hero.level)")
                                    }
                                    
                                }
                                else{
                                    Text("Empty")
                                }
                            }
                            .padding(5)
                            .frame(minWidth:UIScreen.screenWidth*0.15,minHeight:UIScreen.screenWidth*0.20)
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .onTapGesture{
                                withAnimation{
                                    gameWorld.swap(currentHero: currentHero, partyHero: hero)
                                }
                            }
                        }
                        
                    }
                    
                    
                }
                .padding()
                .background(.white).opacity(0.90)
            }
            
            else if showMissionTypeScreen == true{
                
                
                VStack{
                    
                    HStack{
                        Button {
                            withAnimation{
                                showMissionTypeScreen = false
                                showHomeScreen = true
                            }
                            
                        } label: {
                            Image("arrow.left.square.fill")
                            
                        }
                        Spacer()
                        Text("Select")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Spacer()
                        Image("arrow.left.square.fill")
                            .opacity(0)
                    }
                    Divider()
                    ScrollView{
                        ForEach(0..<gameWorld.player.unlockedBattles, id:\.self){ index in
                            VStack{
                                Text(gameWorld.gameData.missionType[index])
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(minWidth:UIScreen.screenWidth*0.30,minHeight:UIScreen.screenWidth*0.12)
                            .background(.blue)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .onTapGesture{
                                selectedMissionType = gameWorld.gameData.missionType[index]
                                gameWorld.selectedMissionType = selectedMissionType
                                withAnimation{
                                    showMissionTypeScreen = false
                                    showChapterScreen = true
                                }
                                
                            }
                            
                        }
                        Spacer()
                    }
                    
                    
                    
                    
                }
                .padding()
                .background(LinearGradient(colors: [Color(red: 0/255, green: 0/255, blue: 51/255),.white,Color(red: 0/255, green: 0/255, blue: 51/255)], startPoint: .leading, endPoint: .trailing)).opacity(0.90)
            }
            
            else if showChapterScreen == true{
                VStack{
                    
                    HStack{
                        Button {
                            withAnimation{
                                showChapterScreen = false
                                showMissionTypeScreen = true
                            }
                            
                        } label: {
                            Image("arrow.left.square.fill")
                            
                        }
                        Spacer()
                        Text("Select")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Spacer()
                        Button {
                            withAnimation{
                                showChapterScreen = false
                                showMissionTypeScreen = false
                                showHomeScreen = true
                            }
                            
                        } label: {
                            Image("x.square.fill")
                            
                        }
                    }
                    Divider()
                    if let chaptersUnlocked = gameWorld.player.chaptersUnlocked[selectedMissionType]{
                        ScrollView{
                            ForEach(0..<chaptersUnlocked, id:\.self){ index in
                                if let chapterName = gameWorld.gameData.missionChapter[selectedMissionType]?[index]{
                                    VStack{
                                        Text(chapterName)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(minWidth:UIScreen.screenWidth*0.30,minHeight:UIScreen.screenWidth*0.12)
                                    .background(.blue)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                    .onTapGesture{
                                        selectedChapter = chapterName
                                        gameWorld.selectedChapter = chapterName
                                        withAnimation{
                                            showChapterScreen = false
                                            showMissionScreen = true
                                        }
                                        
                                    }
                                }
                                
                                
                            }
                        }
                        
                    }
                    
                    
                    Spacer()
                    
                }
                .padding()
                .background(LinearGradient(colors: [Color(red: 0/255, green: 0/255, blue: 51/255),.white,Color(red: 0/255, green: 0/255, blue: 51/255)], startPoint: .leading, endPoint: .trailing)).opacity(0.90)
            }
            
            else if showMissionScreen == true{
                VStack{
                    
                    HStack{
                        Button {
                            withAnimation{
                                showMissionScreen = false
                                showChapterScreen = true
                                
                            }
                            
                        } label: {
                            Image("arrow.left.square.fill")
                            
                        }
                        Spacer()
                        Text(selectedChapter)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Spacer()
                        Button {
                            withAnimation{
                                
                                showMissionScreen = false
                                showChapterScreen = false
                                showMissionTypeScreen = false
                                showHomeScreen = true
                                
                            }
                            
                        } label: {
                            Image("x.square.fill")
                            
                        }
                    }
                    Divider()
                    
                    if let missions = gameWorld.player.missionsUnlocked[selectedChapter]{
                        ScrollView{
                            ForEach(0..<missions, id: \.self){ num in
                                HStack{
                                    if let missionsList = gameWorld.gameData.missionList[selectedChapter]{
                                        if num < missionsList.count{
                                            
                                            Spacer()
                                            
                                            Text(missionsList[num])
                                                .font(.title2)
                                                .foregroundStyle(.black)
                                            
                                            Spacer()
                                            
                                            HStack{
                                                if let mission =  gameWorld.gameData.mission[missionsList[num]]{
                                                    
                                                    ForEach(mission.equipmentReward.values.compactMap { $0 }.sorted(by: { $0.name < $1.name }).sorted(by:{$0.rarity > $1.rarity}), id: \.self) { equip in
                                                        Image(equip.name.lowercased())
                                                            .resizable()
                                                            .frame(width: UIScreen.screenWidth * 0.05, height: UIScreen.screenWidth * 0.05)
                                                            .background(rarityColorGradient(for: equip.rarity))
                                                            .cornerRadius(10)
                                                    }
                                                    
                                                    
                                                }
                                                
                                            }
                                            .padding()
                                            .frame(maxWidth:UIScreen.screenWidth*0.20,maxHeight:UIScreen.screenWidth*0.07)
                                            .background(.white)
                                            .cornerRadius(10)
                                            
                                            Spacer()
                                            
                                            Button {
                                                
                                                if(num != missions){
                                                    selectedMission = missionsList[num]
                                                    withAnimation{
                                                        //showMissionDesc = true
                                                    }
                                                }
                                                
                                                
                                            } label: {
                                                Text(num != missions ? "Select" : "Locked")
                                                    .font(.title2)
                                                .frame(minWidth:UIScreen.screenWidth*0.14,minHeight:UIScreen.screenWidth*0.07)
                                                .background(num != missions ? Color.blue : .red)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .onTapGesture{
                                                    selectedMission = missionsList[num]
                                                    gameWorld.selectedMission = missionsList[num]
                                                    if(num != missions){
                                                        withAnimation{
                                                            showMissionScreen = false
                                                            showMissionDetails = true
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth:UIScreen.screenWidth*0.60,minHeight:UIScreen.screenWidth*0.10)
                                .background(.gray.opacity(0.50))
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                
                            }
                        }
                        
                    }
                    
                    
                    Spacer()
                    
                }
                .padding()
                .background(LinearGradient(colors: [Color(red: 0/255, green: 0/255, blue: 51/255),.white,Color(red: 0/255, green: 0/255, blue: 51/255)], startPoint: .leading, endPoint: .trailing)).opacity(0.90)
            }
            
            else if showMissionDetails == true{
                
                
                VStack{
                    
                    HStack{
                        Button {
                            withAnimation{
                                showMissionDetails = false
                                showMissionScreen = true
                            }
                            
                        } label: {
                            Image("arrow.left.square.fill")
                            
                        }
                        Spacer()
                        Text(gameWorld.gameData.mission[selectedMission]?.name ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Spacer()
                        Button {
                            withAnimation{
                                
                                showMissionDetails = false
                                showMissionScreen = false
                                showMissionTypeScreen = false
                                showHomeScreen = true
                            }
                            
                        } label: {
                            Image("x.square.fill")
                            
                        }
                    }
                    Divider()
                    
                    VStack{
                        
                        if let mission = gameWorld.gameData.mission[selectedMission]{
                            
                            Text(mission.description)
                                .font(.subheadline)
                                .foregroundStyle(.black)
                            
                            Spacer()
                            VStack{
                                if(mission.enemyParty.count > 0){
                                    Text("Enemies")
                                        .font(.subheadline)
                                        .foregroundStyle(.black)
                                }
                                
                                HStack{
                                    ForEach(0..<mission.enemyParty.count, id:\.self){index in
                                        if let enemy = mission.enemyParty[index]{
                                            ZStack(alignment: .topLeading){
                                                Image(enemy.name.lowercased())
                                                    .resizable()
                                                    .frame(maxWidth:UIScreen.screenWidth*0.09,maxHeight:UIScreen.screenWidth*0.09)
                                                    .background(rarityColorGradient(for: enemy.rarity))
                                                    .cornerRadius(10)
                                                    .shadow(radius: 3)
                                                Image(elementImage(for: enemy.element))
                                            }
                                            
                                        }
                                        
                                    }
                                }
                            }
                            .padding(.top, 8)
                            .padding(.leading)
                            .padding(.trailing)
                            .padding(.bottom)
                            .background(.white)
                            .cornerRadius(10)
                            
                            Spacer()
                            if(mission.energyCost != 99){
                                Button {
                                    if(gameWorld.player.currentEnergy >= gameWorld.gameData.mission[selectedMission]?.energyCost ?? 0){
                                        withAnimation{
                                            gameWorld.setBattle()
                                            showBattleScreen = true
                                        }
                                        
                                        
                                        gameWorld.battle()
                                    }
                                    
                                    
                                    
                                } label: {
                                    HStack{
                                        Text("\(mission.energyCost)")
                                            .font(.title3)
                                            .foregroundStyle(.white)
                                        Image("bolt.fill")
                                    }
                                    .padding()
                                    .frame(maxWidth:UIScreen.screenWidth*0.10,maxHeight:UIScreen.screenWidth*0.05)
                                    .background(.blue)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                }
                            }
                            
                        }
                        
                        
                    }
                    .padding()
                    .frame(maxWidth:UIScreen.screenWidth*0.60,minHeight:UIScreen.screenWidth*0.30)
                    .background(.white.opacity(0.50))
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    
                    Spacer()
                    
                }
                .padding()
                .background(LinearGradient(colors: [Color(red: 0/255, green: 0/255, blue: 51/255),.white,Color(red: 0/255, green: 0/255, blue: 51/255)], startPoint: .leading, endPoint: .trailing)).opacity(0.90)
            }
            
            else if showShop == true{
                
                
                VStack{
                    
                    HStack{
                        Button {
                            withAnimation{
                                showShop = false
                                showHomeScreen = true
                            }
                            
                        } label: {
                            Image("arrow.left.square.fill")
                            
                        }
                        Spacer()
                        Text("Shop")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Spacer()
                        Button {
                            withAnimation{
                                
                                showMissionDetails = false
                                showMissionScreen = false
                                showMissionTypeScreen = false
                                showHomeScreen = true
                            }
                            
                        } label: {
                            Image("x.square.fill")
                                .opacity(0)
                            
                        }
                    }
                    Divider()
                    
                    if(shopOption == 0){
                        Spacer()
                        HStack{
                            if let chaptersUnlocked = gameWorld.player.chaptersUnlocked["Story"]{
                                Button{
                                    shopOption = 1
                                } label:{
                                    Text(chaptersUnlocked >= 1 ? "Hero" : "???")
                                        .padding()
                                        .font(.title3)
                                        .frame(width:UIScreen.screenWidth*0.16,height:UIScreen.screenWidth*0.08)
                                        .foregroundStyle(.white)
                                        .background(chaptersUnlocked >= 1 ? .blue : .red)
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                }
                                Button{
                                    shopOption = 2
                                } label:{
                                    Text(chaptersUnlocked >= 1 ? "Weapon" : "???")
                                        .padding()
                                        .font(.title3)
                                        .frame(width:UIScreen.screenWidth*0.16,height:UIScreen.screenWidth*0.08)
                                        .foregroundStyle(.white)
                                        .background(chaptersUnlocked >= 1 ? .blue : .red)
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                }
                                Button{
                                    shopOption = 3
                                } label:{
                                    Text(chaptersUnlocked >= 3 ? "Armor" : "???")
                                        .padding()
                                        .font(.title3)
                                        .frame(width:UIScreen.screenWidth*0.16,height:UIScreen.screenWidth*0.08)
                                        .foregroundStyle(.white)
                                        .background(chaptersUnlocked >= 3 ? .blue : .red)
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                }
                                Button{
                                    shopOption = 4
                                } label:{
                                    Text(chaptersUnlocked >= 4 ? "Accessory" : "???")
                                        .padding()
                                        .font(.title3)
                                        .frame(width:UIScreen.screenWidth*0.16,height:UIScreen.screenWidth*0.08)
                                        .foregroundStyle(.white)
                                        .background(chaptersUnlocked >= 4 ? .blue : .red)
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                }
                                
                            }
                            
                            
                        }
                    }
                    
                    else if(shopOption == 1){
                        Spacer()
                        Text("Featured")
                            .font(.headline)
                            .foregroundStyle(.black)
                        HStack{
                            VStack{
                                Text("Elena")
                                    .foregroundStyle(.black)
                                Image("elena")
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.12,height:UIScreen.screenWidth*0.12)
                                    .background(rarityColorGradient(for: 3))
                                    .cornerRadius(10)
                            }
                            .padding()
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            
                            
                            VStack{
                                Text("Abby")
                                    .foregroundStyle(.black)
                                Image("abby")
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.12,height:UIScreen.screenWidth*0.12)
                                    .background(rarityColorGradient(for: 5))
                                    .cornerRadius(10)
                            }
                            .padding()
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            
                            VStack{
                                Text("Monica")
                                    .foregroundStyle(.black)
                                Image("monica")
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.12,height:UIScreen.screenWidth*0.12)
                            }
                            .padding()
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            
                            VStack{
                                Text("Kurayami")
                                    .foregroundStyle(.black)
                                Image("kurayami")
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.12,height:UIScreen.screenWidth*0.12)
                            }
                            .padding()
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                        }
                        Spacer()
                        HStack{
                            Button{
                                
                            } label:{
                                Text("Gacha")
                                    .padding()
                                    .font(.title3)
                                    .frame(width:UIScreen.screenWidth*0.15,height:UIScreen.screenWidth*0.08)
                                    .foregroundStyle(.white)
                                    .background(.blue)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                            }
                            Button{
                                showRates = true
                            } label:{
                                Text("Rates")
                                    .padding()
                                    .font(.title3)
                                    .frame(width:UIScreen.screenWidth*0.15,height:UIScreen.screenWidth*0.08)
                                    .foregroundStyle(.white)
                                    .background(.blue)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                            }
                        }
                        Spacer()
                    }
                    
                    else if(shopOption == 2){
                        Spacer()
                        Text("Featured")
                            .font(.headline)
                            .foregroundStyle(.black)
                        HStack{
                            
                            VStack{
                                Text("Silver Death")
                                    .foregroundStyle(.black)
                                HStack{
                                    Image("star.fill")
                                    Image("star.fill")
                                    Image("star.fill")
                                    Image("star.fill")
                                    
                                }
                                
                                Image("silver death")
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.10,height:UIScreen.screenWidth*0.10)
                                    .background(rarityColor(for: 5))
                                    .cornerRadius(10)
                            }
                            .padding()
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            
                            VStack{
                                Text("Moonstrike")
                                    .foregroundStyle(.black)
                                HStack{
                                    Image("star.fill")
                                    Image("star.fill")
                                    Image("star.fill")
                                    Image("star.fill")
                                    
                                }
                                Image("moonstrike")
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.10,height:UIScreen.screenWidth*0.10)
                            }
                            .padding()
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            
                            VStack{
                                Text("Curslayer")
                                    .foregroundStyle(.black)
                                HStack{
                                    Image("star.fill")
                                    Image("star.fill")
                                    Image("star.fill")
                                    Image("star.fill")
                                    
                                }
                                Image("curslayer")
                                    .resizable()
                                    .frame(width:UIScreen.screenWidth*0.10,height:UIScreen.screenWidth*0.10)
                            }
                            .padding()
                            .background(.white.opacity(0.50))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            
                        }
                        Spacer()
                        HStack{
                            Button{
                                
                            } label:{
                                Text("Gacha")
                                    .padding()
                                    .font(.title3)
                                    .frame(width:UIScreen.screenWidth*0.15,height:UIScreen.screenWidth*0.08)
                                    .foregroundStyle(.white)
                                    .background(.blue)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                            }
                            Button{
                                showRates = true
                            } label:{
                                Text("Rates")
                                    .padding()
                                    .font(.title3)
                                    .frame(width:UIScreen.screenWidth*0.15,height:UIScreen.screenWidth*0.08)
                                    .foregroundStyle(.white)
                                    .background(.blue)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                            }
                        }
                        Spacer()
                    }
                    
                    
                    Spacer()
                    
                }
                .padding()
                .background(LinearGradient(colors: [Color(red: 153/255, green: 0/255, blue: 76/255),.white,Color(red: 153/255, green: 0/255, blue: 76/255)], startPoint: .leading, endPoint: .trailing)).opacity(0.90)
            }
            
            
        }
        .onAppear{
            gameWorld.startEnergyTimer()
        }
        
    }
    
    func borderColor(for element: Element) -> Color{
        switch element {
        case .Fire:
            return .red
        case .Water:
            return .teal
        case .Nature:
            return .green
        case .Holy:
            return .yellow
        case .Dark:
            return .black
        }
    }
    // Calculate max experience for the hero based on the formula
        private func maxExp(for hero: Hero) -> Int {
            return hero.baseStats * hero.level * Int(log2(Float(hero.level))) / 4 + 100
        }
        
        // Calculate the width of the filled progress bar
    private func progressWidth(maxWidth: CGFloat) -> CGFloat {
            let progress = CGFloat(currentHero.currentEXP) / CGFloat(maxExp(for: currentHero))
            return maxWidth * progress
        }
    
    private func healthBarWidth(maxWidth: CGFloat) -> CGFloat {
            let healthPercentage = CGFloat(gameWorld.currentHero.currentHP) / CGFloat(gameWorld.currentHero.actualHP)
            return maxWidth * healthPercentage
        }
    
    private func healthBarWidthEnemy(maxWidth: CGFloat) -> CGFloat {
            let healthPercentage = CGFloat(gameWorld.currentEnemy.currentHP) / CGFloat(gameWorld.currentEnemy.actualHP)
            return maxWidth * healthPercentage
        }
    
        
        // Determine color of the health bar based on health percentage
        private func healthBarColor() -> Color {
            let healthPercentage = CGFloat(gameWorld.currentHero.currentHP) / CGFloat(gameWorld.currentHero.actualHP)
            if healthPercentage > 0.6 {
                return .green
            } else if healthPercentage > 0.3 {
                return .yellow
            } else {
                return .red
            }
        }
    
    
    
    private func healthBarColorEnemy() -> Color {
        let healthPercentage = CGFloat(gameWorld.currentEnemy.currentHP) / CGFloat(gameWorld.currentEnemy.actualHP)
        if healthPercentage > 0.6 {
            return .green
        } else if healthPercentage > 0.3 {
            return .yellow
        } else {
            return .red
        }
    }
    
    private func rarityColor(for rarity: Int) -> Color{
        switch rarity{
        case 1:
            return Color(red: 25, green: 25, blue: 25)
        case 2:
            return .green
        case 3:
            return .cyan
        case 4:
            return .purple
        case 5:
            return .yellow
            
        default:
            return Color(red: 25, green: 25, blue: 25)
        }
    }
    
    private func rarityColorGradient(for rarity:Int) -> LinearGradient{
        switch rarity{
        case 1:
            return LinearGradient(colors: [Color(red: 192/255, green: 192/255, blue: 192/255),Color(red: 224/255, green: 224/255, blue: 224/255)], startPoint: .top, endPoint: .bottom)
        case 2:
            return LinearGradient(colors: [Color(red: 0/255, green: 102/255, blue: 0/255),Color(red: 204/255, green: 255/255, blue: 204/255)], startPoint: .top, endPoint: .bottom)
        case 3:
            return LinearGradient(colors: [Color(red: 0/255, green: 128/255, blue: 255/255),Color(red: 153/255, green: 204/255, blue: 255/255)], startPoint: .top, endPoint: .bottom)
            
        case 4:
            return LinearGradient(colors: [Color(red: 127/255, green: 0/255, blue: 255/255),Color(red: 204/255, green: 153/255, blue: 255/255)], startPoint: .top, endPoint: .bottom)
        case 5:
            return LinearGradient(colors: [Color(red: 255/255, green: 128/255, blue: 0/255),Color(red: 255/255, green: 204/255, blue: 153/255)], startPoint: .top, endPoint: .bottom)
        default:
            return LinearGradient(colors: [Color(red: 192/255, green: 192/255, blue: 192/255),Color(red: 224/255, green: 224/255, blue: 224/255)], startPoint: .top, endPoint: .bottom)
            
        }
    }
    
    private func elementImage(for element: Element) -> String{
        switch element{
        case .Dark:
            return "moon.circle.fill"
        case .Holy:
            return "sun.max.circle.fill"
        case .Fire:
            return "flame.circle.fill"
        case .Water:
            return "drop.circle.fill"
        case .Nature:
            return "leaf.circle.fill" // leaf.circle.fill
        }
   
        
    }
}

/*#Preview {
    MainView(gameWorld: GameWorld())
}*/
