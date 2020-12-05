Class {
	#name : #PharocksOperatorCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #accessing }
PharocksOperatorCommandLineHandler class >> commandName [
	^ 'pharocks'
]

{ #category : #accessing }
PharocksOperatorCommandLineHandler class >> description [
	^ 'Starts or stops Pharocks Cryptobot. To start by command line, you need first start the app inside Pharo with the API Keys and options'
]

{ #category : #activation }
PharocksOperatorCommandLineHandler >> activate [
	self activateHelp
		ifTrue: [  ^ self ].
		
	(self hasOption: 'startPharocks')
		ifTrue: [ PharocksOperator start ].
			
	(self hasOption: 'stopPharocks')
		ifTrue: [ PharocksOperator stop ].
	
	(self hasOption: 'startCrossRails')
		ifTrue: [ PharocksOperator start ].
			
	(self hasOption: 'stopCrossRails')
		ifTrue: [ PharocksOperator stop ]
]
