Class {
	#name : #PharocksLog,
	#superclass : #Object,
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #accessing }
PharocksLog class >> logAdd: aString [
	| logFile timestamp |
	logFile := 'log.txt' asFileReference.
	timestamp := Date current yyyymmdd asString , ' ', Time current asString.
	logFile
		writeStreamDo: [ :s | 
			s setToEnd.
			s 	nextPutAll: timestamp;
				tab;
				nextPutAll: aString asString;
				cr;lf;
				flush ]
]
