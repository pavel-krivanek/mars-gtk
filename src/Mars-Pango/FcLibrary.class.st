Class {
	#name : #FcLibrary,
	#superclass : #FFILibrary,
	#category : #'Mars-Pango-FontConfig'
}

{ #category : #accessing }
FcLibrary class >> fcInit [

	^ self uniqueInstance fcInit
]

{ #category : #accessing }
FcLibrary >> fcInit [

	^ self ffiCall: #(FcBool FcInit())
]

{ #category : #'accessing platform' }
FcLibrary >> macModuleName [

	GtkLibrary isDebug ifTrue: [ '/opt/gtk/inst/lib/libfontconfig.dylib' ].
	^ '/usr/local/lib/libfontconfig.dylib'
]