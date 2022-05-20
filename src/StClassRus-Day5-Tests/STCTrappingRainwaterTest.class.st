Class {
	#name : #STCTrappingRainwaterTest,
	#superclass : #TestCase,
	#instVars : [
		'solver'
	],
	#category : #'StClassRus-Day5-Tests'
}

{ #category : #initialization }
STCTrappingRainwaterTest >> setUp [
	super setUp.
	solver := STCTrappingRainwater new.
]

{ #category : #initialization }
STCTrappingRainwaterTest >> testSolveLC1 [
	solver elevationMap: #(0 1 0 2 1 0 1 3 2 1 2 1).
	self assert: solver solve equals: 6.
]

{ #category : #initialization }
STCTrappingRainwaterTest >> testSolveLC2 [
	solver elevationMap: #(4 2 0 3 2 5).
	self assert: solver solve equals: 9.
]
