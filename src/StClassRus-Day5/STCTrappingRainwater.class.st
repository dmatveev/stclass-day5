Class {
	#name : #STCTrappingRainwater,
	#superclass : #Object,
	#instVars : [
		'elevationMap',
		'trapped',
		'chunks',
		'currentPosition'
	],
	#category : #'StClassRus-Day5'
}

{ #category : #accessing }
STCTrappingRainwater >> boxSize [
	^10
]

{ #category : #accessing }
STCTrappingRainwater >> countTrapped: anInteger [
	trapped := trapped + anInteger
]

{ #category : #private }
STCTrappingRainwater >> currentPosition: anObject [

	currentPosition := anObject
]

{ #category : #accessing }
STCTrappingRainwater >> elevationMap: anArray [
	elevationMap := anArray.
	trapped := 0.
	currentPosition := 0.
	chunks := Stack new.
]

{ #category : #accessing }
STCTrappingRainwater >> handle: i [
		| hThis hPrev |
		hThis := elevationMap at: i.
		hPrev := elevationMap at: i-1.
		hThis < hPrev ifTrue: [ chunks push: (self newChunk: i from: hThis to: hPrev) ].
		hThis > hPrev
			ifTrue: [ [ chunks isEmpty ] whileFalse: [ | chunk | 
				chunk := chunks top.
				chunk endHeight <= hThis
					ifTrue: [self countTrapped: chunk length * (i - chunk position).
								chunks pop]
					ifFalse: [	self countTrapped: (hThis - chunk startHeight) * (i - chunk position).
									chunk startHeight: hThis.
									^self "break the loop - element stays in the stack"]]]
]

{ #category : #accessing }
STCTrappingRainwater >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'View'>
	| c |
	c := RSCanvas new.
	self renderOn: c.
	^ SpRoassal3InspectorPresenter new
		canvas: c;
		yourself
]

{ #category : #accessing }
STCTrappingRainwater >> newChunk: atPosition from: higherPoint to: lowerPoint [
	^STCWaterChunk new
				position: atPosition;
				startHeight: higherPoint;
				endHeight: lowerPoint;
				yourself
]

{ #category : #accessing }
STCTrappingRainwater >> renderOn: aCanvas [
	| high x rocks drops |
	high := elevationMap max.
	x := 0.
	rocks := elevationMap collect: [ :each || box |
		box := RSBox new
			width: self boxSize;
			height: self boxSize * each;
			color: Color lightGray;
			translateBottomLeftTo: (self boxSize * x) @ 0.
		x := x + 1.
		box ].
	drops := chunks collect: [ :each || drop |
		 drop := RSBox new
			width: self boxSize;
			height: self boxSize * each length;
			color: Color lightBlue;
			model: each;
			translateBottomRightTo: (self boxSize * each position) @ (self boxSize * each startHeight negated);
			yourself ].
	currentPosition ifNotNil: [ | marker |
		marker := RSCircle new
			size: self boxSize;
			color: Color lightGreen;
			translateTopLeftTo: (self boxSize * currentPosition) @ 0;
			yourself.
		aCanvas add: marker].
	aCanvas addAll: rocks.
	aCanvas addAll: drops.
	aCanvas @ RSCanvasController.
]

{ #category : #accessing }
STCTrappingRainwater >> solve [
	elevationMap size <= 1 ifTrue: [ ^0 ].
	2 to: elevationMap size do: [ :i |
		self currentPosition: i.
		self handle: i ].
	^trapped
]
