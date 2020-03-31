Class {
	#name : #BaselineOfMarsCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfMarsCore
}

{ #category : #baseline }
BaselineOfMarsCore >> baseline: spec [
	<baseline>

	spec
		for: #common
		do: [ 
			spec postLoadDoIt: #postLoad.

			spec
				"core"
				package: 'Mars-Pango';
				package: 'Mars-Gtk' with: [ spec requires: #('Mars-Pango') ];
				"spec"
				package: 'Mars-Spec-Text' with: [ spec requires: 'Mars-Gtk' ];
				package: 'Mars-Spec-Keybindings' with: [ spec requires: 'Mars-Gtk' ];
				package: 'Mars-Spec' with: [ spec requires: #('Mars-Gtk' 'Mars-Spec-Text' 'Mars-Spec-Keybindings') ] ]
]

{ #category : #'external projects' }
BaselineOfMarsCore >> beacon: spec [

	spec baseline: 'Beacon' with: [ 
		spec repository: 'github://pharo-project/pharo-beacon/repository' ]
]

{ #category : #doits }
BaselineOfMarsCore >> installGtkDriver [
			
	"Do not switch driver if we are in windows"
	self flag: #TODO. "Hepefully temporal :)"
	Smalltalk platform isWindows ifTrue: [ ^ self ]. 
			
	"If we installed OSGtkDriver, we want to use it as default"
	Smalltalk globals
		at: #OSGtkDriver
		ifPresent: [ :driverClass | OSWindowDriver driverClass: driverClass ]
]

{ #category : #doits }
BaselineOfMarsCore >> postLoad [

	self installGtkDriver.
	self recompileStructures
]

{ #category : #doits }
BaselineOfMarsCore >> recompileStructures [
	"Recompile structures (just to be sure we match everything we need"

	(Smalltalk at: #GtkEnumeration) allSubclassesDo: #initializeEnumeration.
	(Smalltalk at: #GtkStructure) allSubclassesDo: #compileFields.
	(Smalltalk at: #GtkWidget) withAllSubclassesDo: #recompile
]

{ #category : #'external projects' }
BaselineOfMarsCore >> spec2: spec [

	spec baseline: 'Spec2' with: [ 
		spec repository: 'github://pharo-spec/Spec' ]
]

{ #category : #'external projects' }
BaselineOfMarsCore >> taskit: spec [

	spec 
		baseline: 'TaskIt' 
		with: [ spec repository: 'github://sbragagnolo/taskit' ]
]

{ #category : #'external projects' }
BaselineOfMarsCore >> threadedffi: spec [

	spec baseline: 'ThreadedFFI' with: [ 
		spec repository: 'github://pharo-project/threadedFFI-Plugin' ]
]
