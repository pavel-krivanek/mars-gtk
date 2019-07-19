Class {
	#name : #TrachelPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'trachelCanvas'
	],
	#category : #'Spec-Trachel'
}

{ #category : #specs }
TrachelPresenter class >> adapterName [

	^ #TrachelAdapter
]

{ #category : #accessing }
TrachelPresenter >> initializePrivateHooks [

	trachelCanvas := TRCanvas new.

	self initializeWidgets.
	self initializePresenter.
	self updatePresenter.
]

{ #category : #accessing }
TrachelPresenter >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #accessing }
TrachelPresenter >> trachelCanvas: anObject [
	trachelCanvas := anObject
]

{ #category : #accessing }
TrachelPresenter >> whenPresenterResized: aBlock [

	self announcer 
		when: PresenterResized 
		do: [ :ann | aBlock cull: ann extent ]
]
