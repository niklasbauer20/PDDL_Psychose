(define (domain volkshochschule-planung-d)

    (:requirements :typing :fluents :conditional-effects :negative-preconditions)
    
    (:types
        zeitslot kurs raum lehrer
    )

    (:predicates
        (lehrer-kann-unterrichten ?l - lehrer ?k - kurs)
        (lehrer-verplant ?l - lehrer ?z - zeitslot)
        (raum-ist-belegt ?r - raum ?z - zeitslot)
    )

    (:functions
        (gewinn_maximieren)
        (gewinn)
        (kurse)
        (gebuehr ?k - kurs)
        (kapazitaet ?r - raum)
        (teilnehmerzahl ?k - kurs)
        (anzahl-termine-lehrer ?l - lehrer)
    )

    (:action belegen0
        :parameters (?r - raum ?z - zeitslot ?l - lehrer ?k - kurs)
        :precondition (and
            (=(gewinn_maximieren)0)
            (>=(teilnehmerzahl ?k)(kapazitaet ?r))
            (not(lehrer-verplant ?l ?z))
            (lehrer-kann-unterrichten ?l ?k)
            (not(raum-ist-belegt ?r ?z))
        )
        :effect (and
            (increase (anzahl-termine-lehrer ?l) 1)
            (increase (kurse) 1)
            (increase (gewinn) (*(kapazitaet ?r)(gebuehr ?k)))
            (decrease (teilnehmerzahl ?k) (kapazitaet ?r))
            (lehrer-verplant ?l ?z)
            (raum-ist-belegt ?r ?z)
        )
    )

        (:action belegen1
        :parameters (?r - raum ?z - zeitslot ?l - lehrer ?k - kurs)
        :precondition (and
            (=(gewinn_maximieren)1)
            (>(teilnehmerzahl ?k)0)
            (not(lehrer-verplant ?l ?z))
            (lehrer-kann-unterrichten ?l ?k)
            (not(raum-ist-belegt ?r ?z))
        )
        :effect (and
            (increase (anzahl-termine-lehrer ?l) 1)
            (increase (kurse) 1)
            (when (>(kapazitaet ?r)(teilnehmerzahl ?k)) (increase (gewinn) (*(teilnehmerzahl ?k)(gebuehr ?k))))
            (when (<=(kapazitaet ?r)(teilnehmerzahl ?k)) (increase (gewinn) (*(kapazitaet ?r)(gebuehr ?k))))
            (decrease (teilnehmerzahl ?k) (kapazitaet ?r))
            (lehrer-verplant ?l ?z)
            (raum-ist-belegt ?r ?z)
        )
    )
)