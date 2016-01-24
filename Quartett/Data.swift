//
//  Data.swift
//  Quartett
//
//  Created by Sebastian Haußmann on 22.01.16.
//  Copyright © 2016 Moritz Martin. All rights reserved.
//

import UIKit
import CoreData

class Data{
    
    func loadStandardData(){
        // DB functions
        print("----------------- Reset Data -----------------")
        // delete all Data
        deleteObjectsFromEntity("Ranking")
        deleteObjectsFromEntity("Card")
        deleteObjectsFromEntity("Cardset")
        deleteObjectsFromEntity("Attribute")
        deleteObjectsFromEntity("Game")
        
        saveRanking("Hans", rounds: 15, time: 20.0)
        saveRanking("Peter", rounds: 10, time: 30.0)
        saveRanking("Willem", rounds: 5, time: 10.0)
        saveRanking("Jörg", rounds: 35, time: 100.0)
        
        saveCard(0, cardset: 0, name: "Robben", info: "Arjen Robben ist ein niederländischer Fußballspieler. Er steht seit dem 28. August 2009 beim Bundesligisten FC Bayern München unter Vertrag und gehört zum Kader der niederländischen A-Nationalmannschaft.", image: "rob", values: "92,92,86,32,82,64")
        saveCard(1, cardset: 0, name: "Ribery", info: "info1", image: "rib", values: "87,91,77,25,84,61")
        saveCard(2, cardset: 0, name: "Boateng", info: "info2", image: "boateng", values: "79,68,50,87,69,84")
        saveCard(3, cardset: 0, name: "Alaba", info: "info3", image: "alaba", values: "86,83,72,84,81,72")
        saveCard(4, cardset: 0, name: "Lewandowski", info: "info4", image: "lewa", values: "80,84,85,38,74,80")
        saveCard(5, cardset: 0, name: "Mueller", info: "info5", image: "mueller", values: "77,79,84,46,80,72")
        
        saveCardset(0, name: "Bayern", image: "CardSet0")
        
        
        saveCard(6, cardset: 1, name: "Reus", info: "Marco Reus (* 31. Mai 1989 in Dortmund) ist ein deutscher Fußballspieler. Er steht seit 2012 bei Borussia Dortmund unter Vertrag und spielt seit 2011 für die deutsche Fußballnationalmannschaft.Marco Reus (* 31. Mai 1989 in Dortmund) ist ein deutscher Fußballspieler. Er steht seit 2012 bei Borussia Dortmund unter Vertrag und spielt seit 2011 für die deutsche Fußballnationalmannschaft.Marco Reus (* 31. Mai 1989 in Dortmund) ist ein deutscher Fußballspieler. Er steht seit 2012 bei Borussia Dortmund unter Vertrag und spielt seit 2011 für die deutsche Fußballnationalmannschaft.", image: "reus", values: "90,88,60,42,97,31,71,22,44,66,44,87,1,22,44")
        saveCard(7, cardset: 1, name: "Hummels", info: "info1", image: "pic1", values: "11,12,13,14,15,16,31,65,88,23,57,23,88,32,23")
        saveCard(8, cardset: 1, name: "Schmelzer", info: "info2", image: "pic2", values: "1,2,3,4,5,6,21,77,44,22,1,55,77,44,99")
        saveCard(9, cardset: 1, name: "Aubameyang", info: "info3", image: "pic3", values: "70,90,70,90,70,90,1,65,88,33,55,33,56,33,44")
        saveCard(10, cardset: 1, name: "Kagawa", info: "info4", image: "pic4", values: "66,77,88,99,88,77,2,44,77,88,99,88,33,66,44")
        saveCard(11, cardset: 1, name: "buerki", info: "info5", image: "pic5", values: "66,77,88,99,88,77,5,44,55,66,77,55,77,66,22")
        
        saveCardset(1, name: "Dortmund",image: "CardSet1")
        
        
        saveAttribute(0, cardset: 0, name: "PAC", icon: "", unit: "", condition: true)
        saveAttribute(1, cardset: 0, name: "DRI", icon: "", unit: "", condition: true)
        saveAttribute(2, cardset: 0, name: "SHO", icon: "", unit: "", condition: true)
        saveAttribute(3, cardset: 0, name: "DEF", icon: "", unit: "", condition: true)
        saveAttribute(4, cardset: 0, name: "PAS", icon: "", unit: "", condition: true)
        saveAttribute(5, cardset: 0, name: "PHY", icon: "", unit: "", condition: true)
        
        saveAttribute(6, cardset: 1, name: "PAC", icon: "", unit: "", condition: true)
        saveAttribute(7, cardset: 1, name: "DRI", icon: "", unit: "", condition: true)
        saveAttribute(8, cardset: 1, name: "SHO", icon: "", unit: "", condition: true)
        saveAttribute(9, cardset: 1, name: "DEF", icon: "", unit: "", condition: true)
        saveAttribute(10, cardset: 1, name: "PAS", icon: "", unit: "", condition: true)
        saveAttribute(11, cardset: 1, name: "PHY", icon: "", unit: "", condition: true)
        saveAttribute(12, cardset: 1, name: "bla", icon: "", unit: "", condition: false)
        saveAttribute(13, cardset: 1, name: "sdg", icon: "", unit: "", condition: false)
        saveAttribute(14, cardset: 1, name: "gfh", icon: "", unit: "", condition: false)
        saveAttribute(15, cardset: 1, name: "dsa", icon: "", unit: "", condition: false)
        saveAttribute(16, cardset: 1, name: "sdhdh", icon: "", unit: "", condition: false)
        saveAttribute(17, cardset: 1, name: "bdfs", icon: "", unit: "", condition: false)
        saveAttribute(18, cardset: 1, name: "wqrqwr", icon: "", unit: "", condition: false)
        saveAttribute(19, cardset: 1, name: "qwt", icon: "", unit: "", condition: false)
        saveAttribute(20, cardset: 1, name: "bwqqwt", icon: "", unit: "", condition: false)
        
        
        
        saveAttribute(20, cardset: 2, name: "PAC", icon: "", unit: "", condition: true)
        saveAttribute(21, cardset: 2, name: "PAS", icon: "", unit: "", condition: true)
        saveAttribute(22, cardset: 2, name: "SHO", icon: "", unit: "", condition: true)
        saveAttribute(23, cardset: 2, name: "DRI", icon: "", unit: "", condition: true)
        saveAttribute(24, cardset: 2, name: "DEF", icon: "", unit: "", condition: true)
        saveAttribute(25, cardset: 2, name: "PHY", icon: "", unit: "", condition: true)
        
        
        
        saveCardset(2, name: "Allstars", image: "CardSet3")
        
        
        saveCard(12, cardset: 2, name: "Messi", info: "Lionel Leo Andrés Messi Cuccittini  (* 24. Juni 1987 in Rosario) ist ein argentinischer Fußballspieler, der auch die spanische Staatsangehörigkeit besitzt. Messi spielt seit seinem 14. Lebensjahr für den FC Barcelona. Mit 24 Jahren wurde er Rekordtorschütze des FC Barcelona, mit 25 der jüngste Spieler in der La-Liga-Geschichte, der 200 Tore erzielte. Inzwischen ist Messi Rekordtorschütze der Primera División." , image: "messi", values: "92,86,88,95,24,62")
        saveCard(13, cardset: 2, name: "Ronaldo", info: "Cristiano Ronaldo dos Santos Aveiro (* 5. Februar 1985 in Funchal, Portugal) ist ein portugiesischer Fußballspieler. Er steht nach dem bis zu diesem Zeitpunkt teuersten Transfer seit Sommer 2009 bei Real Madrid unter Vertrag. Er ist Kapitän und Rekordtorschütze der portugiesischen Nationalmannschaft. In der Jugendakademie von Sporting Lissabon ausgebildet, wurde Ronaldo mit 18 Jahren von Manchester United unter Vertrag genommen und entwickelte sich dort zu einem Spitzenfußballer. Zu Beginn seiner Karriere im rechten Mittelfeld eingesetzt, wechselte er später auf den linken Flügel und wurde einer der torgefährlichsten Spieler seiner Zeit.", image: "ronaldo", values: "92,80,93,90,33,78")
        saveCard(14, cardset: 2, name: "Suarez", info: "Luis Alberto „Lucho“[1] Suárez Díaz (* 24. Januar 1987 in Salto) ist ein uruguayischer Fußballspieler. Seit Juli 2014 steht der Stürmer beim spanischen Verein FC Barcelona in der Primera Division unter Vertrag.[2] Er trägt den Spitznamen El Pistolero („der Pistolenschütze“), an den seine Handbewegungen beim Torjubel erinnern.[3] Luis Suárez ist Rekordtorschütze der uruguayischen Nationalmannschaft, genießt in seinem Heimatland höchste Anerkennung und ist für seine herausragenden fußballerischen Leistungen international bereits mit zahlreichen renommierten Auszeichnungen bedacht worden.", image: "suarez", values: "82,79,88,88,42,79")
        saveCard(15, cardset: 2, name: "Robben", info: "Arjen Robben ist ein niederländischer Fußballspieler. Er steht seit dem 28. August 2009 beim Bundesligisten FC Bayern München unter Vertrag und gehört zum Kader der niederländischen A-Nationalmannschaft.", image: "rob", values: "92,82,86,92,32,64")
        saveCard(16, cardset: 2, name: "Hazard", info: "Eden Michael Hazard (* 7. Januar 1991 in La Louvière) ist ein belgischer Fußballspieler. Er steht beim englischen Premier-League-Verein FC Chelsea unter Vertrag und ist in der belgischen Nationalmannschaft aktiv.", image: "hazard", values: "90,84,82,92,32,64")
        saveCard(17, cardset: 2, name: "Ibrahimovic", info: "Zlatan Ibrahimović (* 3. Oktober 1981 in Malmö)[1] ist ein schwedisch-bosnischer Fußballspieler, der beim französischen Erstligisten Paris Saint-Germain unter Vertrag steht. Als erster und einziger Spieler wurde der Stürmer zehnmal mit dem Guldbollen als schwedischer Fußballer des Jahres ausgezeichnet, davon neunmal in Folge. Er gilt als einer der besten Stürmer der Welt und besticht insbesondere durch seine starke Technik und seine spektakulären Spielaktionen", image: "ibrahimovic", values: "73,81,90,85,31,86")
        saveCard(18, cardset: 2, name: "Neymar", info: "Neymar da Silva Santos Júnior (* 5. Februar 1992 in Mogi das Cruzes), kurz Neymar oder Neymar Jr., ist ein brasilianischer Fußballspieler. Der Stürmer steht beim FC Barcelona in der spanischen Primera División unter Vertrag und spielt für die brasilianische Nationalmannschaft.", image: "neymar", values: "90,72,80,92,30,58")
        saveCard(19, cardset: 2, name: "David Silva", info: "David Josué Jiménez Silva, kurz David Silva (* 8. Januar 1986 in Arguineguín, Gran Canaria, Spanien) ist ein spanischer Fußballspieler. Er spielt beim englischen Erstligisten Manchester City. Der agile Silva glänzt sowohl im Verein als auch in der Nationalmannschaft als Vorlagen- und Flankengeber sowie als Schütze aus der Distanz. Seine Mutter ist japanischer Herkunft.", image: "davidsilva", values: "73,89,74,89,32,58")
        saveCard(20, cardset: 2, name: "Thiago Silva", info: "Thiago Emiliano da Silva (* 22. September 1984 in Rio de Janeiro) ist ein brasilianischer Fußballspieler. Der Innenverteidiger steht seit 2012 beim französischen Erstligisten Paris Saint-Germain unter Vertrag und war Kapitän der brasilianischen Fußballnationalmannschaft.", image: "thiagosilva", values: "74,73,57,73,90,79")
        saveCard(21, cardset: 2, name: "Iniesta", info: "Andrés Iniesta Luján (* 11. Mai 1984 in Fuentealbilla, Provinz Albacete) ist ein spanischer Fußballspieler. Der beim FC Barcelona unter Vertrag stehende offensive Mittelfeldspieler wird meist im zentralen Mittelfeld eingesetzt, spielt aber gelegentlich auf der linken Seite, auch als Flügelstürmer. Im Finale der WM 2010 gegen die Niederlande erzielte Iniesta kurz vor Ende der Verlängerung das Siegtor für die spanische Fußballnationalmannschaft, die dadurch erstmals Weltmeister wurde. Iniesta wurde bei der Europameisterschaft 2012 zum zweiten Mal nach 2008 Europameister und zudem zum besten Spieler des Turniers gewählt. Gemeinsam mit Lionel Messi, Xavi, Gerard Piqué und Clarence Seedorf hält Andrés Iniesta mit vier Erfolgen den Rekord der meisten Champions-League-Titel.", image: "iniesta", values: "75,87,72,90,59,63")
        saveCard(22, cardset: 2, name: "Rodriguez", info: "James David Rodríguez Rubio (* 12. Juli 1991 in Cúcuta), kurz James Rodríguez oder James, ist ein kolumbianischer Fußballspieler, der seit Sommer 2014 bei Real Madrid unter Vertrag steht.", image: "rodriguez", values: "78,84,86,85,40,72")
        saveCard(23, cardset: 2, name: "Lewandowski", info: "Robert Lewandowski (* 21. August 1988 in Warschau) ist ein polnischer Fußballspieler. Der Stürmer steht seit der Saison 2014/15 beim Bundesligisten FC Bayern München unter Vertrag und ist seit 2014 Kapitän der polnischen A-Nationalmannschaft.", image: "lewa", values: "80,74,85,84,38,80")
        saveCard(24, cardset: 2, name: "Boateng", info: "Jérôme Agyenim Boateng (* 3. September 1988 in Berlin) ist ein deutscher Fußballspieler. Er steht seit 2011 beim FC Bayern München unter Vertrag und spielt in der Innenverteidigung, seiner ursprünglichen Position. Zu Beginn seiner Profikarriere wurde er aber auch häufig auf der rechten und linken Abwehrseite eingesetzt. Zuvor war er für seinen Jugendverein Hertha BSC, den Hamburger SV und in England für Manchester City aktiv gewesen. 2013 gewann er mit den Münchnern das Triple aus Deutscher Meisterschaft, DFB-Pokal und der UEFA Champions League. Mit der deutschen Nationalmannschaft wurde er 2014 in Brasilien Weltmeister.", image: "boateng", values: "79,68,50,87,69,84")
        saveCard(25, cardset: 2, name: "Kroos", info: "Toni Kroos (* 4. Januar 1990 in Greifswald) ist ein deutscher Fußballspieler, der bei Real Madrid unter Vertrag steht. 2014 wurde er mit der A-Nationalmannschaft in Brasilien Weltmeister.", image: "kroos", values: "56,88,81,82,66,69")
        saveCard(26, cardset: 2, name: "Modric", info: "Luka Modrić (* 9. September 1985 in Zadar, SR Kroatien, SFR Jugoslawien) ist ein kroatischer Fußballspieler. Seit 2012 steht er bei Real Madrid unter Vertrag.", image: "modric", values: "76,84,74,89,71,68")
        saveCard(27, cardset: 2, name: "Özil", info: "Mesut (* 15. Oktober 1988 in Gelsenkirchen) ist ein deutscher Fußballspieler. Seit September 2013 steht er beim FC Arsenal unter Vertrag. 2014 wurde er mit der deutschen Nationalmannschaft in Brasilien Weltmeister.", image: "ozil", values: "72,85,74,86,24,57")
        saveCard(28, cardset: 2, name: "Bale", info: "Gareth Frank Bale (* 16. Juli 1989 in Cardiff) ist ein walisischer Fußballspieler, der bei Real Madrid unter Vertrag steht. Bale begann seine professionelle Karriere beim FC Southampton als linker Verteidiger und wurde dort als Freistoßspezialist bekannt. 2007 kaufte ihn Tottenham Hotspur; dort spielte er immer öfter einen offensiveren Part. In der Saison 2009/10 war Bale einer der wichtigsten Spieler der Mannschaft, während der UEFA Champions League-Saison erregte er internationales Aufsehen. 2011 und 2013 wurde er mit dem PFA Players' Player of the Year ausgezeichnet, außerdem war er in diesen Jahren jeweils Teil des UEFA Team of the Year. Bale erhielt in Großbritannien viel Lob von Kollegen und Trainern, die ihm herausragende Eigenschaften wie Schnelligkeit, Flanken sowie einen starken linken Fuß und physisch starke Fähigkeiten attestierten. Am 1. September 2013 wechselte Bale zu Real Madrid. Nach Angaben von Florentino Pérez hat er Real Madrid 91 Millionen Euro gekostet,[2] und nicht wie von Medien teilweise berichtet eine dreistellige Summe von 100 Millionen Euro. Damit stellt der Transfer den zweitteuersten nach dem von Cristiano Ronaldo mit 94 Millionen Euro Ablösesumme dar.", image: "bale", values: "94,83,83,84,63,80")
        saveCard(29, cardset: 2, name: "Fabregas", info: "Francesc „Cesc“ Fàbregas i Soler (* 4. Mai 1987 in Arenys de Mar) ist ein spanischer Fußballspieler. Er begann seine Karriere in der Jugendabteilung des FC Barcelona und wechselte im Juni 2003 zum FC Arsenal in die englische Premier League, wo er trotz seiner Jugend zum Führungsspieler aufstieg und sich zur zentralen Schaltstelle im Spiel der Mannschaft entwickelte. 2006 erhielt er von Arsenal einen Achtjahresvertrag. Im August 2011 kehrte Fàbregas zum FC Barcelona zurück. Ab 1. Juli 2014 steht er beim FC Chelsea unter Vertrag. Fàbregas erreichte im Jahr 2003 mit der U-17-Nationalmannschaft Spaniens das Finale der U-17-Weltmeisterschaft in Finnland, wo er zum „Spieler des Turniers“ gewählt und bester Torschütze wurde. Bei der WM 2006 in Deutschland gehörte er dem Kader der spanischen Nationalmannschaft an, mit der er in den Jahren 2008 sowie 2012 Europameister und im Jahr 2010 Weltmeister wurde.", image: "fabregas", values: "68,90,78,81,64,65")
        saveCard(30, cardset: 2, name: "Ribery", info: "Franck Henry Pierre Ribéry (* 7. April 1983 in Boulogne-sur-Mer) ist ein französischer Fußballspieler. Seit 2007 steht er beim FC Bayern München unter Vertrag. Ribéry zeichnet sich insbesondere durch seine Ballsicherheit, Schnelligkeit und Dribbelstärke aus. Er ist ein ausgezeichneter Torvorbereiter; in den Spielzeiten 2011/12 und 2012/13 erzielte er jeweils die meisten Vorlagen in der Bundesliga.", image: "rib", values: "87,91,77,25,84,61")
        saveCard(31, cardset: 2, name: "Sergio Ramos", info: "Sergio Ramos García (* 30. März 1986 in Camas, Provinz Sevilla) ist ein spanischer Fußballspieler. Er wird bevorzugt als Innenverteidiger oder rechter Außenverteidiger eingesetzt. Sowohl bei Real Madrid als auch in der Nationalelf interpretiert Ramos die Position des rechten Verteidigers sehr offensiv, kann aber auch in der Innenverteidigung eingesetzt werden. Er wird in der Abwehr auf Grund seiner Zweikampfstärke und seines Stellungsspiels geschätzt. Das liegt vor allem an seinem Timing. Auf Grund seiner Größe und seiner Kopfballstärke ist er bei Standardsituationen immer vorne mit dabei. Ferner verfügt er über eine gute Ballbehandlung und ist auch immer wieder am Spielaufbau beteiligt.", image: "ramos", values: "79,71,60,66,87,81")
        saveCard(32, cardset: 2, name: "Agüero", info: "Sergio Leonel Agüero del Castillo (* 2. Juni 1988 in Buenos Aires), auch Kun Agüero genannt, ist ein argentinischer Fußballspieler, der bei Manchester City in der englischen Premier League unter Vertrag steht. Die Aussprache des Familiennamens ist; das u mit Trema findet sich vereinzelt im Spanischen.", image: "aguero", values: "89,77,87,89,23,68")
        saveCard(33, cardset: 2, name: "Chiellini", info: "Giorgio Chiellini (* 14. August 1984 in Pisa, Italien) ist ein italienischer Fußballspieler. Seit 2004 steht er bei Juventus Turin unter Vertrag. Früher spielte er auf der Position des Linksverteidigers, inzwischen hat er sich aber als Innenverteidiger etabliert und wird auf dieser Position eingesetzt.", image: "chiellini", values: "77,56,47,58,90,84")
        saveCard(34, cardset: 2, name: "Lahm", info: "Philipp Lahm (* 11. November 1983 in München) ist ein deutscher Fußballspieler und Mannschaftskapitän des FC Bayern München, mit dem er 2013 das Triple gewann. Er war von 2010 bis 2014 Mannschaftskapitän der deutschen Nationalmannschaft. Am 13. Juli 2014 wurde er bei der Fußball-Weltmeisterschaft 2014 in Brasilien Weltmeister und beendete danach seine Karriere in der Nationalmannschaft. Lahm spielt in der Abwehr als rechter oder linker Außenverteidiger, wird aber auch im defensiven Mittelfeld eingesetzt.", image: "lahm", values: "75,84,56,85,87,66")
        saveCard(35, cardset: 2, name: "De Bruyne", info: "Kevin De Bruyne (* 28. Juni 1991 in Drongen) ist ein belgischer Fußballspieler. Der Mittelfeldspieler steht bei Manchester City unter Vertrag und spielt für die belgische Nationalmannschaft.", image: "debruyne", values: "77,86,83,84,40,75")
        saveCard(36, cardset: 2, name: "Pogba", info: "Paul Labile Pogba (* 15. März 1993 in Lagny-sur-Marne) ist ein französischer Fußballspieler. Sein Debüt in der ersten Mannschaft gab Pogba in der dritten Runde des Carling Cup beim 3:0-Auswärtssieg über Leeds United am 20. September 2011, als er nach der Halbzeitpause für Ryan Giggs eingewechselt wurde. Am 31. Januar 2012 debütierte er gegen Stoke City in der Premier League. Nach der Saison verließ er den Verein und schloss sich dem italienischen Rekordmeister Juventus Turin an. Am 20. Oktober 2012 erzielte er nach seiner Einwechslung beim 2:0-Erfolg gegen den SSC Neapel sein erstes Tor für Juventus.", image: "pogba", values: "77,82,80,86,74,88")
        saveCard(37, cardset: 2, name: "Müller", info: "Thomas Müller (* 13. September 1989 in Weilheim in Oberbayern) ist ein deutscher Fußballspieler, der beim FC Bayern München unter Vertrag steht. Mit dem FC Bayern München wurde er mehrfach Deutscher Meister und Pokalsieger, Klub-Weltmeister 2013 und Champions-League-Sieger 2013. 2014 wurde er mit der A-Nationalmannschaft in Brasilien Weltmeister.", image: "mueller", values: "77,80,84,79,46,72")
        saveCard(38, cardset: 2, name: "Sergio Busquets", info: "Sergio Busquets Burgos (* 16. Juli 1988 in Sabadell, Katalonien) ist ein spanischer Fußballspieler, der seit 2008 beim FC Barcelona als Mittelfeldspieler spielt. Er ist der Sohn von Carles Busquets, der Anfang der 1990er Jahre das Tor des FC Barcelona hütete.", image: "busquets", values: "53,77,59,74,83,80")
        saveCard(39, cardset: 2, name: "Reus", info: "Marco Reus (* 31. Mai 1989 in Dortmund) ist ein deutscher Fußballspieler. Er steht seit 2012 bei Borussia Dortmund unter Vertrag und spielt seit 2011 für die deutsche Fußballnationalmannschaft. Marco Reus wuchs im Dortmunder Stadtteil Körne und später in Wickede mit zwei älteren Schwestern auf. Sein Vater war Betriebsschlosser, seine Mutter Bürokauffrau. Laut eigenen Angaben begann Reus bereits im Alter von vier Jahren mit dem Fußballspielen.Er besuchte die Max-Born-Realschule in Asseln und danach die Hauptschule in Wickede.Eine Ausbildung zum Einzelhandelskaufmann brach Reus zu Gunsten seiner Karriere als Berufsfußballer ab. Er zählt den tschechischen Fußballspieler Tomáš Rosický zu seinen Vorbildern.", image: "reus", values: "90,85,84,86,39,64")
        saveCard(40, cardset: 2, name: "Sanchez", info: "Alexis Alejandro Sánchez Sánchez (* 19. Dezember 1988 in Tocopilla), kurz Alexis Sánchez oder nur Alexis, ist ein chilenischer Fußballspieler, der seit dem Sommer 2014 beim FC Arsenal unter Vertrag steht.", image: "sanchez", values: "87,78,83,88,39,73")
        saveCard(41, cardset: 2, name: "Vidal", info: "Arturo Erasmo Vidal Pardo (* 22. Mai 1987 in Santiago de Chile) ist ein chilenischer Fußballspieler, der beim FC Bayern München unter Vertrag steht. Er spielt vorwiegend im defensiven Mittelfeld, ist aber auch in der Offensive einsetzbar.", image: "vidal", values: "77,80,79,81,83,83")
        saveCard(42, cardset: 2, name: "Diego Costa", info: "Diego Costa, mit vollem Namen Diego da Silva Costa (* 7. Oktober 1988 in Lagarto, Sergipe) ist ein brasilianischer Fußballspieler, der seit 2013 auch die spanische Staatsangehörigkeit besitzt[1] und infolgedessen seit 2014 für die spanische Nationalmannschaft spielt. Der Stürmer steht seit der Saison 2014/15 beim FC Chelsea unter Vertrag.", image: "diegocosta", values: "82,63,83,79,40,88")
        saveCard(43, cardset: 2, name: "Hummels", info: "Mats Julian Hummels (* 16. Dezember 1988 in Bergisch Gladbach[1]) ist ein deutscher Fußballspieler. Er spielt als Innenverteidiger für Borussia Dortmund und die deutsche Nationalmannschaft. Mit der DFB-Auswahl wurde er 2014 Fußball-Weltmeister.", image: "hummels", values: "64,74,58,70,88,77")
        
        
        loadFromJsonFile("bikes/bikes")
        loadFromJsonFile("tuning/tuning")
    }
    
    
    
    
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- Save Methods ------------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    func saveRanking(player: String, rounds: Int, time: Double) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Ranking", inManagedObjectContext:managedContext)
        let newRanking = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        newRanking.setValue(player, forKey: "player")
        newRanking.setValue(rounds, forKey: "scoreRounds")
        newRanking.setValue(time, forKey: "scoreTime")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveCard(id: Int, cardset: Int, name: String, info: String, image: String, values: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Card", inManagedObjectContext:managedContext)
        let newCard = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        newCard.setValue(id, forKey: "id")
        newCard.setValue(cardset, forKey: "cardset")
        newCard.setValue(name, forKey: "name")
        newCard.setValue(info, forKey: "info")
        newCard.setValue(image, forKey: "image")
        newCard.setValue(values, forKey: "values")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveCardset(id: Int, name: String, image: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Cardset", inManagedObjectContext:managedContext)
        let newCardset = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        newCardset.setValue(id, forKey: "id")
        newCardset.setValue(name, forKey: "name")
        newCardset.setValue(image, forKey: "image")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveAttribute(id: Int, cardset: Int, name: String, icon: String, unit: String, condition: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Attribute", inManagedObjectContext:managedContext)
        let attribute = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        attribute.setValue(id, forKey: "id")
        attribute.setValue(cardset, forKey: "cardset")
        attribute.setValue(name, forKey: "name")
        attribute.setValue(icon, forKey: "icon")
        attribute.setValue(unit, forKey: "unit")
        attribute.setValue(condition, forKey: "condition")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveGame(cardsetID: Int, difficulty: Int, currentLap: Int, maxLaps: Int, maxTime: Double, p1Name: String, p1CardsArray: [NSManagedObject], p2Name: String, p2CardsArray: [NSManagedObject], currentTime: Double, turn: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Game", inManagedObjectContext:managedContext)
        let game = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        game.setValue(cardsetID, forKey: "cardset")
        game.setValue(difficulty, forKey: "difficulty")
        game.setValue(currentLap, forKey: "laps")
        game.setValue(maxLaps, forKey: "maxLaps")
        game.setValue(maxTime, forKey: "maxTime")
        game.setValue(p1Name, forKey: "player1")
        game.setValue(self.objectToString(p1CardsArray), forKey: "player1Cards")
        game.setValue(p2Name, forKey: "player2")
        game.setValue(self.objectToString(p2CardsArray), forKey: "player2Cards")
        game.setValue(currentTime, forKey: "time")
        game.setValue(turn, forKey: "turn")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- End Save Methods --------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------

    
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- Json Methods ---------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    func loadFromJsonFile(filename: String){
        
        do{
            let targetURL = NSBundle.mainBundle().pathForResource(filename, ofType: "json")
            let data = try NSData(contentsOfFile: targetURL!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            let cardsetName = jsonResult.objectForKey("name") as! String
            let cards = jsonResult.objectForKey("cards") as! NSArray
            let properties = jsonResult.objectForKey("properties") as! NSArray
            
            // Save Cardset
            var cardSetId = 0
            while cardSetExists(cardSetId){
                cardSetId++
            }
            let images = cards[0].valueForKey("images") as! NSArray
            let cardSetImage = filename.componentsSeparatedByString("/")[0] + "/" + (images.objectAtIndex(0).valueForKey("filename") as! String)
            saveCardset(cardSetId, name: cardsetName, image: cardSetImage)
            
            // Save Card
            for var card = 0; card < cards.count; card++ {
                var cardId = 0
                while cardExists(cardId){
                    cardId++
                }
                let cardName = cards[card].valueForKey("name") as! String
                //                let info = cards[card].valueForKey("description") as! NSDictionary
                //                let cardInfo = info[card]?.
                let images = cards[card].valueForKey("images") as! NSArray
                let cardImage = filename.componentsSeparatedByString("/")[0] + "/" + (images.objectAtIndex(0).valueForKey("filename") as! String)
                
                let properties = cards[card].valueForKey("values") as! NSArray
                var values = ""
                for var propertyCount = 0; propertyCount < properties.count; propertyCount++ {
                    values += properties[propertyCount].valueForKey("value") as! String
                    if(propertyCount < properties.count - 1){
                        values += ","
                    }
                }
                saveCard(cardId, cardset: cardSetId, name: cardName, info: "Keine Info", image: cardImage, values: values)
            }
            
            // Save Properties
            for var attribute = 0; attribute < properties.count; attribute++ {
                var attributeId = 0
                while attributeExists(attributeId){
                    attributeId++
                }
                let attributeName = properties[attribute].valueForKey("text") as! String
                let attributeUnit = properties[attribute].valueForKey("unit") as! String
                var attributeCondition = false
                if((properties[attribute].valueForKey("compare") as! NSString).doubleValue == 1){
                    attributeCondition = true
                }else{
                    attributeCondition = false
                }
                //                let attributePrecision = properties[attribute].valueForKey("precision") as! String
                //                print(attributePrecision)
                var attributeIcon = "StandardIcon"
                switch attributeName {
                case "Geschwindigkeit": attributeIcon = "speed"
                case "Umdrehungen": attributeIcon = "umdrehung"
                case "0 auf 100": attributeIcon = "0auf100"
                case "Hubraum": attributeIcon = "hubraum"
                case "Leistung": attributeIcon = "PS"
                case "Drehmoment": attributeIcon = "drehmoment"
                case "Zylinder": attributeIcon = "zylinder"
                default: attributeIcon = "StandardIcon"
                }
                saveAttribute(attributeId, cardset: cardSetId, name: attributeName, icon: attributeIcon, unit: attributeUnit, condition: attributeCondition)
            }
            
        }catch{
            print("Json Datei konnte nicht gefunden werden")
        }
        
    }
    
    
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- End Json Methods -----------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- Loading Methods ---------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    
    
    func loadCards(arr:[String]) -> [NSManagedObject]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
        var returnArr = [NSManagedObject]()
        for var index = 0; index < arr.count; ++index{
            let predicate2 = NSPredicate(format: "id == %d", Int(arr[index])!)
            
            
            fetchRequest.predicate = predicate2
            
            do {
                let results =
                try managedContext.executeFetchRequest(fetchRequest)
                let returnArr2 = results as! [NSManagedObject]
                returnArr.append(returnArr2[0])
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
        return returnArr
    }
    
    func loadGame() -> [NSManagedObject]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Game")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [NSManagedObject]()
    }
    
    func loadCardSets() -> [NSManagedObject] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Cardset")
        
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [NSManagedObject]()
    }
    
    func loadCardArray(cardSetID: Int) -> [NSManagedObject]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "cardset == %d", cardSetID)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [NSManagedObject]()
    }
    func loadAttributes(cardSetID: Int) -> [NSManagedObject]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Attribute")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "cardset == %d", cardSetID)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [NSManagedObject]()
    }
    
    func loadCardset(cardsetID: Int) -> [NSManagedObject]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Cardset")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", cardsetID)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [NSManagedObject]()
    }    
    
    func loadRankings(rankingType: Bool) -> [NSManagedObject]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Ranking")
        
        if(rankingType){
            // sort less rounds as best
            let sortDescriptor = NSSortDescriptor(key: "scoreRounds", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
        }else{
            // sort less time as best
            let sortDescriptor = NSSortDescriptor(key: "scoreTime", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [NSManagedObject]()
    }
    
    func cardSetExists(id: Int) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Cardset")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            if results.count == 0{
                return false
            }else{
                return true
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return false
    }
    
    func cardExists(id: Int) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Card")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            if results.count == 0{
                return false
            }else{
                return true
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return false
    }
    
    func attributeExists(id: Int) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Attribute")
        
        // filters cards from specific cardset
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            if results.count == 0{
                return false
            }else{
                return true
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return false
    }
    
    
    func stringToImage(imageString: String) -> UIImage {
        var image: UIImage?
        if(imageString.containsString(".png")){
            let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
            let data = NSData(contentsOfFile: documentsURL.path! + "/" + imageString)
            image = UIImage(data: data!)
        }else{
            image = UIImage(named: imageString)
        }
        if image != nil {
            return image!
        }
        else {
            return UIImage(named: "ImageIcon")!
        }
    }
    
    //Convert String to Array(String)
    func stringToArrayString(x:String) -> [String]{
        let toArray = x.componentsSeparatedByString(",")
        
        return toArray
    }
    
    func objectToString(object: [NSManagedObject]) -> String{
        var cards = ""
        for var index = 0; index < object.count; index++ {
            cards += "\(object[index].valueForKey("id")!)"
            if(index < object.count - 1){
                cards += ","
            }
        }
        return cards
    }
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- End Loading Methods -----------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- Delete Method -----------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
    
    func deleteObjectsFromEntity(entity: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let coord = appDelegate.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: entity)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    
    func resetRankings(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let coord = appDelegate.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Ranking")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func deleteCardSet(cardSetID: Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let coord = appDelegate.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Cardset")
        
        let predicate = NSPredicate(format: "id == %d", cardSetID)
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
        
        let fetchRequest2 = NSFetchRequest(entityName: "Card")
        
        let predicate2 = NSPredicate(format: "cardset == %d", cardSetID)
        fetchRequest2.predicate = predicate2
        
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        
        do {
            try coord.executeRequest(deleteRequest2, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    // -------------------------------------------------------------------------------------------------------------------------------
    // ----------------------------------------------------- End Delete Method -------------------------------------------------------
    // -------------------------------------------------------------------------------------------------------------------------------
}