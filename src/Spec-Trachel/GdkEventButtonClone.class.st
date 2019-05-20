Class {
	#name : #GdkEventButtonClone,
	#superclass : #Object,
	#instVars : [
		'axes',
		'button',
		'device',
		'send_event',
		'state',
		'time',
		'type',
		'window',
		'x',
		'x_root',
		'y',
		'y_root'
	],
	#pools : [
		'GdkEventMask'
	],
	#category : #'Spec-Trachel'
}

{ #category : #'instance creation' }
GdkEventButtonClone class >> from: aGdkEvntButton [

	^ self new 
		axes: aGdkEvntButton axes;
		button: aGdkEvntButton button;
		device: aGdkEvntButton device;
		send_event: aGdkEvntButton send_event;
		state: aGdkEvntButton state;
		time: aGdkEvntButton time;
		type: aGdkEvntButton type;
		x: aGdkEvntButton x;
		x_root: aGdkEvntButton x_root;
		y: aGdkEvntButton y;
		y_root: aGdkEvntButton y_root;
		yourself
]

{ #category : #accessing }
GdkEventButtonClone >> axes [
	^ axes
]

{ #category : #accessing }
GdkEventButtonClone >> axes: anObject [
	axes := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> button [
	^ button
]

{ #category : #accessing }
GdkEventButtonClone >> button: anObject [
	button := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> device [
	^ device
]

{ #category : #accessing }
GdkEventButtonClone >> device: anObject [
	device := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> position [

	^ self x @ self y
]

{ #category : #accessing }
GdkEventButtonClone >> send_event [
	^ send_event
]

{ #category : #accessing }
GdkEventButtonClone >> send_event: anObject [
	send_event := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> state [
	^ state
]

{ #category : #accessing }
GdkEventButtonClone >> state: anObject [
	state := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> time [
	^ time
]

{ #category : #accessing }
GdkEventButtonClone >> time: anObject [
	time := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> type [
	^ type
]

{ #category : #accessing }
GdkEventButtonClone >> type: anObject [
	type := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> window [
	^ window
]

{ #category : #accessing }
GdkEventButtonClone >> window: anObject [
	window := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> x [
	^ x
]

{ #category : #accessing }
GdkEventButtonClone >> x: anObject [
	x := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> x_root [
	^ x_root
]

{ #category : #accessing }
GdkEventButtonClone >> x_root: anObject [
	x_root := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> y [
	^ y
]

{ #category : #accessing }
GdkEventButtonClone >> y: anObject [
	y := anObject
]

{ #category : #accessing }
GdkEventButtonClone >> y_root [
	^ y_root
]

{ #category : #accessing }
GdkEventButtonClone >> y_root: anObject [
	y_root := anObject
]
