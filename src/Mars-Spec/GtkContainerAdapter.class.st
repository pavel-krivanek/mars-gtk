Class {
	#name : #GtkContainerAdapter,
	#superclass : #GtkAdapter,
	#category : #'Mars-Spec-Adapter'
}

{ #category : #protocol }
GtkContainerAdapter >> add: anAdapter [ 
	
	self widgetDo: [ :this | 
		this packStart: anAdapter asWidget ]
]

{ #category : #protocol }
GtkContainerAdapter >> isRedrawable [

	^ true
]

{ #category : #building }
GtkContainerAdapter >> newWidget [

	^ GtkBox newVertical
		show;
		yourself
]

{ #category : #protocol }
GtkContainerAdapter >> removeSubWidgets [


]
