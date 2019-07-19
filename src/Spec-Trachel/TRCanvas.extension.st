Extension { #name : #TRCanvas }

{ #category : #'*Spec-Trachel' }
TRCanvas >> asSpecAdapter [

	^ (SpBindings value 
		adapterClass: #TrachelAdapter)
		trachelCanvas: self
]

{ #category : #'*Spec-Trachel' }
TRCanvas >> morph: anObject [

	morph := anObject
]
