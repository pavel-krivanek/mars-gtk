Class {
	#name : #GtkToolBarMenuButtonAdapter,
	#superclass : #GtkToolBarBaseButtonAdapter,
	#instVars : [
		'menuWidget'
	],
	#category : #'Mars-Spec-Adapter'
}

{ #category : #private }
GtkToolBarMenuButtonAdapter >> addModelTo: gtkToolButton [

	super addModelTo: gtkToolButton.
	gtkToolButton connectClicked: self presenter action.
	self updateMenuTo: gtkToolButton.
	gtkToolButton connectShowMenu: [ self updateMenu ]
]

{ #category : #building }
GtkToolBarMenuButtonAdapter >> buildMenu: menuPresenter [

	menuPresenter owner: self presenter.
	menuWidget := SpBindings
		value: self presenter application adapterBindings
		during: [ menuPresenter buildWithSpec ].
	^ menuWidget
]

{ #category : #accessing }
GtkToolBarMenuButtonAdapter >> icon [

	^ self presenter icon 
		ifNotNil: [ :icon | icon asGtkImage ]
		ifNil: [ GtkImage null ]
]

{ #category : #building }
GtkToolBarMenuButtonAdapter >> newWidget [
	
	^ GtkMenuToolButton 
		newIcon: self icon 
		label: (self presenter label ifNil: [ '' ])
]

{ #category : #updating }
GtkToolBarMenuButtonAdapter >> updateMenu [

	self widgetDo: [ :w | self updateMenuTo: w ]
]

{ #category : #updating }
GtkToolBarMenuButtonAdapter >> updateMenuTo: aWidget [

	self presenter menu ifNotNil: [ :aValuable |
		aValuable value ifNotNil: [ :aMenu |
			aWidget menu: (self buildMenu: aMenu) showAll ] ]
]
