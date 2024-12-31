/*
 Thirukkural data sourced from https://github.com/tk120404/thirukkural
 Copyright (c) 2024 [Original Author]
 Licensed under the Apache License, Version 2.0
 See LICENSE.txt for full license information
*/

import Foundation

struct KuralChapter: Identifiable {
    let id: Int
    let name: String
    let kurals: [Thirukkural]
    let description: String
}

struct KuralSection: Identifiable {
    let id: Int
    let name: String
    let chapters: [KuralChapter]
    let description: String
}

struct KuralBook: Identifiable {
    let id: Int
    let name: String
    let sections: [KuralSection]
    let description: String
}

class KuralStructure {
    static let shared = KuralStructure()
    private let database = ThirukkuralDatabase.shared
    
    lazy var books: [KuralBook] = createBooks()
    
    private func getKurals(from: Int, to: Int) -> [Thirukkural] {
        return Array(database.kurals[(from-1)...(to-1)])
    }
    
    private func createBooks() -> [KuralBook] {
        [
            // Book 1: அறத்துப்பால் (1-380)
            KuralBook(
                id: 1,
                name: "அறத்துப்பால்",
                sections: [
                    // Section 1: பாயிரவியல் (1-40)
                    KuralSection(
                        id: 1,
                        name: "பாயிரவியல்",
                        chapters: [
                            KuralChapter(id: 1, name: "கடவுள் வாழ்த்து", kurals: getKurals(from: 1, to: 10), description: "The Praise of God"),
                            KuralChapter(id: 2, name: "வான்சிறப்பு", kurals: getKurals(from: 11, to: 20), description: "The Blessing of Rain"),
                            KuralChapter(id: 3, name: "நீத்தார் பெருமை", kurals: getKurals(from: 21, to: 30), description: "The Greatness of Ascetics"),
                            KuralChapter(id: 4, name: "அறன் வலியுறுத்தல்", kurals: getKurals(from: 31, to: 40), description: "Assertion of the Strength of Virtue")
                        ],
                        description: "Prologue"
                    ),
                    
                    // Section 2: இல்லறவியல் (41-240)
                    KuralSection(
                        id: 2,
                        name: "இல்லறவியல்",
                        chapters: [
                            KuralChapter(id: 5, name: "இல்வாழ்க்கை", kurals: getKurals(from: 41, to: 50), description: "Domestic Life"),
                            KuralChapter(id: 6, name: "வாழ்க்கைத் துணைநலம்", kurals: getKurals(from: 51, to: 60), description: "The Worth of a Wife"),
                            KuralChapter(id: 7, name: "மக்கட்பேறு", kurals: getKurals(from: 61, to: 70), description: "The Wealth of Children"),
                            KuralChapter(id: 8, name: "அன்புடைமை", kurals: getKurals(from: 71, to: 80), description: "The Possession of Love"),
                            KuralChapter(id: 9, name: "விருந்தோம்பல்", kurals: getKurals(from: 81, to: 90), description: "Hospitality"),
                            KuralChapter(id: 10, name: "இனியவை கூறல்", kurals: getKurals(from: 91, to: 100), description: "The Utterance of Pleasant Words"),
                            KuralChapter(id: 11, name: "செய்ந்நன்றியறிதல்", kurals: getKurals(from: 101, to: 110), description: "Gratitude"),
                            KuralChapter(id: 12, name: "நடுவு நிலைமை", kurals: getKurals(from: 111, to: 120), description: "Impartiality"),
                            KuralChapter(id: 13, name: "அடக்கம் உடைமை", kurals: getKurals(from: 121, to: 130), description: "The Possession of Self-restraint"),
                            KuralChapter(id: 14, name: "ஒழுக்கம் உடைமை", kurals: getKurals(from: 131, to: 140), description: "The Possession of Decorum"),
                            KuralChapter(id: 15, name: "பிறனில் விழையாமை", kurals: getKurals(from: 141, to: 150), description: "Not coveting another's Wife"),
                            KuralChapter(id: 16, name: "பொறையுடைமை", kurals: getKurals(from: 151, to: 160), description: "The Possession of Patience"),
                            KuralChapter(id: 17, name: "அழுக்காறாமை", kurals: getKurals(from: 161, to: 170), description: "Not Envying"),
                            KuralChapter(id: 18, name: "வெஃகாமை", kurals: getKurals(from: 171, to: 180), description: "Not Coveting"),
                            KuralChapter(id: 19, name: "புறங்கூறாமை", kurals: getKurals(from: 181, to: 190), description: "Not Backbiting"),
                            KuralChapter(id: 20, name: "பயனில சொல்லாமை", kurals: getKurals(from: 191, to: 200), description: "Against Vain Speaking"),
                            KuralChapter(id: 21, name: "தீவினையச்சம்", kurals: getKurals(from: 201, to: 210), description: "Dread of Evil Deeds"),
                            KuralChapter(id: 22, name: "ஒப்புரவறிதல்", kurals: getKurals(from: 211, to: 220), description: "Duty to Society"),
                            KuralChapter(id: 23, name: "ஈகை", kurals: getKurals(from: 221, to: 230), description: "Giving"),
                            KuralChapter(id: 24, name: "புகழ்", kurals: getKurals(from: 231, to: 240), description: "Renown")
                        ],
                        description: "Domestic Virtue"
                    ),
                    
                    // Section 3: துறவறவியல் (241-370)
                    KuralSection(
                        id: 3,
                        name: "துறவறவியல்",
                        chapters: [
                            KuralChapter(id: 25, name: "அருளுடைமை", kurals: getKurals(from: 241, to: 250), description: "Compassion"),
                            KuralChapter(id: 26, name: "புலால் மறுத்தல்", kurals: getKurals(from: 251, to: 260), description: "Abstinence from Flesh"),
                            KuralChapter(id: 27, name: "தவம்", kurals: getKurals(from: 261, to: 270), description: "Penance"),
                            KuralChapter(id: 28, name: "கூடாவொழுக்கம்", kurals: getKurals(from: 271, to: 280), description: "Improper Conduct"),
                            KuralChapter(id: 29, name: "கள்ளாமை", kurals: getKurals(from: 281, to: 290), description: "Not Stealing"),
                            KuralChapter(id: 30, name: "வாய்மை", kurals: getKurals(from: 291, to: 300), description: "Truthfulness"),
                            KuralChapter(id: 31, name: "வெகுளாமை", kurals: getKurals(from: 301, to: 310), description: "Not Being Angry"),
                            KuralChapter(id: 32, name: "இன்னா செய்யாமை", kurals: getKurals(from: 311, to: 320), description: "Not Doing Evil"),
                            KuralChapter(id: 33, name: "கொல்லாமை", kurals: getKurals(from: 321, to: 330), description: "Not Killing"),
                            KuralChapter(id: 34, name: "நிலையாமை", kurals: getKurals(from: 331, to: 340), description: "Instability"),
                            KuralChapter(id: 35, name: "துறவு", kurals: getKurals(from: 341, to: 350), description: "Renunciation"),
                            KuralChapter(id: 36, name: "மெய்யுணர்தல்", kurals: getKurals(from: 351, to: 360), description: "Truth-Consciousness"),
                            KuralChapter(id: 37, name: "அவாவறுத்தல்", kurals: getKurals(from: 361, to: 370), description: "Curbing Desire")
                        ],
                        description: "Ascetic Virtue"
                    )
                ],
                description: "Book of Virtue"
            ),
            
            // Book 2: பொருட்பால் (381-1080)
            KuralBook(
                id: 2,
                name: "பொருட்பால்",
                sections: [
                    // Section 4: அரசியல் (381-630)
                    KuralSection(
                        id: 4,
                        name: "அரசியல்",
                        chapters: [
                            KuralChapter(id: 39, name: "இறைமாட்சி", kurals: getKurals(from: 381, to: 390), description: "The Greatness of a King"),
                            KuralChapter(id: 40, name: "கல்வி", kurals: getKurals(from: 391, to: 400), description: "Learning"),
                            KuralChapter(id: 41, name: "கல்லாமை", kurals: getKurals(from: 401, to: 410), description: "Ignorance"),
                            KuralChapter(id: 42, name: "கேள்வி", kurals: getKurals(from: 411, to: 420), description: "Hearing"),
                            KuralChapter(id: 43, name: "அறிவுடைமை", kurals: getKurals(from: 421, to: 430), description: "The Possession of Knowledge"),
                            KuralChapter(id: 44, name: "குற்றங்கடிதல்", kurals: getKurals(from: 431, to: 440), description: "The Correction of Faults"),
                            KuralChapter(id: 45, name: "பெரியாரைத் துணைக்கோடல்", kurals: getKurals(from: 441, to: 450), description: "Seeking the Aid of Great Men"),
                            KuralChapter(id: 46, name: "சிற்றினஞ்சேராமை", kurals: getKurals(from: 451, to: 460), description: "Avoiding Mean Associations"),
                            KuralChapter(id: 47, name: "தெரிந்து செயல்வகை", kurals: getKurals(from: 461, to: 470), description: "Acting after Due Consideration"),
                            KuralChapter(id: 48, name: "வலியறிதல்", kurals: getKurals(from: 471, to: 480), description: "The Knowledge of Power"),
                            KuralChapter(id: 49, name: "காலமறிதல்", kurals: getKurals(from: 481, to: 490), description: "Knowing the Fitting Time"),
                            KuralChapter(id: 50, name: "இடனறிதல்", kurals: getKurals(from: 491, to: 500), description: "Knowing the Place"),
                            KuralChapter(id: 51, name: "தெரிந்து தெளிதல்", kurals: getKurals(from: 501, to: 510), description: "Selection and Confidence"),
                            KuralChapter(id: 52, name: "தெரிந்து வினையாடல்", kurals: getKurals(from: 511, to: 520), description: "Selection and Employment"),
                            KuralChapter(id: 53, name: "சுற்றந்தழால்", kurals: getKurals(from: 521, to: 530), description: "Cherishing Kinsmen"),
                            KuralChapter(id: 54, name: "பொச்சாவாமை", kurals: getKurals(from: 531, to: 540), description: "Unforgetfulness"),
                            KuralChapter(id: 55, name: "செங்கோன்மை", kurals: getKurals(from: 541, to: 550), description: "The Right Sceptre"),
                            KuralChapter(id: 56, name: "கொடுங்கோன்மை", kurals: getKurals(from: 551, to: 560), description: "The Cruel Sceptre"),
                            KuralChapter(id: 57, name: "வெருவந்த செய்யாமை", kurals: getKurals(from: 561, to: 570), description: "Absence of Terrorism"),
                            KuralChapter(id: 58, name: "கண்ணோட்டம்", kurals: getKurals(from: 571, to: 580), description: "Benignity"),
                            KuralChapter(id: 59, name: "ஒற்றாடல்", kurals: getKurals(from: 581, to: 590), description: "Detectives"),
                            KuralChapter(id: 60, name: "ஊக்கமுடைமை", kurals: getKurals(from: 591, to: 600), description: "Energy"),
                            KuralChapter(id: 61, name: "மடியின்மை", kurals: getKurals(from: 601, to: 610), description: "Unsluggishness"),
                            KuralChapter(id: 62, name: "ஆள்வினையுடைமை", kurals: getKurals(from: 611, to: 620), description: "Manly Effort"),
                            KuralChapter(id: 63, name: "இடுக்கண் அழியாமை", kurals: getKurals(from: 621, to: 630), description: "Not Despairing in Trouble")
                        ],
                        description: "Royalty"
                    ),

                    // Section 5: அமைச்சியல் (631-730)
                    KuralSection(
                        id: 5,
                        name: "அமைச்சியல்",
                        chapters: [
                            KuralChapter(id: 64, name: "அமைச்சு", kurals: getKurals(from: 631, to: 640), description: "The Office of Minister of State"),
                            KuralChapter(id: 65, name: "சொல்வன்மை", kurals: getKurals(from: 641, to: 650), description: "Power of Speech"),
                            KuralChapter(id: 66, name: "வினைத்தூய்மை", kurals: getKurals(from: 651, to: 660), description: "Purity in Action"),
                            KuralChapter(id: 67, name: "வினைத்திட்பம்", kurals: getKurals(from: 661, to: 670), description: "Power in Action"),
                            KuralChapter(id: 68, name: "வினைசெயல்வகை", kurals: getKurals(from: 671, to: 680), description: "Modes of Action"),
                            KuralChapter(id: 69, name: "தூது", kurals: getKurals(from: 681, to: 690), description: "The Envoy"),
                            KuralChapter(id: 70, name: "மன்னரைச் சேர்ந்தொழுதல்", kurals: getKurals(from: 691, to: 700), description: "Conduct in the Presence of the King"),
                            KuralChapter(id: 71, name: "குறிப்பறிதல்", kurals: getKurals(from: 701, to: 710), description: "The Knowledge of Indications"),
                            KuralChapter(id: 72, name: "அவையறிதல்", kurals: getKurals(from: 711, to: 720), description: "Knowing the Assembly"),
                            KuralChapter(id: 73, name: "அவையஞ்சாமை", kurals: getKurals(from: 721, to: 730), description: "Not to Dread the Council")
                        ],
                        description: "Ministers of State"
                    ),

                    // Section 6: அரணியல் (731-750)
                    KuralSection(
                        id: 6,
                        name: "அரணியல்",
                        chapters: [
                            KuralChapter(id: 74, name: "நாடு", kurals: getKurals(from: 731, to: 740), description: "The Country"),
                            KuralChapter(id: 75, name: "அரண்", kurals: getKurals(from: 741, to: 750), description: "The Fortification")
                        ],
                        description: "The Essentials of a State"
                    ),

                    // Section 7: கூழியல் (751-780)
                    KuralSection(
                        id: 7,
                        name: "கூழியல்",
                        chapters: [
                            KuralChapter(id: 76, name: "பொருள் செயல்வகை", kurals: getKurals(from: 751, to: 760), description: "Way of Accumulating Wealth"),
                            KuralChapter(id: 77, name: "படைமாட்சி", kurals: getKurals(from: 761, to: 770), description: "The Excellence of an Army"),
                            KuralChapter(id: 78, name: "படைச்செருக்கு", kurals: getKurals(from: 771, to: 780), description: "Military Spirit")
                        ],
                        description: "Way of Making Wealth"
                    ),

                    // Section 8: பகைமாட்சி (781-850)
                    KuralSection(
                        id: 8,
                        name: "பகைமாட்சி",
                        chapters: [
                            KuralChapter(id: 79, name: "நட்பு", kurals: getKurals(from: 781, to: 790), description: "Friendship"),
                            KuralChapter(id: 80, name: "நட்பாராய்தல்", kurals: getKurals(from: 791, to: 800), description: "Investigation in Forming Friendships"),
                            KuralChapter(id: 81, name: "பழைமை", kurals: getKurals(from: 801, to: 810), description: "Familiarity"),
                            KuralChapter(id: 82, name: "தீ நட்பு", kurals: getKurals(from: 811, to: 820), description: "Evil Friendship"),
                            KuralChapter(id: 83, name: "கூடா நட்பு", kurals: getKurals(from: 821, to: 830), description: "Unreal Friendship"),
                            KuralChapter(id: 84, name: "பேதைமை", kurals: getKurals(from: 831, to: 840), description: "Folly"),
                            KuralChapter(id: 85, name: "புல்லறிவாண்மை", kurals: getKurals(from: 841, to: 850), description: "Ignorance")
                        ],
                        description: "Excellence of Hatred"
                    ),

                    // Section 9: உட்பகை (851-1080)
                    KuralSection(
                        id: 9,
                        name: "உட்பகை",
                        chapters: [
                            KuralChapter(id: 86, name: "இகல்", kurals: getKurals(from: 851, to: 860), description: "Hostility"),
                            KuralChapter(id: 87, name: "பகைமாட்சி", kurals: getKurals(from: 861, to: 870), description: "The Might of Hatred"),
                            KuralChapter(id: 88, name: "பகைத்திறந்தெரிதல்", kurals: getKurals(from: 871, to: 880), description: "Knowing the Quality of Hate"),
                            KuralChapter(id: 89, name: "உட்பகை", kurals: getKurals(from: 881, to: 890), description: "Enmity within"),
                            KuralChapter(id: 90, name: "பெரியாரைப் பிழையாமை", kurals: getKurals(from: 891, to: 900), description: "Not Offending the Great"),
                            KuralChapter(id: 91, name: "பெண்வழிச் சேறல்", kurals: getKurals(from: 901, to: 910), description: "Being led by Women"),
                            KuralChapter(id: 92, name: "வரைவின் மகளிர்", kurals: getKurals(from: 911, to: 920), description: "Wanton Women"),
                            KuralChapter(id: 93, name: "கள்ளுண்ணாமை", kurals: getKurals(from: 921, to: 930), description: "Not Drinking Palm-Wine"),
                            KuralChapter(id: 94, name: "சூது", kurals: getKurals(from: 931, to: 940), description: "Gambling"),
                            KuralChapter(id: 95, name: "மருந்து", kurals: getKurals(from: 941, to: 950), description: "Medicine"),
                            KuralChapter(id: 96, name: "குடிமை", kurals: getKurals(from: 951, to: 960), description: "Nobility"),
                            KuralChapter(id: 97, name: "மானம்", kurals: getKurals(from: 961, to: 970), description: "Honour"),
                            KuralChapter(id: 98, name: "பெருமை", kurals: getKurals(from: 971, to: 980), description: "Greatness"),
                            KuralChapter(id: 99, name: "சான்றாண்மை", kurals: getKurals(from: 981, to: 990), description: "Perfectness"),
                            KuralChapter(id: 100, name: "பண்புடைமை", kurals: getKurals(from: 991, to: 1000), description: "Courtesy"),
                            KuralChapter(id: 101, name: "நன்றியில் செல்வம்", kurals: getKurals(from: 1001, to: 1010), description: "Wealth without Benefaction"),
                            KuralChapter(id: 102, name: "நாணுடைமை", kurals: getKurals(from: 1011, to: 1020), description: "Shame"),
                            KuralChapter(id: 103, name: "குடிசெயல்வகை", kurals: getKurals(from: 1021, to: 1030), description: "The Way of Maintaining the Family"),
                            KuralChapter(id: 104, name: "உழவு", kurals: getKurals(from: 1031, to: 1040), description: "Agriculture"),
                            KuralChapter(id: 105, name: "நல்குரவு", kurals: getKurals(from: 1041, to: 1050), description: "Poverty"),
                            KuralChapter(id: 106, name: "இரவு", kurals: getKurals(from: 1051, to: 1060), description: "Mendicancy"),
                            KuralChapter(id: 107, name: "இரவச்சம்", kurals: getKurals(from: 1061, to: 1070), description: "The Dread of Mendicancy"),
                            KuralChapter(id: 108, name: "கயமை", kurals: getKurals(from: 1071, to: 1080), description: "Baseness")
                        ],
                        description: "Internal Enemies"
                    )
                ],
                description: "Book of Wealth"
            ),

            // Book 3: காமத்துப்பால் (1081-1330)
            KuralBook(
                id: 3,
                name: "காமத்துப்பால்",
                sections: [
                    // Section 10: களவியல் (1081-1330)
                    KuralSection(
                        id: 10,
                        name: "களவியல்",
                        chapters: [
                            KuralChapter(id: 109, name: "தகையணங்குறுத்தல்", kurals: getKurals(from: 1081, to: 1090), description: "The Pre-marital love"),
                            KuralChapter(id: 110, name: "குறிப்பறிதல்", kurals: getKurals(from: 1091, to: 1100), description: "Recognition of the Signs"),
                            KuralChapter(id: 111, name: "புணர்ச்சி மகிழ்தல்", kurals: getKurals(from: 1101, to: 1110), description: "Rejoicing in the Embrace"),
                            KuralChapter(id: 112, name: "நலம்புனைந்துரைத்தல்", kurals: getKurals(from: 1111, to: 1120), description: "The Beauty of Her Forehead"),
                            KuralChapter(id: 113, name: "காதற் சிறப்புரைத்தல்", kurals: getKurals(from: 1121, to: 1130), description: "Declaration of Love's Special Excellence"),
                            KuralChapter(id: 114, name: "நாணுத் துறவுரைத்தல்", kurals: getKurals(from: 1131, to: 1140), description: "The Abandonment of Reserve"),
                            KuralChapter(id: 115, name: "அலரறிவுறுத்தல்", kurals: getKurals(from: 1141, to: 1150), description: "The Announcement of the Rumour"),
                            KuralChapter(id: 116, name: "பிரிவாற்றாமை", kurals: getKurals(from: 1151, to: 1160), description: "Separation unendurable"),
                            KuralChapter(id: 117, name: "படர்மெலிந்திரங்கல்", kurals: getKurals(from: 1161, to: 1170), description: "Complainings"),
                            KuralChapter(id: 118, name: "கண்விதுப்பழிதல்", kurals: getKurals(from: 1171, to: 1180), description: "Eyes consumed with Grief"),
                            KuralChapter(id: 119, name: "பசப்புறு பருவரல்", kurals: getKurals(from: 1181, to: 1190), description: "The Pallid Hue"),
                            KuralChapter(id: 120, name: "தனிப்படர் மிகுதி", kurals: getKurals(from: 1191, to: 1200), description: "The Solitary Anguish"),
                            KuralChapter(id: 121, name: "நினைந்தவர் புலம்பல்", kurals: getKurals(from: 1201, to: 1210), description: "Sad Memories"),
                            KuralChapter(id: 122, name: "கனவுநிலை உரைத்தல்", kurals: getKurals(from: 1211, to: 1220), description: "The Visions of the Night"),
                            KuralChapter(id: 123, name: "பொழுதுகண்டு இரங்கல்", kurals: getKurals(from: 1221, to: 1230), description: "Lamentations at Eventide"),
                            KuralChapter(id: 124, name: "உறுப்புநலன் அழிதல்", kurals: getKurals(from: 1231, to: 1240), description: "Wasting Away"),
                            KuralChapter(id: 125, name: "நெஞ்சொடு கிளத்தல்", kurals: getKurals(from: 1241, to: 1250), description: "Soliloquy"),
                            KuralChapter(id: 126, name: "நிறையழிதல்", kurals: getKurals(from: 1251, to: 1260), description: "Reserve Overcome"),
                            KuralChapter(id: 127, name: "அவர்வயின் விதும்பல்", kurals: getKurals(from: 1261, to: 1270), description: "Longing for His Return"),
                            KuralChapter(id: 128, name: "குறிப்பறிவுறுத்தல்", kurals: getKurals(from: 1271, to: 1280), description: "The Reading of the Signs"),
                            KuralChapter(id: 129, name: "புணர்ச்சி விதும்பல்", kurals: getKurals(from: 1281, to: 1290), description: "Desire for Reunion"),
                            KuralChapter(id: 130, name: "நெஞ்சொடு புலத்தல்", kurals: getKurals(from: 1291, to: 1300), description: "Heart's Reproaches"),
                            KuralChapter(id: 131, name: "புலவி", kurals: getKurals(from: 1301, to: 1310), description: "Pouting"),
                            KuralChapter(id: 132, name: "புலவி நுணுக்கம்", kurals: getKurals(from: 1311, to: 1320), description: "Feigned Anger"),
                            KuralChapter(id: 133, name: "ஊடலுவகை", kurals: getKurals(from: 1321, to: 1330), description: "The Pleasures of Temporary Variance")
                        ],
                        description: "The Pre-marital Love"
                    )
                ],
                description: "Book of Love"
            )
        ]
    }
}
