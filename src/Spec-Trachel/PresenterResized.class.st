Class {
	#name : #PresenterResized,
	#superclass : #Announcement,
	#instVars : [
		'extent'
	],
	#category : #'Spec-Trachel'
}

{ #category : #accessing }
PresenterResized >> extent [
	^ extent
]

{ #category : #accessing }
PresenterResized >> extent: anObject [
	extent := anObject
]
