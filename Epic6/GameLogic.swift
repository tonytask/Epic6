//
//  GameLogic.swift
//  Epic6
//
//  Created by Tony on 6/18/24.
//

import SwiftUI
import Foundation

enum Element: Codable, Hashable{
    case Fire, Water, Nature, Holy, Dark
}

enum Role: Codable, Hashable{
    case Tank, Warrior, Assassin, Mage, Archer, Support, All
}

enum Stat: Codable, Hashable, CaseIterable{
    case HP, ATT, DEF, SPATT, SPDEF, SPD, CRITRATE, CRITDAMAGE, ACC, RES
}

enum ArtifactSlot: Codable, Hashable{
    case slot1, slot2, slot3
}

enum AbilityType: String,Codable, Hashable{
    case Physical = "Physical"
    case Special = "Special"
    case Buff = "Buff"
    case Heal = "Heal"
}

enum Position: Codable, Hashable{
    case Front, Middle, Back, User, Party
}

enum AttackTarget: Codable, Hashable{
    case Single, Row, All, LowestHealth
}

enum MissionType: Codable, Hashable{
    case Story, Special
}

enum EquipmentType: Codable, Hashable{
    case Weapon, Armor, Accessory
}

struct Player: Codable{
    var name: String
    var level: Int = 1
    var currentExp: Int = 0
    var currentEnergy: Int = 100
    var maximumEnergy: Int = 100
    var cash: Int = 0
    var gems: Int = 0
    var energyTime: Int = 180
    var teamList: [Hero?] = []
    var artifactList: [Artifact] = []
    var party: [Hero] = []
    var unlockedBattles: Int{
        var battles = 1
        
        return battles
    }
    
    var chaptersUnlocked: [String: Int] = ["Story": 1, "Special": 1]
    
    var missionsUnlocked: [String:Int] = ["Ch 1": 1, "Ch 2": 1, "Ch 3": 1, "Ch 4": 1, "Ch 5": 1]
    var missionsBeat = Set([""])
    
    var inventoryEquips: [Equipment] = []
}

struct Hero: Codable, Hashable, Identifiable{
    var id =  UUID()
    var idLabel: Int
    var name: String
    var element: Element
    var role: Role
    var position: Position
    var rarity: Int
    var ascension: Int = 0
    var level: Int = 1
    var currentEXP: Int = 0
    var baseHP: Int
    var baseATT: Int
    var baseDEF: Int
    var baseSPATT: Int
    var baseSPDEF: Int
    var baseSPD: Int
    var baseStats: Int{
        return (baseHP / 10) + baseATT + baseDEF + baseSPATT + baseSPDEF + baseSPD
    }
    var baseCRITRATE: Int
    var baseCRITDAMAGE: Int
    var baseACC: Int
    var baseRES: Int
    var abilities: [Ability?]
    var equippedArtifacts: [Artifact] = []
    var elementDamageMultiplier: [Element:Int]{
        if(element == .Dark){
            return [.Dark: 100, .Fire: 100, .Water: 100, .Nature: 100, .Holy: 150]
        }
        else if(element == .Fire){
            return [.Dark: 100, .Fire: 100, .Water: 75, .Nature: 150, .Holy: 100]
        }
        else if(element == .Water){
            return [.Dark: 100, .Fire: 150, .Water: 100, .Nature: 75, .Holy: 100]
        }
        else if(element == .Nature){
            return [.Dark: 100, .Fire: 75, .Water: 150, .Nature: 100, .Holy: 100]
        }
        else{
            return [.Dark: 150, .Fire: 100, .Water: 100, .Nature: 100, .Holy: 100]
        }
    }
    var elementDefenseMultiplier: [Element:Int]{
        if(element == .Dark){
            return [.Dark: 100, .Fire: 100, .Water: 100, .Nature: 100, .Holy: 150]
        }
        else if(element == .Fire){
            return [.Dark: 100, .Fire: 100, .Water: 150, .Nature: 75, .Holy: 100]
        }
        else if(element == .Water){
            return [.Dark: 100, .Fire: 75, .Water: 100, .Nature: 150, .Holy: 100]
        }
        else if(element == .Nature){
            return [.Dark: 100, .Fire: 150, .Water: 75, .Nature: 100, .Holy: 100]
        }
        else{
            return [.Dark: 150, .Fire: 100, .Water: 100, .Nature: 100, .Holy: 100]
        }
    }
    
    var currentHP: Int = 0
    var turnMeter: Int = 0
    var statChange: [StatAlteration?] = []
    var contribution: Int = 0
    var weapon: Equipment = Equipment(type: .Weapon, name: "Empty",rarity: 1, stats: [], equippable: [])
    var armor: Equipment = Equipment(type: .Armor, name: "Empty", rarity: 1,stats: [], equippable: [])
    var accessory: Equipment = Equipment(type: .Accessory, name: "Empty",rarity: 1, stats: [], equippable: [])
    var equipmentATT: Int{
        var att = 0
        for stat in weapon.stats{
            if(stat.stat == .ATT){
                att += stat.bonus
            }
        }
        for stat in armor.stats{
            if(stat.stat == .ATT){
                att += stat.bonus
            }
        }
        for stat in accessory.stats{
            if(stat.stat == .ATT){
                att += stat.bonus
            }
        }
        return att
    }
    var equipmentDEF: Int{
        var att = 0
        for stat in weapon.stats{
            if(stat.stat == .DEF){
                att += stat.bonus
            }
        }
        for stat in armor.stats{
            if(stat.stat == .DEF){
                att += stat.bonus
            }
        }
        for stat in accessory.stats{
            if(stat.stat == .DEF){
                att += stat.bonus
            }
        }
        return att
    }
    var equipmentSPATT: Int{
        var att = 0
        for stat in weapon.stats{
            if(stat.stat == .SPATT){
                att += stat.bonus
            }
        }
        for stat in armor.stats{
            if(stat.stat == .SPATT){
                att += stat.bonus
            }
        }
        for stat in accessory.stats{
            if(stat.stat == .SPATT){
                att += stat.bonus
            }
        }
        return att
    }
    var equipmentSPDEF: Int{
        var att = 0
        for stat in weapon.stats{
            if(stat.stat == .SPDEF){
                att += stat.bonus
            }
        }
        for stat in armor.stats{
            if(stat.stat == .SPDEF){
                att += stat.bonus
            }
        }
        for stat in accessory.stats{
            if(stat.stat == .SPDEF){
                att += stat.bonus
            }
        }
        return att
    }
    var equipmentSPD: Int{
        var att = 0
        for stat in weapon.stats{
            if(stat.stat == .SPD){
                att += stat.bonus
            }
        }
        for stat in armor.stats{
            if(stat.stat == .SPD){
                att += stat.bonus
            }
        }
        for stat in accessory.stats{
            if(stat.stat == .SPD){
                att += stat.bonus
            }
        }
        return att
    }
    var equipmentCRITRATE: Int{
        var att = 0
        for stat in weapon.stats{
            if(stat.stat == .CRITRATE){
                att += stat.bonus
            }
        }
        for stat in armor.stats{
            if(stat.stat == .CRITRATE){
                att += stat.bonus
            }
        }
        for stat in accessory.stats{
            if(stat.stat == .CRITRATE){
                att += stat.bonus
            }
        }
        return att
    }
    var equipmentCRITDAMAGE: Int{
        var att = 0
        for stat in weapon.stats{
            if(stat.stat == .CRITDAMAGE){
                att += stat.bonus
            }
        }
        for stat in armor.stats{
            if(stat.stat == .CRITDAMAGE){
                att += stat.bonus
            }
        }
        for stat in accessory.stats{
            if(stat.stat == .CRITDAMAGE){
                att += stat.bonus
            }
        }
        return att
    }
    var actualHP: Int{
        baseHP * (100+3*level) / 100
    }
    var actualATT: Int{
        baseATT * (100+3*level) / 100 + equipmentATT
    }
    var actualDEF: Int{
        baseDEF * (100+3*level) / 100 + equipmentDEF
    }
    var actualSPATT: Int{
        baseSPATT * (100+3*level) / 100 + equipmentSPATT
    }
    var actualSPDEF: Int{
        baseSPDEF * (100+3*level) / 100 + equipmentSPDEF
    }
    var actualSPD: Int{
        baseSPD + equipmentSPD
    }
    var actualCRITRATE: Int{
        baseCRITRATE + equipmentCRITRATE
    }
    var actualCRITDAMAGE: Int{
        baseCRITDAMAGE + equipmentCRITDAMAGE
    }
    var actualACC: Int{
        baseACC
    }
    var actualRES: Int{
        baseRES
    }
}

struct Equipment: Codable, Hashable, Identifiable{
    var id = UUID()
    var type: EquipmentType
    var name: String
    var rarity: Int
    var currentLevel: Int = 1
    var maximumLevel: Int = 5
    
