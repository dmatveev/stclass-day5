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

{ #category : #rendering }
STCTrappingRainwater >> drops [
	^chunks collect: [ :each || drop |
		"For a better visual, stretch the water chunk up to the 
		current position"
		 drop := RSBox new
			width: self boxSize * (currentPosition - each position);
			height: self boxSize * each length;
			color: Color lightBlue;
			model: each;
			translateBottomLeftTo: (self boxSize * (each position - 1))
										@ (self boxSize * each startHeight negated);
			yourself ]
]

{ #category : #accessing }
STCTrappingRainwater >> elevationMap: anArray [
	elevationMap := anArray.
	trapped := 0.
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

{ #category : #rendering }
STCTrappingRainwater >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'View'>
	| c |
	c := RSCanvas new.
	self renderOn: c.
	^ SpRoassal3InspectorPresenter new
		canvas: c;
		yourself
]

{ #category : #rendering }
STCTrappingRainwater >> marker [
	^RSCircle new
		size: self boxSize;
		color: Color lightGreen;
		translateTopRightTo: (self boxSize * currentPosition) @ 0;
		yourself.
]

{ #category : #accessing }
STCTrappingRainwater >> newChunk: atPosition from: higherPoint to: lowerPoint [
	^STCWaterChunk new
				position: atPosition;
				startHeight: higherPoint;
				endHeight: lowerPoint;
				yourself
]

{ #category : #rendering }
STCTrappingRainwater >> renderOn: aCanvas [
	aCanvas addAll: self rocks.
	aCanvas addAll: self drops.
	currentPosition ifNotNil: [	aCanvas add: self marker].
	aCanvas @ RSCanvasController.
]

{ #category : #rendering }
STCTrappingRainwater >> rocks [
	| x |
	x := 0.
	^ elevationMap collect: [ :each || box |
		box := RSBox new
			width: self boxSize;
			height: self boxSize * each;
			color: Color lightGray;
			model: each;
			translateBottomLeftTo: (self boxSize * x) @ 0.
		x := x + 1.
		box ]
]

{ #category : #accessing }
STCTrappingRainwater >> solve [
	elevationMap size <= 1 ifTrue: [ ^0 ].
	2 to: elevationMap size do: [ :i |
		self currentPosition: i.
		self handle: i ].
	"Reset the internal state to avoid artifacts in the
	solved visualization"
	chunks removeAll.
	currentPosition := nil.
	^trapped
]
