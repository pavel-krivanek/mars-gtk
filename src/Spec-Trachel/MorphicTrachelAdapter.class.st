Class {
	#name : #MorphicTrachelAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'trachelCanvas'
	],
	#category : #'Spec-Trachel'
}

{ #category : #'instance creation' }
MorphicTrachelAdapter class >> trachelCanvas: aCanvas [

	^ self new
		trachelCanvas: aCanvas;
		yourself
]

{ #category : #factory }
MorphicTrachelAdapter >> buildWidget [ 

	^ model trachelCanvas buildMorph
]

{ #category : #accessing }
MorphicTrachelAdapter >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #accessing }
MorphicTrachelAdapter >> trachelCanvas: anObject [
	trachelCanvas := anObject.

]