    var stats: [StatChange]
    var equippable: [Role]
    var statOnLevelUp: [StatChange] = []
    var upgradeCost: Int{
        currentLevel * 1000 * rarity * rarity
    }
}

struct Ability: Codable, Hashable{
    var idLabel: Int
    var name: String
    var abilityType: AbilityType
    var statMultiplier: [StatMultiplier]
    var damageMultiplier: Int
    var attackTarget: AttackTarget
    var attackPos: Position
    
    var cooldown: Int
    var currentCooldown: Int = 0
    var statChange: [StatAlteration?] = []
    var statChangeChance: Int = 100
}

struct StatMultiplier: Codable, Hashable{
    var stat: Stat
    var multiplier: Int
}

struct ArtifactBonus: Codable, Hashable{
    var stat: Stat
    var bonus: Int
}

struct Artifact: Codable, Hashable{
    var ArtifactSlot: ArtifactSlot
    var mainStat: ArtifactBonus
    var subStat1: ArtifactBonus
    var subStat2: ArtifactBonus
    var subStat3: ArtifactBonus
    
}

struct StatChange: Codable, Hashable{
    var stat: Stat
    var bonus: Int
}

struct StatAlteration: Codable, Hashable{
    
    var name: String
    var duration: Int
    var statChange: [StatChange]
    var isBuff: Bool = false
    var image: String = ""
}

struct Mission: Codable, Hashable{
    var name: String
    var description: String
    var imageRewards: [String]
    var energyCost: Int
    var enemyParty: [Hero?]
    var expReward: Int
    var cashReward: Int
    var equipmentReward: [Int: Equipment?] = [:]
}

struct GameData: Codable, Hashable{
    
    var defaultAbility = Ability(idLabel: 0, name: "Default", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0)
    
    var ability: [String:Ability] = [:]
    
    var statChanges: [String: StatAlteration] = ["DEF Down": StatAlteration(name: "DEF Down", duration: 3, statChange: [StatChange(stat: .DEF, bonus: -20)], isBuff: false, image: "shield.slash"),
                                                 "SPDEF Down": StatAlteration(name: "SPDEF Down", duration: 3, statChange: [StatChange(stat: .SPDEF, bonus: -20)], isBuff: false, image: "shield.slash"),
                                                 "ATT Down": StatAlteration(name: "ATT Down", duration: 3, statChange: [StatChange(stat: .ATT, bonus: -20)], isBuff: false, image: "Image"),
                                                 "SPATT Down": StatAlteration(name: "SPATT Down", duration: 3, statChange: [StatChange(stat: .SPATT, bonus: -20)], isBuff: false),
                                                 "SPD Down": StatAlteration(name: "SPD Down", duration: 3, statChange: [StatChange(stat: .SPD, bonus: -20)], isBuff: false, image: "arrow.down.circle"),
                                                 "DEF Up": StatAlteration(name: "DEF Up", duration: 3, statChange: [StatChange(stat: .DEF, bonus: 20)], isBuff: true),
    
    ]
    
    
    var expToNextLevel: [Int] = [0,15,32,54,88,130,247,376,585,848,1326,2000,2853,3792,5000,7164, 9708, 13062,99999999]//372,560,840,1242,1144,1573,2144,2800,3640,4700,5893,7360,9144,11120,13477,16268,19320,22880,27008,31477,36600,42444,48720,55813,63800,86784,98208,110932,124432,139372,155865,173280,192400,213345,235372,259392,285532,312928,342624,374760,408336,445544,483532,524160,567772,598886,631704,666321,702836,741351,781976,824828,870028,917625,967995,1021041,1076994,1136013,1198266,1263930,1333194,1406252,1483314,1564600,1650340,1740778,1836173,1936794,2042930,2154882,2272970,2397528,2528912,2667496,2813674,2967863,3130502,3302053,3483005,3673873,3875201,4087562,4311559,4547832,4797053,5059931,5337215,5629694,5938202,6263614,6606860,6968915,7350811,7753635,8178534,99999999]
    
    var hero: [String:Hero] = [:]
    
    var missionType: [String] = ["Story", "Special"]
    
    var missionChapter: [String: [String]] = ["Story": ["Ch 1", "Ch 2"]]
    
    var missionList: [String:[String]] = ["Ch 1": ["1-1", "1-2", "1-3", "1-4", "1-5", "1-6", "1-7", "1-8", "1-A"],
                                          "Ch 2": ["2-1"],
                                          "Ch 3": ["3-1"],
                                          "Ch 4": ["4-1"],
                                          "Ch 5": ["5-1"],
        
    ]
    
    var equipment: [String: Equipment] = ["Bent Blade":Equipment(type: .Weapon, name: "Bent Blade", rarity: 1, stats: [StatChange(stat: .ATT, bonus: 6)], equippable: [.All], statOnLevelUp: [StatChange(stat: .ATT, bonus: 1)]),
                                          "Worn Knife":Equipment(type: .Weapon, name: "Worn Knife", rarity: 1, stats: [StatChange(stat: .ATT, bonus: 3),StatChange(stat: .SPD, bonus: 1)], equippable: [.All], statOnLevelUp: [StatChange(stat: .ATT, bonus: 1)]),
                                          
                                          
                                          "Leather Boots":Equipment(type: .Armor, name: "Leather Boots", rarity: 1, stats: [StatChange(stat: .DEF, bonus: 3),StatChange(stat: .SPD, bonus: 1)], equippable: [.All], statOnLevelUp: [StatChange(stat: .DEF, bonus: 1)]),
                                          "Leather Bracers":Equipment(type: .Armor, name: "Leather Bracers", rarity: 1, stats: [StatChange(stat: .DEF, bonus: 3),StatChange(stat: .SPDEF, bonus: 3)], equippable: [.All], statOnLevelUp: [StatChange(stat: .DEF, bonus: 1)]),
                                          "Padded Armor":Equipment(type: .Armor, name: "Padded Armor", rarity: 2, stats: [StatChange(stat: .DEF, bonus: 8),StatChange(stat: .SPDEF, bonus: 6)], equippable: [.All], statOnLevelUp: [StatChange(stat: .DEF, bonus: 1),StatChange(stat: .SPDEF, bonus: 1)]),
                                          
                                          
                                          "Copper Ring":Equipment(type: .Accessory, name: "Copper Ring", rarity: 3, stats: [StatChange(stat: .ATT, bonus: 10),StatChange(stat: .CRITDAMAGE, bonus: 10)], equippable: [.All], statOnLevelUp: [StatChange(stat: .ATT, bonus: 3), StatChange(stat: .CRITDAMAGE, bonus: 1)]),
                                          "Copper Talisman":Equipment(type: .Accessory, name: "Copper Talisman", rarity: 3, stats: [StatChange(stat: .SPATT, bonus: 10),StatChange(stat: .CRITRATE, bonus: 5)], equippable: [.All],statOnLevelUp: [StatChange(stat: .SPATT, bonus: 5)]),
                                          "Copper Bracelet":Equipment(type: .Accessory, name: "Copper Bracelet", rarity: 3, stats: [StatChange(stat: .DEF, bonus: 7),StatChange(stat: .RES, bonus: 5)], equippable: [.All], statOnLevelUp: [StatChange(stat: .DEF, bonus: 2),StatChange(stat: .SPDEF, bonus: 1)]),
                                          
                                          
                                          
    
    ]
    
    var mission: [String:Mission] = [:]
    
    init(){
        
    }
}

@Observable
class GameWorld{
    private var timer: Timer?
    let defaultHero = Hero(idLabel: 0, name: "Default", element: .Dark, role: .Archer, position: .Front, rarity: 0, baseHP: 0, baseATT: 0, baseDEF: 0, baseSPATT: 0, baseSPDEF: 0, baseSPD: 0, baseCRITRATE: 0, baseCRITDAMAGE: 0, baseACC: 0, baseRES: 0, abilities: [])
    var playerTeamRemaining = 0
    var enemyTeamRemaining = 0
    var selectedMissionType = ""
    var selectedChapter = ""
    var selectedMission = ""
    var enemyParty: [Hero?] = []
    var yourTurn = false
    var enemyTurn = false
    var youWon = false
    var currentHero: Hero = Hero(idLabel: 0, name: "Default", element: .Dark, role: .Archer, position: .Front, rarity: 0, baseHP: 100, baseATT: 0, baseDEF: 0, baseSPATT: 0, baseSPDEF: 0, baseSPD: 0, baseCRITRATE: 0, baseCRITDAMAGE: 0, baseACC: 0, baseRES: 0, abilities: [])
    var currentEnemy: Hero = Hero(idLabel: 0, name: "Default", element: .Dark, role: .Archer, position: .Front, rarity: 0, baseHP: 100, baseATT: 0, baseDEF: 0, baseSPATT: 0, baseSPDEF: 0, baseSPD: 0, baseCRITRATE: 0, baseCRITDAMAGE: 0, baseACC: 0, baseRES: 0, abilities: [])
    var selectedAbility: Ability? = Ability(idLabel: 0, name: "", abilityType: .Physical, statMultiplier: [], damageMultiplier: 0, attackTarget: .Single, attackPos: .Front, cooldown: 0)
    var enemySelectedAbility: Ability? = Ability(idLabel: 0, name: "", abilityType: .Physical, statMultiplier: [], damageMultiplier: 0, attackTarget: .Single, attackPos: .Front, cooldown: 0)
    var equipmentReward: Equipment = Equipment(type: .Weapon, name: "", rarity: 1, stats: [], equippable: [])
    var allHeroes: [Hero] = []
    var heroContribution: [Hero] = []
    var turnThreshold = 2000
    var gameData: GameData
    
