Class {
	#name : #GtkBoxAdapter,
	#superclass : #GtkLayoutAdapter,
	#category : #'Mars-Spec-Layout-Box'
}

{ #category : #private }
GtkBoxAdapter >> addConstraits: constraints toChild: childWidget [
	"adds constraits by child."
	
	constraints isExpand ifFalse: [
		| min |
		min := childWidget preferredSizeMinimum.
		constraints width ifNotNil: [ :w | 
			childWidget sizeRequest: w@min y ].
		constraints height ifNotNil: [ :h | 
			childWidget sizeRequest: min x@h ] ].

	^ childWidget
]

{ #category : #private }
GtkBoxAdapter >> applyLayout: aLayout [

	"build of widget was differed up to here (to know what is the direction)"
	widget := aLayout direction newWidgetOn: self.

	self connectToEvents: aLayout. 

	widget 
		homogeneous: aLayout isHomogeneous;
		spacing: aLayout spacing;
		borderWidth: aLayout borderWidth.
		
	self presenter isVisible 
		ifTrue: [ widget show ] 
		ifFalse: [ widget hide ].
	
]

{ #category : #private }
GtkBoxAdapter >> basicAdd: aPresenter constraints: constraints to: gtkWidget [
	| childWidget |

	childWidget := aPresenter buildWithSpec: constraints spec.
	self addConstraits: constraints toChild: childWidget.
	constraints isPlacedAtStart
		ifTrue: [ 
			gtkWidget 
				packStart: childWidget 
				expand: constraints isExpand 
				fill: constraints isFill
				padding: constraints padding ]
		ifFalse: [ 
			gtkWidget 
				packEnd: childWidget 
				expand: constraints isExpand 
				fill: constraints isFill 
				padding: constraints padding ].
			
	^ gtkWidget
]

{ #category : #testing }
GtkBoxAdapter >> childrenWidgets [
	
	^ self widget children
]

{ #category : #factory }
GtkBoxAdapter >> newHorizontal [

	^ GtkBox newHorizontal
]

{ #category : #factory }
GtkBoxAdapter >> newVertical [

	^ GtkBox newVertical
]
