Class {
	#name : #STCWaterChunk,
	#superclass : #Object,
	#instVars : [
		'position',
		'endHeight',
		'startHeight'
	],
	#category : #'StClassRus-Day5'
}

{ #category : #accessing }
STCWaterChunk >> endHeight [

	^ endHeight
]

{ #category : #accessing }
STCWaterChunk >> endHeight: anObject [

	endHeight := anObject
]

{ #category : #accessing }
STCWaterChunk >> length [
	^endHeight - startHeight
]

{ #category : #accessing }
STCWaterChunk >> position [

	^ position
]

{ #category : #accessing }
STCWaterChunk >> position: anObject [

	position := anObject
]

{ #category : #accessing }
STCWaterChunk >> startHeight [

	^ startHeight
]

{ #category : #accessing }
STCWaterChunk >> startHeight: anObject [

	startHeight := anObject
]