    var player: Player{
        didSet{
            if let encoded = try? JSONEncoder().encode(player){
                UserDefaults.standard.set(encoded, forKey: "Player")
            }
        }
    }
    
    var lastGameDate: Date{
        didSet{
            if let encoded = try? JSONEncoder().encode(lastGameDate){
                UserDefaults.standard.set(encoded, forKey: "lastGameDate")
            }
        }
    }
    
    
    init(){
        gameData = GameData()
        
        if let savedPlayerData = UserDefaults.standard.data(forKey: "Player"),
           let decodedPlayer = try? JSONDecoder().decode(Player.self, from: savedPlayerData) {
            player = decodedPlayer
        } else {
            player = Player(name: "Player", teamList:[Hero(idLabel: 1000, name: "Shu", element: .Nature, role: .Assassin, position: .Middle, rarity: 4, baseHP: 460, baseATT: 120, baseDEF: 50, baseSPATT: 100, baseSPDEF: 50, baseSPD: 110, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [Ability(idLabel: 1000, name: "Bo Strike", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0), Ability(idLabel: 1001, name: "Kunai Throw", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 175, attackTarget: .Single, attackPos: .Middle, cooldown: 4, statChange: [StatAlteration(name: "SPD Down", duration: 3, statChange: [StatChange(stat: .SPD, bonus: -20)], isBuff: false, image: "arrow.down.circle")], statChangeChance: 50)]),
                                                      Hero(idLabel: 2000, name: "Wendy", element: .Fire, role: .Mage, position: .Middle, rarity: 4, baseHP: 420, baseATT: 70, baseDEF: 40, baseSPATT: 120, baseSPDEF: 65, baseSPD: 88, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [Ability(idLabel: 2000, name: "Fireball", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 105)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0),
                                                                                                                                                                                                                                                                        Ability(idLabel: 2000, name: "Meteor Shower", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 105)], damageMultiplier: 80, attackTarget: .All, attackPos: .Front, cooldown: 5)]),
                                                      Hero(idLabel: 3000, name: "Hal", element: .Water, role: .Tank, position: .Front, rarity: 4, baseHP: 560, baseATT: 90, baseDEF: 70, baseSPATT: 90, baseSPDEF: 65, baseSPD: 90, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [Ability(idLabel: 3000, name: "Shield Bash", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 50),StatMultiplier(stat: .DEF, multiplier: 50)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0),Ability(idLabel: 3001, name: "Shield Slam", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 50),StatMultiplier(stat: .DEF, multiplier: 50)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 4, statChange: [StatAlteration(name: "DEF Down", duration: 3, statChange: [StatChange(stat: .DEF, bonus: -20)], image: "shield.slash")], statChangeChance: 70)]),
                                                      Hero(idLabel: 4000, name: "Misty", element: .Water, role: .Support, position: .Back, rarity: 4, baseHP: 440, baseATT: 65, baseDEF: 45, baseSPATT: 105, baseSPDEF: 55, baseSPD: 94, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [Ability(idLabel: 4000, name: "Staff Strike", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0), Ability(idLabel: 4001, name: "Heal", abilityType: .Heal, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 125)], damageMultiplier: 100, attackTarget: .LowestHealth, attackPos: .Party, cooldown: 4),])
                                                     ],
                            
                            party: [Hero(idLabel: 3000, name: "Hal", element: .Water, role: .Tank, position: .Front, rarity: 4, baseHP: 560, baseATT: 90, baseDEF: 70, baseSPATT: 90, baseSPDEF: 65, baseSPD: 90, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [Ability(idLabel: 3000, name: "Shield Bash", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 50),StatMultiplier(stat: .DEF, multiplier: 50)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0)]),
                                    Hero(idLabel: 1000, name: "Shu", element: .Nature, role: .Assassin, position: .Middle, rarity: 4, baseHP: 460, baseATT: 120, baseDEF: 50, baseSPATT: 100, baseSPDEF: 50, baseSPD: 110, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [Ability(idLabel: 1000, name: "Bo Strike", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0), Ability(idLabel: 1001, name: "Kunai Throw", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 175, attackTarget: .Single, attackPos: .Middle, cooldown: 4)]),
                                    Hero(idLabel: 2000, name: "Wendy", element: .Fire, role: .Mage, position: .Middle, rarity: 4, baseHP: 420, baseATT: 70, baseDEF: 40, baseSPATT: 120, baseSPDEF: 65, baseSPD: 88, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [Ability(idLabel: 2000, name: "Fireball", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 105)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0), Ability(idLabel: 2000, name: "Meteor Shower", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 105)], damageMultiplier: 80, attackTarget: .All, attackPos: .Front, cooldown: 5)]),
                                    Hero(idLabel: 4000, name: "Misty", element: .Water, role: .Support, position: .Back, rarity: 4, baseHP: 440, baseATT: 65, baseDEF: 45, baseSPATT: 105, baseSPDEF: 55, baseSPD: 94, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [Ability(idLabel: 4000, name: "Staff Strike", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0), Ability(idLabel: 4001, name: "Heal", abilityType: .Heal, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 125)], damageMultiplier: 100, attackTarget: .LowestHealth, attackPos: .Party, cooldown: 4)])]
                                    /*Hero(idLabel: 0, name: "Default", element: .Dark, role: .Archer, position: .Front, rarity: 0, baseHP: 0, baseATT: 0, baseDEF: 0, baseSPATT: 0, baseSPDEF: 0, baseSPD: 0, baseCRITRATE: 0, baseCRITDAMAGE: 0, baseACC: 0, baseRES: 0, abilities: [])]*/
                            
            
            )
        }
        
        if let savedDateData = UserDefaults.standard.data(forKey: "lastGameDate"),
           let decodedDate = try? JSONDecoder().decode(Date.self, from:savedDateData) {
            lastGameDate = decodedDate
        } else {
            lastGameDate = Date.now
        }
    }
    
    public func swap(currentHero: Hero, partyHero: Hero){
        if(self.player.party.contains(where: { $0.name == currentHero.name }) == false){
            if partyHero.name == "Default"{
                let index = self.player.party.firstIndex(where: {$0.name == "Default"})
                self.player.party[index ?? 0] = currentHero
            }
        }
        else{
            let index1 = self.player.party.firstIndex(where: {$0.name == currentHero.name})
            let index2 = self.player.party.firstIndex(where: {$0.name == partyHero.name})
            self.player.party[index1 ?? 0] = partyHero
            self.player.party[index2 ?? 0] = currentHero
        }
    }
    
    public func useHero(name: String, level: Int) -> Hero{
        if var using = self.gameData.hero[name]{
            using.level = level
            using.id = UUID()
            return using
        }
        return self.defaultHero
    }
    
    public func swapEquips(type: EquipmentType, hero: Hero, equip: Equipment, index: Int){
        if let teamIndex = self.player.teamList.firstIndex(where: {$0?.name == hero.name}){
            if(type == .Weapon){
                
                if(hero.weapon.name == "Empty"){
                    self.player.teamList[teamIndex]?.weapon = equip
                    self.player.inventoryEquips[index] = Equipment(type: .Weapon, name: "Empty", rarity: 1, stats: [], equippable: [])
                }
                else{
                    self.player.inventoryEquips[index] = self.player.teamList[teamIndex]?.weapon ?? Equipment(type: .Weapon, name: "Empty", rarity: 1, stats: [], equippable: [])
                    self.player.teamList[teamIndex]?.weapon = equip
                }
            }
            else if(type == .Armor){
                if(hero.armor.name == "Empty"){
                    self.player.teamList[teamIndex]?.armor = equip
                    self.player.inventoryEquips[index] = Equipment(type: .Armor, name: "Empty", rarity: 1, stats: [], equippable: [])
                }
                else{
                    self.player.inventoryEquips[index] = self.player.teamList[teamIndex]?.armor ?? Equipment(type: .Armor, name: "Empty", rarity: 1, stats: [], equippable: [])
                    self.player.teamList[teamIndex]?.armor = equip
                }
            }
            else if(type == .Accessory){
                if(hero.accessory.name == "Empty"){
                    self.player.teamList[teamIndex]?.accessory = equip
                    self.player.inventoryEquips[index] = Equipment(type: .Accessory, name: "Empty", rarity: 1, stats: [], equippable: [])
                }
                else{
                    self.player.inventoryEquips[index] = self.player.teamList[teamIndex]?.accessory ?? Equipment(type: .Accessory, name: "Empty", rarity: 1, stats: [], equippable: [])
                    self.player.teamList[teamIndex]?.accessory = equip
                }
            }
        }
    }
    
    public func equipLevelUp(hero: Hero, equip: Equipment){
        if let heroIndex = self.player.teamList.firstIndex(where: {$0?.name == hero.name}){
            if(equip.currentLevel < equip.maximumLevel){
                if(self.player.cash >= equip.upgradeCost){
                    if(equip.type == .Accessory){
                        self.player.teamList[heroIndex]?.accessory.currentLevel += 1
                        if let statChanges = self.player.teamList[heroIndex]?.accessory.statOnLevelUp{
                            for statChange in statChanges{
                                if let statIndex = self.player.teamList[heroIndex]?.accessory.stats.firstIndex(where: {statChange.stat == $0.stat}){
                                    self.player.teamList[heroIndex]?.accessory.stats[statIndex].bonus += statChange.bonus
                                }
                                
                            }
                        }
                        
                    }
                    else if(equip.type == .Armor){
                        self.player.teamList[heroIndex]?.armor.currentLevel += 1
                        if let statChanges = self.player.teamList[heroIndex]?.armor.statOnLevelUp{
                            for statChange in statChanges{
                                if let statIndex = self.player.teamList[heroIndex]?.armor.stats.firstIndex(where: {statChange.stat == $0.stat}){
                                    self.player.teamList[heroIndex]?.armor.stats[statIndex].bonus += statChange.bonus
                                }
                                
                            }
                        }
                    }
                    else if(equip.type == .Weapon){
                        self.player.teamList[heroIndex]?.weapon.currentLevel += 1
                        if let statChanges = self.player.teamList[heroIndex]?.weapon.statOnLevelUp{
                            for statChange in statChanges{
                                if let statIndex = self.player.teamList[heroIndex]?.weapon.stats.firstIndex(where: {statChange.stat == $0.stat}){
                                    self.player.teamList[heroIndex]?.weapon.stats[statIndex].bonus += statChange.bonus
                                }
                                
                            }
                        }
                    }
                }
            }
        }
       
    }
    
    public func setBattle(){
        //Set enemy Party
        if let mission = self.gameData.mission[selectedMission]{
            self.enemyParty = mission.enemyParty
            for index in 0..<self.enemyParty.count{
                if let enemy = self.enemyParty[index]{
                    self.enemyParty[index]?.currentHP = enemy.actualHP
                    self.enemyParty[index]?.turnMeter = 0
                    self.enemyParty[index]?.contribution = 0
                    self.enemyParty[index]?.statChange = []
                }
                
            }
        }
        //Set player Party
        for index in 0..<self.player.party.count{
            if let hero = self.player.teamList.first(where: {$0?.name == self.player.party[index].name}) as? Hero{
                    self.player.party[index] = hero
                
            }
            self.player.party[index].currentHP = self.player.party[index].actualHP
            self.player.party[index].turnMeter = 0
            self.player.party[index].contribution = 0
            self.player.party[index].statChange = []
            for abilityIndex in 0..<self.player.party[index].abilities.count{
                self.player.party[index].abilities[abilityIndex]?.currentCooldown = 0
            }
        }
        
        equipmentReward = Equipment(type: .Weapon, name: "", rarity: 1, stats: [], equippable: [])
        
        
        
    }
    
    public func battle(){
        
        var tookTurn = false
        allHeroes = player.party
        heroContribution = player.party.sorted(by: {$0.contribution > $1.contribution})
        allHeroes.append(contentsOf: enemyParty.compactMap{$0})
        allHeroes.sort{ $0.turnMeter > $1.turnMeter}
        allHeroes.removeAll(where: {$0.currentHP <= 0})
        
        for hero in allHeroes{
            
            if let index = player.party.firstIndex(where: {$0.id == hero.id}){
                if player.party[index].turnMeter >= turnThreshold{
                    for num in 0..<player.party[index].abilities.count{
                        if(player.party[index].abilities[num]?.currentCooldown ?? 0 > 0){
                            player.party[index].abilities[num]?.currentCooldown -= 1
                        }
                    }
                    
                    tookTurn = true
                    
                    print(hero.name)
                    self.takeTurn(hero: player.party[index])
                    break
                }
                
                
            }
            else if let index = enemyParty.firstIndex(where: {$0?.id == hero.id}){
                if (enemyParty[index]?.turnMeter ?? 0) >= turnThreshold{
                    for num in 0..<(enemyParty[index]?.abilities.count ?? 1){
                        if(enemyParty[index]?.abilities[num]?.currentCooldown ?? 0 > 0){
                            enemyParty[index]?.abilities[num]?.currentCooldown -= 1
                        }
                    }
                    tookTurn = true
                    enemyParty[index]?.turnMeter -= turnThreshold
                    self.enemyTurn(hero: enemyParty[index] ?? defaultHero)
                    break
                }
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
            if(tookTurn == false){
                for index in 0..<self.player.party.count{
                    if(self.player.party[index].currentHP <= 0){
                        self.player.party[index].statChange.removeAll()
                    }
                    else{
                        var speedMultiplier = 0
                        for statAlteration in self.player.party[index].statChange{
                            if let statChange = statAlteration?.statChange{
                                for statChanges in statChange{
                                    if(statChanges.stat == .SPD){
                                        speedMultiplier += statChanges.bonus
                                    }
                                }
                            }
                        }
                        self.player.party[index].turnMeter += self.player.party[index].actualSPD * (100 + speedMultiplier) / 100
                    }
                    
                    //print(CGFloat(self.player.party[index].turnMeter) / CGFloat(10000))
                    //print(CGFloat(self.player.party[index].turnMeter) / CGFloat(10000) * (UIScreen.main.bounds.width - 40) - 20)
                }
                for index in 0..<self.enemyParty.count{
                    if(self.enemyParty[index]?.currentHP ?? 0 <= 0){
                        self.enemyParty[index]?.statChange.removeAll()
                    }
                    else{
                        var speedMultiplier = 0
                        if let statAlteration = self.enemyParty[index]?.statChange{
                            for statChanges in statAlteration{
                                if let statChange = statChanges?.statChange{
                                    for changes in statChange{
                                        if changes.stat == .SPD{
                                            speedMultiplier += changes.bonus
                                        }
                                    }
                                }
                            }
                        }
                        self.enemyParty[index]?.turnMeter += (self.enemyParty[index]?.actualSPD ?? 0) * (100 + speedMultiplier) / 100
                    }
                    
                }
                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.battle()
                //}
            }
        }
        
        
        
        
        /*var playerHeroAliveCount = 0
        var enemyHeroAliveCount = 0
        for index in 0..<self.player.party.count{
            if(self.player.party[index].currentHP > 0){
                playerHeroAliveCount += 1
            }
        }
        for index in 0..<self.enemyParty.count{
            if(self.enemyParty[index]?.currentHP ?? 0 > 0){
                enemyHeroAliveCount += 1
            }
            
        }
        if(playerHeroAliveCount == 0 || enemyHeroAliveCount == 0){
            //win or lose
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.battle()
                        }
        }*/
    }
    
    public func enemyTurn(hero: Hero){
        print("Enemy turn")
        self.currentEnemy = hero
        var selecting = true
        let abilities = hero.abilities
        var randNum = Int.random(in: 0..<abilities.count)
        var abilitySelected = hero.abilities[randNum]
        var statDamage = 0
        var attMultiplier = 0
        var spattMultiplier = 0
        var defMultiplier = 0
        var spdefMultiplier = 0
        var spdMultiplier = 0
        if let index = self.enemyParty.firstIndex(where: {$0?.id == self.currentEnemy.id}){
            if let statAlteration = self.enemyParty[index]?.statChange{
                for statChanges in statAlteration{
                    if let statChange = statChanges?.statChange{
                        for changes in statChange{
                            if changes.stat == .ATT{
                                attMultiplier += changes.bonus
                            }
                            else if changes.stat == .DEF{
                                defMultiplier += changes.bonus
                            }
                            else if changes.stat == .SPATT{
                                spattMultiplier += changes.bonus
                            }
                            else if changes.stat == .SPDEF{
                                spdefMultiplier += changes.bonus
                            }
                            else if changes.stat == .SPD{
                                spdMultiplier += changes.bonus
                            }
                        }
                    }
                }
            }
            while(selecting == true){
                if(self.enemyParty[index]?.abilities[randNum]?.currentCooldown ?? 0 > 0){
                    randNum = Int.random(in: 0..<abilities.count)
                    abilitySelected = hero.abilities[randNum]
                }
                else{
                    selecting = false
                    self.enemyParty[index]?.abilities[randNum]?.currentCooldown += self.enemyParty[index]?.abilities[randNum]?.cooldown ?? 0
                }
            }
        }
        
        
        enemySelectedAbility = abilitySelected
        self.enemyTurn = true
        
        if(abilitySelected?.damageMultiplier ?? 0 > 0){
            if let statMult = abilitySelected?.statMultiplier{
                for statMultiplier in statMult{
                    if (statMultiplier.stat == .ATT){
                        statDamage += statMultiplier.multiplier * currentEnemy.actualATT / 100 * (100 + attMultiplier) / 100
                    }
                    else if(statMultiplier.stat == .SPATT){
                        statDamage += statMultiplier.multiplier * currentEnemy.actualSPATT / 100 * (100 + spattMultiplier) / 100
                    }
                    else if(statMultiplier.stat == .DEF){
                        statDamage += statMultiplier.multiplier * currentEnemy.actualDEF / 100 * (100 + defMultiplier) / 100
                    }
                    else if(statMultiplier.stat == .SPDEF){
                        statDamage += statMultiplier.multiplier * currentEnemy.actualSPDEF / 100 * (100 + spdefMultiplier) / 100
                    }
                    else if(statMultiplier.stat == .HP){
                        statDamage += statMultiplier.multiplier * currentEnemy.actualHP / 100
                    }
                    else if(statMultiplier.stat == .SPD){
                        statDamage += statMultiplier.multiplier * currentEnemy.actualSPD / 100 * (100 + spdMultiplier) / 100
                    }
                }
            }
        }
            
            statDamage *= abilitySelected?.damageMultiplier ?? 0
        if(abilitySelected?.attackTarget == .All){
            for index in 0..<self.player.party.count{
                if let abilityType = abilitySelected?.abilityType{
                    self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    
                    /*else{
                     let randNumm = Int.random(in: 1...100)
                     if randNumm <= abilitySelected?.statChangeChance ?? 0{
                     if let statChanges = abilitySelected?.statChange{
                     for statAlteration in statChanges{
                     for enemyIndex in 0..<self.enemyParty.count{
                     self.enemyParty[index]?.statChange.append(statAlteration)
                     }
                     
                     }
                     }
                     }
                     }*/
                    
                }
                
            }
        }
        else if(abilitySelected?.attackTarget == .Row){
            if(abilitySelected?.attackPos == .Front){
                
            }
            
        }
        else if(abilitySelected?.attackTarget == .Single){
            if(abilitySelected?.attackPos == .Front){
                if let index = self.player.party.firstIndex(where: {$0.position == .Front && $0.currentHP > 0}){
                    if let abilityType = abilitySelected?.abilityType{
                        self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    }
                    
                }
                else if let index = self.player.party.firstIndex(where: {$0.position == .Middle && $0.currentHP > 0}){
                    if let abilityType = abilitySelected?.abilityType{
                        self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    }
                    
                }
                else if let index = self.player.party.firstIndex(where: {$0.position == .Back && $0.currentHP > 0}){
                    if let abilityType = abilitySelected?.abilityType{
                        self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    }
                }
                
            }
            else if(abilitySelected?.attackPos == .Middle){
                if let index = self.player.party.firstIndex(where: {$0.position == .Middle && $0.currentHP > 0}){
                    if self.player.party.firstIndex(where:{$0.position == .Front && $0.currentHP > 0}) != nil{
                        if let abilityType = abilitySelected?.abilityType{
                            self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                        }
                    }
                    else if let indexBack = self.player.party.firstIndex(where:{$0.position == .Back && $0.currentHP > 0}){
                        if let abilityType = abilitySelected?.abilityType{
                            self.playerTakeDamage(index: indexBack, statDamage: statDamage, abilityType: abilityType)
                        }
                    }
                    else{
                        if let abilityType = abilitySelected?.abilityType{
                            self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                        }
                    }
                }
                else if let index = self.player.party.firstIndex(where: {$0.position == .Back && $0.currentHP > 0}){
                    if let abilityType = abilitySelected?.abilityType{
                        self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    }
                }
                else if let index = self.player.party.firstIndex(where: {$0.position == .Front && $0.currentHP > 0}){
                    if let abilityType = abilitySelected?.abilityType{
                        self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    }
                }
            }
            else if(abilitySelected?.attackPos == .Back){
                if let index = self.player.party.firstIndex(where: {$0.position == .Back && $0.currentHP > 0}){
                    if let abilityType = abilitySelected?.abilityType{
                        self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    }
                }
                else if let index = self.player.party.firstIndex(where: {$0.position == .Middle && $0.currentHP > 0}){
                    if let abilityType = abilitySelected?.abilityType{
                        self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    }
                }
                else if let index = self.player.party.firstIndex(where: {$0.position == .Front && $0.currentHP > 0}){
                    if let abilityType = abilitySelected?.abilityType{
                        self.playerTakeDamage(index: index, statDamage: statDamage, abilityType: abilityType)
                    }
                }
                
            }
        }
        
        
        print(currentEnemy.statChange)
        if let index = self.enemyParty.firstIndex(where: {$0?.id == self.currentEnemy.id}){
            if let statChanges = self.enemyParty[index]?.statChange{
                for statChangeIndex in statChanges.indices where statChanges[statChangeIndex]?.duration ?? 0 > 0{
                    if let currentDuration = statChanges[statChangeIndex]?.duration {
                        self.enemyParty[index]?.statChange[statChangeIndex]?.duration = currentDuration - 1
                        
                        // If duration is now 0, remove the statChange
                        /*if self.enemyParty[index]?.statChange[statChangeIndex]?.duration ?? 0 <= 0 {
                            self.enemyParty[index]?.statChange.remove(at: statChangeIndex)
                        }*/
                    }
                }
                self.enemyParty[index]?.statChange.removeAll{$0?.duration ?? 0 <= 0}
            }
        }
        var playerHeroAliveCount = 0
        var enemyHeroAliveCount = 0
        for index in 0..<self.player.party.count{
            if(self.player.party[index].currentHP > 0){
                playerHeroAliveCount += 1
            }
        }
        for index in 0..<self.enemyParty.count{
            if(self.enemyParty[index]?.currentHP ?? 0 > 0){
                enemyHeroAliveCount += 1
            }
            
        }
        if(playerHeroAliveCount == 0 || enemyHeroAliveCount == 0){
            //win or lose
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                self.enemyTurn = false
                self.battle()
                        }
        }
        
    }
    
    public func playerTakeDamage(index: Int, statDamage: Int, abilityType: AbilityType){
        let playerElement = self.player.party[index].element
        var finalDamage = statDamage
        var defMult = 0
        var spdefMult = 0
        for statAlteration in self.player.party[index].statChange{
            if let statChange = statAlteration?.statChange{
                for statChanges in statChange{
                    if(statChanges.stat == .DEF){
                        defMult += statChanges.bonus
                    }
                    else if(statChanges.stat == .SPDEF){
                        spdefMult += statChanges.bonus
                    }
                }
            }
        }
        
        finalDamage *= (currentEnemy.elementDamageMultiplier[playerElement] ?? 100)
        finalDamage /= 100
        let randNum = Int.random(in: 1...100)
        if randNum <= currentHero.actualCRITRATE{
            finalDamage *= currentHero.actualCRITDAMAGE
            finalDamage /= 100
        }
            if(abilityType == .Physical){
                finalDamage /= ((self.player.party[index].actualDEF * (100 + defMult) / 100) + 150)
                print("\(self.player.party[index].name) took \(finalDamage) physical damage")
            }
            else{
                finalDamage /= ((self.player.party[index].actualSPDEF * (100 + spdefMult) / 100) + 150)
                print("\(self.player.party[index].name) took \(finalDamage) special damage")
            }
        if let enemyIndex = self.enemyParty.firstIndex(where: {$0?.name == currentEnemy.name}){
            self.enemyParty[enemyIndex]?.contribution += finalDamage
        }
            self.player.party[index].currentHP -= finalDamage
            if(self.player.party[index].currentHP <= 0){
                self.player.party[index].currentHP = 0
            }
        
        if(enemySelectedAbility?.statChange.count ?? 0 > 0){
            if(enemySelectedAbility?.statChange[0]?.isBuff == false){
                let randNumm = Int.random(in: 1...100)
                if randNumm <= enemySelectedAbility?.statChangeChance ?? 0{
                    if let statChanges = enemySelectedAbility?.statChange{
                        for statAlteration in statChanges{
                            self.player.party[index].statChange.append(statAlteration)
                        }
                    }
                }
            }
        }
    }
    
    public func enemyTakeDamage(index: Int, statDamage: Int, abilityType: AbilityType){
        let enemyElement = self.enemyParty[index]?.element ?? .Fire
        var finalDamage = statDamage
        finalDamage *= (currentHero.elementDamageMultiplier[enemyElement] ?? 100)
        finalDamage /= 100
        let randNum = Int.random(in: 1...100)
        if randNum <= currentHero.actualCRITRATE{
            finalDamage *= currentHero.actualCRITDAMAGE
            finalDamage /= 100
        }
        var defMult = 0
        var spdefMult = 0
        if let enemy = self.enemyParty[index]{
            if let statAlteration = self.enemyParty[index]?.statChange{
                for statChanges in statAlteration{
                    if let statChange = statChanges?.statChange{
                        for changes in statChange{
                            if changes.stat == .DEF{
                                defMult += changes.bonus
                            }
                            else if changes.stat == .SPDEF{
                                spdefMult += changes.bonus
                            }
                        }
                    }
                }
            }
            if(abilityType == .Physical){
                finalDamage /= ((enemy.actualDEF * (100 + defMult) / 100) + 150)
                print("\(enemy.name) took \(finalDamage) physical damage")
            }
            else{
                finalDamage /= ((enemy.actualSPDEF * (100 + spdefMult) / 100) + 150)
                print("\(enemy.name) took \(finalDamage) special damage")
            }
            if let heroIndex = self.player.party.firstIndex(where: {$0.name == currentHero.name}){
                self.player.party[heroIndex].contribution += finalDamage
            }
            self.enemyParty[index]?.currentHP -= finalDamage
            if(self.enemyParty[index]?.currentHP ?? 0 <= 0){
                self.enemyParty[index]?.currentHP = 0
            }
        }
        if(selectedAbility?.statChange.count ?? 0 > 0){
            if(selectedAbility?.statChange[0]?.isBuff == false){
                let randNumm = Int.random(in: 1...100)
                if randNumm <= selectedAbility?.statChangeChance ?? 0{
                    if let statChanges = selectedAbility?.statChange{
                        for statAlteration in statChanges{
                            self.enemyParty[index]?.statChange.append(statAlteration)
                        }
                    }
                }
            }
        }
    }
    
    public func takeTurn(hero: Hero){
        self.yourTurn = true
        self.currentHero = hero
    }
    
    public func useAbility(){
        //var finalDamage = 0
        var attMult = 0
        var spattMult = 0
        var defMult = 0
        var spdefMult = 0
        var spdMult = 0
        if let index = player.party.firstIndex(where: {$0.name == currentHero.name}){
            player.party[index].turnMeter -= turnThreshold
            for statAlteration in self.player.party[index].statChange{
                if let statChange = statAlteration?.statChange{
                    for statChanges in statChange{
                        if(statChanges.stat == .ATT){
                            attMult += statChanges.bonus
                        }
                        else if(statChanges.stat == .DEF){
                            defMult += statChanges.bonus
                        }
                        else if(statChanges.stat == .SPATT){
                            spattMult += statChanges.bonus
                        }
                        else if(statChanges.stat == .SPDEF){
                            spdefMult += statChanges.bonus
                        }
                        else if(statChanges.stat == .SPD){
                            spdMult += statChanges.bonus
                        }
                    }
                }
            }
        }
        
        var statDamage = 0
        
        
        if let ability = self.selectedAbility{
            if(ability.damageMultiplier > 0){
                
                    for statMultiplier in ability.statMultiplier{
                        if (statMultiplier.stat == .ATT){
                            statDamage += statMultiplier.multiplier * currentHero.actualATT / 100 * (100 + attMult) / 100
                        }
                        else if(statMultiplier.stat == .SPATT){
                            statDamage += statMultiplier.multiplier * currentHero.actualSPATT / 100 * (100 + spattMult) / 100
                        }
                        else if(statMultiplier.stat == .DEF){
                            statDamage += statMultiplier.multiplier * currentHero.actualDEF / 100 * (100 + defMult) / 100
                        }
                        else if(statMultiplier.stat == .SPDEF){
                            statDamage += statMultiplier.multiplier * currentHero.actualSPDEF / 100 * (100 + spdefMult) / 100
                        }
                        else if(statMultiplier.stat == .HP){
                            statDamage += statMultiplier.multiplier * currentHero.actualHP / 100
                        }
                        else if(statMultiplier.stat == .SPD){
                            statDamage += statMultiplier.multiplier * currentHero.actualSPD / 100 * (100 + spdMult) / 100
                        }
                    }
                statDamage *= ability.damageMultiplier
                if(ability.attackPos == .User){
                    
                }
                else if(ability.attackPos == .Party){
                    if(ability.abilityType == .Heal){
                        if(ability.attackTarget == .LowestHealth){
                            var lowestHealthIndex = 0
                            var lowestHealthPercentage = 110
                            for index in 0..<player.party.count{
                                if(player.party[index].name != "Default" && player.party[index].currentHP > 0){
                                    if(player.party[index].currentHP * 100 / player.party[index].actualHP < lowestHealthPercentage){
                                        lowestHealthPercentage = player.party[index].currentHP * 100 / player.party[index].actualHP
                                        lowestHealthIndex = index
                                    }
                                }
                                
                            }
                            print("Heal \(statDamage / 100)")
                            if let heroIndex = self.player.party.firstIndex(where: {$0.name == currentHero.name}){
                                self.player.party[heroIndex].contribution += statDamage / 100
                            }
                            self.player.party[lowestHealthIndex].currentHP += statDamage / 100
                            if(self.player.party[lowestHealthIndex].currentHP > self.player.party[lowestHealthIndex].actualHP){
                                self.player.party[lowestHealthIndex].currentHP = self.player.party[lowestHealthIndex].actualHP
                            }
                        }
                    }
                }
                else if(ability.attackTarget == .All){
                    for index in 0..<self.enemyParty.count{
                        self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                    }
                }
                else if(ability.attackTarget == .Row){
                    
                }
                else if(ability.attackTarget == .Single){
                    if(ability.attackPos == .Front){
                        if let index = self.enemyParty.firstIndex(where: {$0?.position == .Front && $0?.currentHP ?? 0 > 0}){
                            self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                        }
                        else if let index = self.enemyParty.firstIndex(where: {$0?.position == .Middle && $0?.currentHP ?? 0 > 0}){
                            self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                        }
                        else if let index = self.enemyParty.firstIndex(where: {$0?.position == .Back && $0?.currentHP ?? 0 > 0}){
                            self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                        }
                        
                    }
                    else if(ability.attackPos == .Middle){
                        if let index = self.enemyParty.firstIndex(where: {$0?.position == .Middle && $0?.currentHP ?? 0 > 0}){
                            if self.enemyParty.firstIndex(where: {$0?.position == .Front && $0?.currentHP ?? 0 > 0}) != nil{
                                self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                            }
                            else if let indexBack = self.enemyParty.firstIndex(where: {$0?.position == .Back && $0?.currentHP ?? 0 > 0}){
                                self.enemyTakeDamage(index: indexBack, statDamage: statDamage, abilityType: ability.abilityType)
                            }
                            else{
                                self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                            }
                            
                        }
                        else if let index = self.enemyParty.firstIndex(where: {$0?.position == .Back && $0?.currentHP ?? 0 > 0}){
                            self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                        }
                        else if let index = self.enemyParty.firstIndex(where: {$0?.position == .Front && $0?.currentHP ?? 0 > 0}){
                            self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                        }
                    }
                    else if(ability.attackPos == .Back){
                        if let index = self.enemyParty.firstIndex(where: {$0?.position == .Back && $0?.currentHP ?? 0 > 0}){
                            self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                        }
                        else if let index = self.enemyParty.firstIndex(where: {$0?.position == .Middle && $0?.currentHP ?? 0 > 0}){
                            self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                        }
                        else if let index = self.enemyParty.firstIndex(where: {$0?.position == .Front && $0?.currentHP ?? 0 > 0}){
                            self.enemyTakeDamage(index: index, statDamage: statDamage, abilityType: ability.abilityType)
                        }
                    }
                }
                
                
                
                
                //Element Multiplier
                
                
                // Divide by (Defense + 300)
                
            }
        }
        
        if let index = currentHero.abilities.firstIndex(where: {$0?.name == selectedAbility?.name}){
            let heroIndex = self.player.party.firstIndex(where: {$0.name == currentHero.name})
            self.player.party[heroIndex ?? 0].abilities[index]?.currentCooldown += currentHero.abilities[index]?.cooldown ?? 0
        }
        
        
        
        
        print(currentHero.statChange)
        if let index = self.player.party.firstIndex(where: {$0.id == self.currentHero.id}){
                for statChangeIndex in self.player.party[index].statChange.indices where self.player.party[index].statChange[statChangeIndex]?.duration ?? 0 > 0{
                        self.player.party[index].statChange[statChangeIndex]?.duration -= 1
                        
                        // If duration is now 0, remove the statChange
                        /*if self.player.party[index].statChange[statChangeIndex]?.duration ?? 0 <= 0 {
                            self.player.party[index].statChange.remove(at: statChangeIndex)
                        }*/
                }
            self.player.party[index].statChange.removeAll{$0?.duration ?? 0 <= 0}
        }
        
        var playerHeroAliveCount = 0
        var enemyHeroAliveCount = 0
        for index in 0..<self.player.party.count{
            if(self.player.party[index].currentHP > 0){
                playerHeroAliveCount += 1
            }
        }
        for index in 0..<self.enemyParty.count{
            if(self.enemyParty[index]?.currentHP ?? 0 > 0){
                enemyHeroAliveCount += 1
            }
            
        }
        self.yourTurn = false
        if(playerHeroAliveCount == 0 || enemyHeroAliveCount == 0){
            if(enemyHeroAliveCount == 0){
                
                self.wonBattle()
                
                
            }
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.00) {
                self.battle()
            }
        }
        
        
    }
    
    public func wonBattle(){
        self.youWon = true
        self.player.currentEnergy -= self.gameData.mission[selectedMission]?.energyCost ?? 0
        self.player.currentExp += self.gameData.mission[selectedMission]?.expReward ?? 0
        if(self.player.currentExp >= self.gameData.expToNextLevel[self.player.level]){
            self.player.currentExp -= self.gameData.expToNextLevel[self.player.level]
            self.player.level += 1
            self.player.maximumEnergy += 1
            self.player.currentEnergy += self.player.maximumEnergy / 4
            self.player.gems += 100
            if(self.player.level % 5 == 0){
                self.player.gems += 150
            }
        }
        self.player.cash += self.gameData.mission[selectedMission]?.cashReward ?? 0
        
        if self.player.missionsBeat.contains(selectedMission) == false{
            self.player.missionsBeat.insert(selectedMission)
            if let num = self.player.missionsUnlocked[selectedChapter]{
                self.player.missionsUnlocked[selectedChapter] = num + 1
            }
            if(selectedMission == "1-8"){
                self.player.chaptersUnlocked["Story"]? += 1
            }
        }
        
        let randNum = Int.random(in: 1...100)
        var lowestRoll = 110
        if let rewards = self.gameData.mission[selectedMission]?.equipmentReward{
            for key in rewards.keys{
                if(randNum <= key && key < lowestRoll){
                    lowestRoll = key
                }
            }
            if(lowestRoll != 110){
                if let equip = rewards[lowestRoll]{
                    self.player.inventoryEquips.append(equip ?? Equipment(type: .Weapon, name: "", rarity: 1, stats: [], equippable: []))
                    equipmentReward = equip ?? equipmentReward
                }
                
            }
        }
        
        
        for index in 0..<self.player.party.count{
            if let teamIndex = self.player.teamList.firstIndex(where: {self.player.party[index].name == $0?.name}){
                self.player.teamList[teamIndex]?.currentEXP += ((self.gameData.mission[selectedMission]?.expReward ?? 0) * 10)
                var expNeeded = self.player.teamList[teamIndex]?.baseStats ?? 0
                expNeeded *= self.player.teamList[teamIndex]?.level ?? 0
                expNeeded *= Int(log2(Float(self.player.teamList[teamIndex]?.level ?? 0)))
                expNeeded = expNeeded / 4 + 100
                //let expNeeded = self.player.teamList[teamIndex]?.baseStats * self.player.teamList[teamIndex]?.level * Int(log2(Float(self.player.teamList[teamIndex]?.level))) / 4 + 100
                if (self.player.teamList[teamIndex]?.currentEXP ?? 0 >= expNeeded){
                    self.player.teamList[teamIndex]?.currentEXP -= expNeeded
                    self.player.teamList[teamIndex]?.level += 1
                }
            }
            
            
            
        }
    }
    
    public func loadGame(){
        self.gameData.ability = ["Default": Ability(idLabel: 0, name: "Default", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0),
                                 "Bo Strike": Ability(idLabel: 1000, name: "Bo Strike", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0),
                                 "Kunai Throw": Ability(idLabel: 1001, name: "Kunai Throw", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 175, attackTarget: .Single, attackPos: .Middle, cooldown: 4, statChange: [self.gameData.statChanges["SPD Down"]], statChangeChance: 50),
                                 "Fireball": Ability(idLabel: 2000, name: "Fireball", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 105)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0),
                                 "Meteor Shower": Ability(idLabel: 2000, name: "Meteor Shower", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 105)], damageMultiplier: 80, attackTarget: .All, attackPos: .Front, cooldown: 5),
                                 "Shield Bash": Ability(idLabel: 3000, name: "Shield Bash", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 50),StatMultiplier(stat: .DEF, multiplier: 50)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0),
                                 "Shield Slam": Ability(idLabel: 3001, name: "Shield Slam", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 50),StatMultiplier(stat: .DEF, multiplier: 50)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 4, statChange: [self.gameData.statChanges["DEF Down"]], statChangeChance: 70),
                                 "Staff Strike": Ability(idLabel: 4000, name: "Staff Strike", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0),
                                 "Heal": Ability(idLabel: 4001, name: "Heal", abilityType: .Heal, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 125)], damageMultiplier: 100, attackTarget: .LowestHealth, attackPos: .Party, cooldown: 4),
                                 
                                 "Bite": Ability(idLabel: 10000, name: "Bite", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0),
                                 "Slime Spit": Ability(idLabel: 10001, name: "Slime Spit", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Front, cooldown: 0, statChange: [self.gameData.statChanges["SPD Down"]], statChangeChance: 35),
                                 "Corrosive Slime": Ability(idLabel: 10002, name: "Corrosive Slime", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .SPATT, multiplier: 100)], damageMultiplier: 100, attackTarget: .Single, attackPos: .Middle, cooldown: 0, statChange: [self.gameData.statChanges["DEF Down"]], statChangeChance: 30),
                                 "Horn Jab": Ability(idLabel: 10003, name: "Horn Jab", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 175, attackTarget: .Single, attackPos: .Front, cooldown: 0),
                                 "Deadly Assault": Ability(idLabel: 10004, name: "Deadly Assault", abilityType: .Physical, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 350, attackTarget: .Single, attackPos: .Back, cooldown: 5),
                                 "Thunderous Roar": Ability(idLabel: 10005, name: "Thunderous Roar", abilityType: .Special, statMultiplier: [StatMultiplier(stat: .ATT, multiplier: 100)], damageMultiplier: 150, attackTarget: .All, attackPos: .Front, cooldown: 5,statChange: [self.gameData.statChanges["ATT Down"]], statChangeChance: 70),

]
        self.gameData.hero = ["Default": Hero(idLabel: 0, name: "Default", element: .Dark, role: .Archer, position: .Front, rarity: 0, baseHP: 0, baseATT: 0, baseDEF: 0, baseSPATT: 0, baseSPDEF: 0, baseSPD: 0, baseCRITRATE: 0, baseCRITDAMAGE: 0, baseACC: 0, baseRES: 0, abilities: []),
            
                              "Shu": Hero(idLabel: 1000, name: "Shu", element: .Nature, role: .Assassin, position: .Middle, rarity: 4, baseHP: 460, baseATT: 120, baseDEF: 50, baseSPATT: 100, baseSPDEF: 50, baseSPD: 110, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Bo Strike"]]),
                              "Wendy": Hero(idLabel: 2000, name: "Wendy", element: .Fire, role: .Mage, position: .Middle, rarity: 4, baseHP: 420, baseATT: 70, baseDEF: 40, baseSPATT: 120, baseSPDEF: 65, baseSPD: 88, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Fireball"]]),
                              "Hal": Hero(idLabel: 3000, name: "Hal", element: .Water, role: .Tank, position: .Front, rarity: 4, baseHP: 560, baseATT: 90, baseDEF: 70, baseSPATT: 90, baseSPDEF: 65, baseSPD: 90, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Shield Bash"]]),
                              "Misty": Hero(idLabel: 4000, name: "Misty", element: .Water, role: .Support, position: .Back, rarity: 4, baseHP: 440, baseATT: 65, baseDEF: 45, baseSPATT: 105, baseSPDEF: 55, baseSPD: 94, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Shield Bash"]]),
                     
                     
                              "Ravenous Dog F": Hero(idLabel: 10000, name: "Ravenous Dog", element: .Fire, role: .Warrior, position: .Front, rarity: 3, baseHP: 390, baseATT: 75, baseDEF: 40, baseSPATT: 60, baseSPDEF: 35, baseSPD: 100, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Bite"]]),
                              "Ravenous Dog B": Hero(idLabel: 10001, name: "Ravenous Dog", element: .Fire, role: .Warrior, position: .Back, rarity: 3, baseHP: 390, baseATT: 75, baseDEF: 40, baseSPATT: 60, baseSPDEF: 35, baseSPD: 100, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Bite"]]),
                              "Ravenous Dog M": Hero(idLabel: 10002, name: "Ravenous Dog", element: .Fire, role: .Warrior, position: .Middle, rarity: 3, baseHP: 390, baseATT: 75, baseDEF: 40, baseSPATT: 60, baseSPDEF: 35, baseSPD: 100, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Bite"]]),
                              "Slime M": Hero(idLabel: 10003, name: "Slime", element: .Nature, role: .Archer, position: .Middle, rarity: 3, baseHP: 350, baseATT: 75, baseDEF: 30, baseSPATT: 80, baseSPDEF: 40, baseSPD: 85, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Slime Spit"]]),
                              "Slime B": Hero(idLabel: 10004, name: "Slime", element: .Nature, role: .Archer, position: .Back, rarity: 3, baseHP: 350, baseATT: 75, baseDEF: 30, baseSPATT: 80, baseSPDEF: 40, baseSPD: 85, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Slime Spit"]]),
                              "Blue Slime M": Hero(idLabel: 10005, name: "Blue Slime", element: .Water, role: .Archer, position: .Middle, rarity: 3, baseHP: 350, baseATT: 75, baseDEF: 30, baseSPATT: 80, baseSPDEF: 40, baseSPD: 85, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Slime Spit"]]),
                              "Blue Slime B": Hero(idLabel: 10006, name: "Blue Slime", element: .Water, role: .Archer, position: .Back, rarity: 3, baseHP: 350, baseATT: 75, baseDEF: 30, baseSPATT: 80, baseSPDEF: 40, baseSPD: 85, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Slime Spit"]]),
                              "Slime Magus M": Hero(idLabel: 10007, name: "Slime Magus", element: .Water, role: .Mage, position: .Back, rarity: 3, baseHP: 325, baseATT: 60, baseDEF: 30, baseSPATT: 100, baseSPDEF: 45, baseSPD: 83, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Slime Spit"]]),
                              "Slime Magus B": Hero(idLabel: 10008, name: "Slime Magus", element: .Water, role: .Mage, position: .Back, rarity: 3, baseHP: 325, baseATT: 60, baseDEF: 30, baseSPATT: 100, baseSPDEF: 45, baseSPD: 83, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Corrosive Slime"]]),
                              "Ravenous Beast F": Hero(idLabel: 10009, name: "Ravenous Beast", element: .Nature, role: .Warrior, position: .Front, rarity: 3, baseHP: 480, baseATT: 76, baseDEF: 66, baseSPATT: 60, baseSPDEF: 56, baseSPD: 88, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Bite"]]),
                              "Bloodhorn": Hero(idLabel: 10010, name: "Bloodhorn", element: .Dark, role: .Warrior, position: .Front, rarity: 4, baseHP: 1300, baseATT: 121, baseDEF: 84, baseSPATT: 60, baseSPDEF: 77, baseSPD: 91, baseCRITRATE: 15, baseCRITDAMAGE: 150, baseACC: 0, baseRES: 0, abilities: [self.gameData.ability["Horn Jab"],self.gameData.ability["Deadly Assault"],self.gameData.ability["Thunderous Roar"]]),
                              
                     
                     
        ]
        self.gameData.mission = ["1-1": Mission(name: "1-1", description: "The king has summoned your party to investigate some attacks on a nearby village. You encounter some ravenous dogs.",imageRewards: ["exp","dollarsign.square.fill"], energyCost: 3, enemyParty: [self.useHero(name: "Ravenous Dog F", level: 1), self.useHero(name: "Ravenous Dog M", level: 1)], expReward: 15, cashReward: 100, equipmentReward:[16:self.gameData.equipment["Bent Blade"],32:self.gameData.equipment["Worn Knife"]]),
                                 "1-2": Mission(name: "1-2", description: "The village is infested with many monsters, including slimes.",imageRewards: ["exp","dollarsign.square.fill"], energyCost: 3, enemyParty: [self.useHero(name: "Ravenous Dog F", level: 2), self.useHero(name: "Slime M", level: 2), self.useHero(name: "Slime M", level: 1)], expReward: 16, cashReward: 120,equipmentReward:[16:self.gameData.equipment["Bent Blade"],32:self.gameData.equipment["Worn Knife"]]),
                                 "1-3": Mission(name: "1-3", description: "You hear some screams deeper in the village.",imageRewards: ["exp","dollarsign.square.fill"], energyCost: 3, enemyParty: [self.useHero(name: "Ravenous Dog F", level: 3), self.useHero(name: "Ravenous Dog F", level: 2), self.useHero(name: "Blue Slime B", level: 3)], expReward: 17, cashReward: 140,equipmentReward:[17:self.gameData.equipment["Bent Blade"],33:self.gameData.equipment["Worn Knife"]]),
                                 "1-4": Mission(name: "1-4", description: "You follow in the direction of the screams, but monsters block your path.",imageRewards: ["exp","dollarsign.square.fill"], energyCost: 3, enemyParty: [self.useHero(name: "Ravenous Dog F", level: 4), self.useHero(name: "Ravenous Dog F", level: 3), self.useHero(name: "Blue Slime M", level: 3), self.useHero(name: "Slime B", level: 4)], expReward: 18, cashReward: 160,equipmentReward:[10:self.gameData.equipment["Padded Armor"],22:self.gameData.equipment["Bent Blade"],34:self.gameData.equipment["Worn Knife"]]),
                                 "1-5": Mission(name: "1-5", description: "You hear a villager cry out for help. You're almost there.",imageRewards: ["exp","dollarsign.square.fill"], energyCost: 3, enemyParty: [self.useHero(name: "Ravenous Dog F", level: 5), self.useHero(name: "Slime M", level: 4), self.useHero(name: "Blue Slime M", level: 4), self.useHero(name: "Slime Magus B", level: 4)], expReward: 18, cashReward: 160,equipmentReward:[16:self.gameData.equipment["Leather Boots"],32:self.gameData.equipment["Leather Bracers"] ]),
                                 "1-6": Mission(name: "1-6", description: "You were too late. You see the villager torn apart by the ravenous beast.",imageRewards: ["exp","dollarsign.square.fill"], energyCost: 3, enemyParty: [self.useHero(name: "Ravenous Beast F", level: 6), self.useHero(name: "Ravenous Dog F", level: 5), self.useHero(name: "Slime M", level: 5), self.useHero(name: "Slime Magus B", level: 5)], expReward: 20, cashReward: 180,equipmentReward:[17:self.gameData.equipment["Leather Boots"],33:self.gameData.equipment["Leather Bracers"] ]),
                                 "1-7": Mission(name: "1-7", description: "The village is in complete chaos, filled with various monsters.",imageRewards: ["exp","dollarsign.square.fill"], energyCost: 3, enemyParty: [self.useHero(name: "Ravenous Beast F", level: 6), self.useHero(name: "Ravenous Beast F", level: 6), self.useHero(name: "Blue Slime M", level: 6), self.useHero(name: "Slime Magus B", level: 6)], expReward: 22, cashReward:200, equipmentReward:[10:self.gameData.equipment["Padded Armor"],22:self.gameData.equipment["Leather Boots"],34:self.gameData.equipment["Leather Bracers"] ]),
                                 "1-8": Mission(name: "1-8", description: "A towering minotaur is in view. It may be the leader.",imageRewards: ["exp","dollarsign.square.fill"], energyCost: 6, enemyParty: [self.useHero(name: "Bloodhorn", level: 8)], expReward: 50, cashReward: 500,equipmentReward:[10:self.gameData.equipment["Copper Bracelet"],20:self.gameData.equipment["Copper Ring"], 30: self.gameData.equipment["Copper Talisman"] ]),
                                 "1-A": Mission(name: "1-A", description: "The enemy's leader has been defeated. Other heroes and adventurers help clear the rest of the monsters from the village. You return to the kingdom, reporting what has occurred to the village. The king rewards your party with treasure.",imageRewards: [], energyCost: 99, enemyParty: [], expReward: 0, cashReward: 0),
                                 
                                 "2-1": Mission(name: "2-1", description: "",imageRewards: [], energyCost: 99, enemyParty: [], expReward: 0, cashReward: 0),
            
        ]
        let diffTime = lastGameDate.timeIntervalSinceNow
        let awayFor = Int(-diffTime)
        let energyTimer = 180
        let addEnergyAmount = awayFor/energyTimer
        let origEnergy = self.player.currentEnergy
        print(self.player.missionsUnlocked)
        self.player.currentEnergy += addEnergyAmount
        if(self.player.currentEnergy > self.player.maximumEnergy){
            if(origEnergy < self.player.maximumEnergy){
                self.player.currentEnergy = self.player.maximumEnergy
            }
            else{
                self.player.currentEnergy = origEnergy
            }
            
        }
    }
    
    public func startEnergyTimer(){
        self.timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            self.lastGameDate = Date.now
            self.player.energyTime -= 1
            if(self.player.currentEnergy >= self.player.maximumEnergy){
                self.player.energyTime = 1
            }
            if(self.player.energyTime <= 0){
                self.player.energyTime = 240
                if(self.player.currentEnergy < self.player.maximumEnergy){
                    self.player.currentEnergy += 1
                }
                
            }
            
        }
    }

}
