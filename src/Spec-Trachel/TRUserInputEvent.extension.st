Extension { #name : #TRUserInputEvent }

{ #category : #'*Spec-Trachel' }
TRUserInputEvent class >> fromGtkEvent: aUserInputEvent [
	^ self new
		commandKeyPressed: false;
		controlKeyPressed: false;
		shiftKeyPressed: false;
		optionKeyPressed: false;
		yourself
]
