Class {
	#name : #BaselineOfStClassRusDay5,
	#superclass : #BaselineOf,
	#category : #BaselineOfStClassRusDay5
}

{ #category : #baselines }
BaselineOfStClassRusDay5 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3' ].
			   spec package: 'StClassRus-Day5'.
			   spec package: 'StClassRus-Day5-Tests' ]
]
