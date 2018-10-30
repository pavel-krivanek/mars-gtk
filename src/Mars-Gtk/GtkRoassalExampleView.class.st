Class {
	#name : #GtkRoassalExampleView,
	#superclass : #GtkDrawingArea,
	#instVars : [
		'view'
	],
	#category : #'Mars-Gtk-Examples'
}

{ #category : #private }
GtkRoassalExampleView class >> drawingAreaNew [
	^ self ffiCall: #(GtkRoassalExampleView *gtk_drawing_area_new ())
]

{ #category : #drawing }
GtkRoassalExampleView >> drawEmptyOn: canvas [
	
	canvas surface directDrawDuring: [ :c |
		canvas
			setPaint: Color white;
			drawShape: (self positionInTopLevel extent: self allocation extent) ]
]

{ #category : #drawing }
GtkRoassalExampleView >> drawOnAthensCanvas: aCanvas [
	
	self view 
		ifNotNil: [ self drawViewOn: aCanvas ]
		ifNil: [ self drawEmptyOn: aCanvas ]
]

{ #category : #drawing }
GtkRoassalExampleView >> drawViewOn: aCanvas [
	
	[
		aCanvas surface drawDuring: [ :canvas |
			canvas surface clear.
			canvas pathTransform loadIdentity.	
			canvas 
				setPaint: self view canvas canvas;
				drawShape: ((self positionInTopLevel extent: self allocation extent)) ] ]
	on: Error 
	fork: [ :e | e pass ]
]

{ #category : #accessing }
GtkRoassalExampleView >> view [
	^ view
]

{ #category : #accessing }
GtkRoassalExampleView >> view: aView [

	view := aView.
	self queueDraw
]