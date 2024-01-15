(define (problem volkshochschule-planung-woche1-a)

    (:domain volkshochschule-planung-a)
    
    (:objects
        EDV_01 EDV_02 Webdesign Malerei Tonformen - kurs
        Ahorn Eiche Birke Kiefer - lehrer
        Raum01 Raum02 Raum03 Raum04 - raum
        Tag1Vormittag Tag2Vormittag Tag3Vormittag Tag4Vormittag Tag5Vormittag - zeitslot
        Tag1Nachmittag Tag2Nachmittag Tag3Nachmittag Tag4Nachmittag Tag5Nachmittag - zeitslot
    )
    
    (:init
        (=(gewinn)0)
        (=(kurse)0)

        (lehrer-kann-unterrichten Ahorn EDV_01)
        (lehrer-kann-unterrichten Ahorn EDV_02)
        (lehrer-kann-unterrichten Eiche EDV_02)
        (lehrer-kann-unterrichten Eiche Webdesign)
        (lehrer-kann-unterrichten Birke Webdesign)
        (lehrer-kann-unterrichten Birke Malerei)
        (lehrer-kann-unterrichten Kiefer Malerei)
        (lehrer-kann-unterrichten Kiefer Tonformen)

        (=(teilnehmerzahl EDV_01) 123)
        (=(teilnehmerzahl EDV_02) 50)
        (=(teilnehmerzahl Webdesign) 84)
        (=(teilnehmerzahl Malerei) 105)
        (=(teilnehmerzahl Tonformen) 39)

        (=(kapazitaet Raum01) 10)
        (=(kapazitaet Raum02) 12)
        (=(kapazitaet Raum03) 8)
        (=(kapazitaet Raum04) 5)

        (=(gebuehr EDV_01)20)
        (=(gebuehr EDV_02)30)
        (=(gebuehr Webdesign)25)
        (=(gebuehr Malerei)30)
        (=(gebuehr Tonformen)50)

        (=(anzahl-termine-lehrer Ahorn)0)
        (=(anzahl-termine-lehrer Eiche)0)
        (=(anzahl-termine-lehrer Birke)0)
        (=(anzahl-termine-lehrer Kiefer)0)

        ;Es wurden 2 Aktionen zur Realisierung des Problems mit verschiedenen Ansätzen implementiert.
        ;Die folgende Funktion agiert als eine Art Schalter: 
        ;(=(gewinn_maximieren)0) -> belegen0 wird genutzt, (=(gewinn_maximieren)1) -> belegen1 wird genutzt.
        ;Eine genaue Erklärung steht in der Beschreibung.

        (=(gewinn_maximieren)0) 
    )

    (:goal
        (and 
            (=(kurse)40)
        )
    )
)
