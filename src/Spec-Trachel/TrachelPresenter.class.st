Class {
	#name : #TrachelPresenter,
	#superclass : #AbstractWidgetPresenter,
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
TrachelPresenter >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #accessing }
TrachelPresenter >> trachelCanvas: anObject [
	trachelCanvas := anObject
]
