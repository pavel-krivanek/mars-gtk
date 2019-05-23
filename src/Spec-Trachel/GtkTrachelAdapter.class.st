Class {
	#name : #GtkTrachelAdapter,
	#superclass : #GtkAdapter,
	#instVars : [
		'trachelCanvas',
		'drawingArea',
		'anyButtonPressed',
		'eventBeginingDragging',
		'shapeBeingPointed',
		'shapeUnderDrag',
		'lastButton',
		'clickEventClone'
	],
	#pools : [
		'GdkEventMask'
	],
	#category : #'Spec-Trachel'
}

{ #category : #'instance creation' }
GtkTrachelAdapter class >> trachelCanvas: aCanvas [

	^ self new
		trachelCanvas: aCanvas;
		yourself
]

{ #category : #accessing }
GtkTrachelAdapter >> addModelTo: gtkWidget [

	widget := gtkWidget.
	widget events: GDK_ALL_EVENTS_MASK value.

	"widget connectClicked: [ self inspect ]."
	widget connectKeyPressEvent:  [ :event | self inform: event type asString. true ].
	
	widget connectButtonPressEvent:  [ :event | self mouseDown: event. true ].
	widget connectButtonReleaseEvent:  [ :event | self mouseUp: event. true ].
	widget connectButtonReleaseEvent:  [ :event | true ].
	widget connectMotionNotify: [ :event | self mouseMove: event. true ].
	widget connectEnterNotify: [ :event | self mouseEnter: event. true ].
	widget connectLeaveNotify: [ :event | self mouseLeave: event. true ].
	widget connectSizeAllocate: [ :aRect | self resizeTo: aRect ].

	
"	widget connectMotionNotify: [ :arg | self inform: arg x asString. false ].
"	widget connectScroll: [ :arg | self inform: arg y asString. false ].
"	widget connect: 'button_press_event' do: [ #down logCr ].	
	widget connect: 'button_release_event' do: [ #up logCr ].
	widget connect: 'key_press_event' do: [ #keyPress logCr ].
	widget connect: 'key_release_event' do: [ #keyRelease logCr ].
	widget connect: 'key_press_event' do: [ #keyPress logCr ].
"
"	widget connect: 'enter-notify-event' do: [ #enter logCr ].
	widget connect: 'leave-notify-event' do: [ #leave logCr ].
"

]

{ #category : #accessing }
GtkTrachelAdapter >> announceToEventOverseer: evt [
	self eventOverseer ifNil: [ ^ self ].
	self eventOverseer firedEvent: evt 
]

{ #category : #accessing }
GtkTrachelAdapter >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent [
	| relativePosition trEvent shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self shapeWithAction: anActionClass forPositionInPixels: relativePosition.

	trEvent := anEventClass fromGtkEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: trachelCanvas;
		shape: shape;
		position: relativePosition.
	^ trEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent under: aShape [
	| relativePosition shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self
		shapeWithAction: anActionClass
		forPositionInPixels: relativePosition
		under: aShape.
	^ (anEventClass fromGtkEvent: aMorphicEvent)
		morph: self;
		canvas: trachelCanvas;
		shape: shape;
		position: relativePosition;
		yourself
]

{ #category : #accessing }
GtkTrachelAdapter >> eventOfClass: anEventClass from: aMorphicEvent [
	^ self eventOfClass: anEventClass actionClass: anEventClass from: aMorphicEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> eventOfClass: anEventClass shape: aShape from: aMorphicEvent [
	| relativePosition trEvent |
	relativePosition := self relativePositionFor: aMorphicEvent.

	trEvent := anEventClass fromGtkEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: trachelCanvas;
		shape: aShape;
		position: relativePosition.
	^ trEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> eventOverseer [
	^ trachelCanvas eventOverseer
]

{ #category : #accessing }
GtkTrachelAdapter >> handleMouseOver: aMorphicEvent [
	| currentElement trEvent |

	self isDragging
		ifTrue: [ ^ self ].	"Do nothing if we are dragging"
	shapeBeingPointed ifNil: [ shapeBeingPointed := self shapeForEvent: aMorphicEvent ].
	currentElement := self shapeForEvent: aMorphicEvent.
	currentElement == shapeBeingPointed
		ifTrue: [ ^ self ].
	trEvent := self eventOfClass: TRMouseLeave from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	shapeBeingPointed := currentElement.
	self trMouseEnter: aMorphicEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> initialize [ 
	
	super initialize.
	
	anyButtonPressed := false.
]

{ #category : #accessing }
GtkTrachelAdapter >> isDragging [
	^ eventBeginingDragging notNil
]

{ #category : #accessing }
GtkTrachelAdapter >> mouseDown: evt [

	anyButtonPressed := true.
	
	clickEventClone := evt copyInMemory.
	
	"TRMouseLeftClick"
	
"	self inform: 'evt: ', (evt position) asString.
	self inform: 'point: ', (self relativePositionFor: evt) asString.
"	
"	self trMouseDragStart: evt.	
"


"	eventBeginingDragging
		ifNil:
			[ evt hand
				waitForClicksOrDrag: self
				event: evt
				selectors: {#trMouseClick:. #trMouseDoubleClick:. nil. #trMouseDragStart:. }
				threshold: 5.
			^ self ]."

"	evt anyButtonPressed
		ifTrue: [ self trMouseDragging: evt ].
	evt wasHandled: true"
]

{ #category : #accessing }
GtkTrachelAdapter >> mouseEnter: evt [
	anyButtonPressed
		ifFalse: [ self trMouseEnter: evt ].

]

{ #category : #accessing }
GtkTrachelAdapter >> mouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aMorphicEvent [
	| trEventClass |
	trEventClass := defaultClass.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := leftButtonClass ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := rightButtonClass ].
	^ self eventOfClass: trEventClass actionClass: defaultClass from: aMorphicEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> mouseLeave: evt [
	anyButtonPressed
		ifFalse: [ self trMouseLeave: evt ].

]

{ #category : #accessing }
GtkTrachelAdapter >> mouseMove: evt [

	clickEventClone ifNil: [ 
		anyButtonPressed
			ifTrue: [ 
				self trMouseDragging: evt ]
			ifFalse: [ self trMouseMove: evt ].
		"emulate mouse over"
		self handleMouseOver: evt].

	(clickEventClone notNil and: [ (evt position distanceTo: clickEventClone position) > 5 ])
		ifTrue: [ 
			clickEventClone position logCr.
			clickEventClone button logCr.
			self trMouseDragStart: clickEventClone.
			clickEventClone := nil.
 ].
				

		

]

{ #category : #accessing }
GtkTrachelAdapter >> mouseUp: evt [

	clickEventClone := nil.

	self isDragging
		ifTrue: [ 
			self trMouseDragEnd: evt ]
		ifFalse: [ 
			self trMouseClick: evt ]

]

{ #category : #accessing }
GtkTrachelAdapter >> newWidget [

	trachelCanvas := model trachelCanvas.
	^ GtkTrachel new trachelCanvas: model trachelCanvas.		
	
]

{ #category : #accessing }
GtkTrachelAdapter >> relativePositionFor: evt [
	"Return the position within the window"
			
	^ "trachelCanvas camera fromPixelToSpace: "evt position
]

{ #category : #accessing }
GtkTrachelAdapter >> resizeTo: aRect [


	trachelCanvas extent: aRect extent.
	model announcer announce: (PresenterResized new extent: aRect extent).
	widget repaint.
]

{ #category : #accessing }
GtkTrachelAdapter >> shapeForEvent: anEvent [
	"Return the Trachel shape for the event provided as argument"
	^ self shapeWithActionForPositionInPixels: (self relativePositionFor: anEvent)
]

{ #category : #accessing }
GtkTrachelAdapter >> shapeWithAction: eventClass forPositionInPixels: position [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithAction: eventClass forPositionInPixels: position
]

{ #category : #accessing }
GtkTrachelAdapter >> shapeWithAction: eventClass forPositionInPixels: position under: aShape [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithAction: eventClass forPositionInPixels: position under: aShape
]

{ #category : #accessing }
GtkTrachelAdapter >> shapeWithActionForPositionInPixels: point [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithActionForPositionInPixels: point
]

{ #category : #accessing }
GtkTrachelAdapter >> trMouseClick: aMorphicEvent [
	| trEvent evtClass |

	evtClass := TRMouseClick.
	aMorphicEvent isPrimaryButton ifTrue: [ 
		lastButton := #left.
		evtClass := TRMouseLeftClick ].
	aMorphicEvent isSecondaryButton ifTrue: [ 
		lastButton := #right.		
		evtClass := TRMouseRightClick ].
	aMorphicEvent isDoubleClick ifTrue: [ 
		lastButton = #left ifTrue: [ evtClass := TRMouseDoubleLeftClick ].
		lastButton = #right ifTrue: [ evtClass := TRMouseDoubleRightClick ]  ].

	trEvent := self eventOfClass: evtClass actionClass: TRMouseClick from: aMorphicEvent.
"	trEvent := self
		mouseEventOfClass: TRMouseClick
		ifLeftButton: TRMouseLeftClick
		ifRightButton: TRMouseRightClick
		from: aMorphicEvent."
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> trMouseDragEnd: aMorphicEvent [
	| trEvent dropEvent |
	trEvent := self eventOfClass: TRMouseDragEnd from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent.

	(shapeBeingPointed isKindOf: TRCanvas) ifFalse: [
		dropEvent := self eventOfClass: TRMouseDragDrop shape: shapeUnderDrag from: aMorphicEvent.
		dropEvent draggedShape: shapeBeingPointed.
		shapeUnderDrag announce: dropEvent.
		self announceToEventOverseer: dropEvent.
	].
	
	eventBeginingDragging := nil.
	shapeBeingPointed := nil.
	shapeUnderDrag := nil.
]

{ #category : #accessing }
GtkTrachelAdapter >> trMouseDragStart: aGdkEventButton [
	| trEvent trEventClass trUnderDragEvent |
	eventBeginingDragging := aGdkEventButton copy.
	
	trEventClass := TRMouseDragStart.
	aGdkEventButton button = 1
		ifTrue: [ trEventClass := TRMouseLeftDragStart ].
	aGdkEventButton button = 2
		ifTrue: [ trEventClass := TRMouseRightDragStart ].
	aGdkEventButton button = 3
		ifTrue: [ trEventClass := TRMouseMiddleDragStart ].
	trEvent := self eventOfClass: trEventClass actionClass: TRMouseDragging from: aGdkEventButton.

	shapeBeingPointed := trEvent shape.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent.
	
	(shapeBeingPointed isKindOf: TRCanvas)
		ifTrue: [ ^self ].
	
	trUnderDragEvent := self eventOfClass: TRMouseAbstractDrop actionClass: TRMouseAbstractDrop from:  aGdkEventButton under: shapeBeingPointed.
	
	shapeUnderDrag := trUnderDragEvent shape
	
	
]

{ #category : #accessing }
GtkTrachelAdapter >> trMouseDragging: aMorphicEvent [
	| trEvent step underShape trUnderDragEvent overEvent |
	eventBeginingDragging ifNil: [ ^ self ].
	step := aMorphicEvent position - eventBeginingDragging position.

	trEvent := self eventOfClass: TRMouseDragging from: aMorphicEvent.
	trEvent step: step.

	shapeBeingPointed ifNil: [ shapeBeingPointed := trEvent shape ].
	"If the element was removed during the drag then cancel the event"
	shapeBeingPointed canvas
		ifNil: [ eventBeginingDragging := nil.
			shapeBeingPointed := nil.
			^ self ].

	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent.
	eventBeginingDragging := aMorphicEvent copy.

	(shapeBeingPointed isKindOf: TRCanvas) ifTrue: [ ^self ].	

	trUnderDragEvent := self eventOfClass: TRMouseAbstractDrop actionClass: TRMouseAbstractDrop from:  aMorphicEvent under: shapeBeingPointed.
	trUnderDragEvent draggedShape: shapeBeingPointed.
	underShape := trUnderDragEvent shape.
		
	underShape = shapeUnderDrag ifFalse: [ |leaveEvent enterEvent|
		leaveEvent := self eventOfClass: TRMouseDragLeave shape: shapeUnderDrag from: aMorphicEvent.
		leaveEvent draggedShape: shapeBeingPointed.
		shapeUnderDrag announce: leaveEvent.
		self announceToEventOverseer: leaveEvent.
		enterEvent := self eventOfClass: TRMouseDragEnter shape: underShape from: aMorphicEvent.
		enterEvent draggedShape: shapeBeingPointed.
		underShape announce: enterEvent.
		self announceToEventOverseer: enterEvent.
		shapeUnderDrag := underShape.
	].

	overEvent := self eventOfClass: TRMouseDragOver shape: shapeUnderDrag from: aMorphicEvent.
	overEvent draggedShape: shapeBeingPointed.
	shapeUnderDrag announce: overEvent.
	self announceToEventOverseer: overEvent.
]

{ #category : #accessing }
GtkTrachelAdapter >> trMouseEnter: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TRMouseEnter from: aMorphicEvent.
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> trMouseLeave: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TRMouseLeave from: aMorphicEvent.
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> trMouseMove: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TRMouseMove from: aMorphicEvent.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkTrachelAdapter >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #accessing }
GtkTrachelAdapter >> trachelCanvas: anObject [
	trachelCanvas := anObject.

]
