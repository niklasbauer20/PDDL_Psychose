(define (domain d_domain)

	(:requirements :strips :fluents :typing :negative-preconditions :equality :disjunctive-preconditions)

	(:types
		staff warehouse truck location parcel - object
		driver - staff
	)

	(:constants
		Warehouse1 - warehouse
		Spandau Pankow Lichtenberg Neukoellen - location
	)

	(:predicates
		(at ?x - object ?y - object)
		(warehouse_checked ?w - warehouse)
		(parcel_loaded_at ?p - parcel ?w - warehouse)
	)

	(:functions
		(kilometers_travelled_relative ?t - truck)
		(distance_to_spandau ?l)
		(minutes_of_work ?s - staff)
		(travel_duration)
				
		(kilometers_travelled ?t - truck)
	)

	(:action load
		:parameters (?t - truck ?s - staff ?p - parcel ?w - warehouse)
		:precondition (and
			(at ?t ?w)
			(at ?s ?w)
			(at ?p ?w)
		)
		:effect (and
			(parcel_loaded_at ?p ?w)
			(not (at ?p ?w))
			(at ?p ?t)

			(increase (minutes_of_work ?s) 10)			
		)
	)

	(:action transport_from_spandau
		:parameters (?t - truck ?s - driver  ?w - warehouse ?l - location)
		:precondition (and
			(not (= Warehouse1 ?w))
			(not (warehouse_checked ?w))
			(at ?s Warehouse1)
			(at ?t Warehouse1)
			(at ?w ?l)
			(exists (?p - parcel)(at ?p ?t))

			(or
				(not(or(not(exists (?tr - truck)(<(kilometers_travelled ?tr)(kilometers_travelled ?t))))(= ?l Lichtenberg))) 
				(and(not(exists (?tr - truck)(<(kilometers_travelled ?tr)(kilometers_travelled ?t)))) (= ?l Lichtenberg))
			)

		)
		:effect (and
			(warehouse_checked ?w)
			(increase (kilometers_travelled_relative ?t) (distance_to_spandau ?l))
			(increase (minutes_of_work ?s) (travel_duration))
			(not (at ?s Warehouse1))
			(not (at ?t Warehouse1))
			(at ?s ?w)
			(at ?t ?w)

			(increase (kilometers_travelled ?t) (distance_to_spandau ?l))
		)
	)

	(:action unload
		:parameters (?t - truck ?s - staff ?p - parcel ?w - warehouse)
		:precondition (and
			(not (= ?w Warehouse1))
			(at ?t ?w)
			(at ?s ?w)
			(at ?p ?t)
			(not (parcel_loaded_at ?p ?w))
		)
		:effect (and
			(at ?p ?w)
			(not (at ?p ?t))

			(increase (minutes_of_work ?s) 10)
		)
	)

	(:action return_to_spandau
		:parameters (?t - truck ?s - driver ?w - warehouse ?l - location)
		:precondition (and
			(not(= ?w Warehouse1))
			(at ?s ?w)
			(at ?t ?w)
			(at ?w ?l)
			(exists (?p - parcel) (at ?p Warehouse1))
			(not (exists (?p - parcel)(at ?p ?t)))
			(forall (?tr - truck) (<=(kilometers_travelled_relative ?t) (kilometers_travelled_relative ?tr)) )
		)
		:effect (and
			(increase (minutes_of_work ?s) (travel_duration))
			(increase (kilometers_travelled_relative ?t) (distance_to_spandau ?l))
			(not (at ?s ?w))
			(not (at ?t ?w))
			(at ?s Warehouse1)
			(at ?t Warehouse1)

			(increase (kilometers_travelled ?t) (distance_to_spandau ?l))
		)
	)
) 