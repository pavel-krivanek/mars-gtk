Class {
	#name : #GtkTrachel,
	#superclass : #GtkDrawingArea,
	#instVars : [
		'trachelCanvas',
		'activeSurface'
	],
	#category : #'Spec-Trachel'
}

{ #category : #private }
GtkTrachel class >> drawingAreaNew [
	^ self ffiCall: #( GtkTrachel *gtk_drawing_area_new () )
]

{ #category : #drawing }
GtkTrachel >> basicDraw: cr [

	self 
		setSourceSurfaceTo: cr
		surface: activeSurface getHandle
		x: 0.0 
		y: 0.0.
	self paint: cr
]

{ #category : #drawing }
GtkTrachel >> changed [ 

	super changed.
	self repaint.
]

{ #category : #drawing }
GtkTrachel >> draw: cr [

	self basicDraw: cr.
	^ true
]

{ #category : #drawing }
GtkTrachel >> drawOnAthensCanvas: aCanvas [

	| s |
	s := aCanvas surface createPath: [:builder |
				builder
			absolute;
			moveTo:  0 @ 0;
			lineTo: 250 @ 0;
			lineTo: 250 @ 250;
			lineTo: 0 @ 250		
		].
	
"	self inform: 'camera: ', trachelCanvas camera position asString ."
"	self inform: 'size: ', (((self size)) / 2) asFloatPoint asString .
""	self inform: 'size: ', aCanvas surface extent  asString ."
	
	aCanvas	
		setPaint: Color white;
		drawShape: s.	

		"We display the elements that are subject to the camera"
		aCanvas pathTransform
				translateBy: (((aCanvas surface extent)) / 2) asFloatPoint;
			    scaleBy: trachelCanvas camera scale asFloat;
			translateBy: trachelCanvas camera position negated asFloatPoint.
		trachelCanvas shapesDo: [ :trachelShape |
			trachelShape isMarkedAsVisible ifTrue: [ trachelShape drawOn: aCanvas ].
		].
	
		"We display the elements that are _NOT_ subject to the camera"
		aCanvas pathTransform loadIdentity scaleBy: 1.001.
		trachelCanvas fixedShapesDo: [ :trachelShape |
			trachelShape isMarkedAsVisible ifTrue: [ trachelShape drawOn: aCanvas ].
		].


]

{ #category : #accessing }
GtkTrachel >> events: events [

	self ffiCall: #(void gtk_widget_set_events (self, gint events))

]

{ #category : #accessing }
GtkTrachel >> newCairoSurface [
	| newSurface |

	newSurface := AthensCairoSurface extent: self trachelCanvas extent.
	newSurface drawDuring: [ :canvas |
		self drawOnAthensCanvas: canvas ].
	^ newSurface
]

{ #category : #drawing }
GtkTrachel >> paint: cr [

	self 
		ffiCall: #(void cairo_paint (void *cr))
		module: CairoLibrary
]

{ #category : #accessing }
GtkTrachel >> repaint [

	self resetSurface.
	self queueDraw.

]

{ #category : #accessing }
GtkTrachel >> resetSurface [

	activeSurface := self newCairoSurface.

]

{ #category : #drawing }
GtkTrachel >> setSourceSurfaceTo: cr surface: surface x: x y: y [

	self 
		ffiCall: #(void cairo_set_source_surface (void *cr, void *surface, double x,  double y))
		module: CairoLibrary
]

{ #category : #accessing }
GtkTrachel >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #accessing }
GtkTrachel >> trachelCanvas: anObject [
	trachelCanvas := anObject.
	trachelCanvas morph: self.
	
	activeSurface := self newCairoSurface.
	self sizeRequest: trachelCanvas extent
]
