'From Cuis 4.2 of 25 July 2013 [latest update: #2953] on 20 October 2016 at 2:38:17 pm'!
'Description Search for a word in English or Interlingua and find its corresponding Interlingua or English usage.'!
!provides: 'IA-EN-Dictionary' 1 2!
!classDefinition: #IEDict category: #'IA-EN-Dictionary'!
Object subclass: #IEDict
	instanceVariableNames: ''
	classVariableNames: 'DictData'
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDict class' category: #'IA-EN-Dictionary'!
IEDict class
	instanceVariableNames: ''!


!IEDict commentStamp: '<historical>' prior: 0!
I embody a specialized Dictionary of Interlingua->English.

Class intention
	I am not like a regular dictionary because I maintain my definitions in an array of two element
	arrays #('interlingua definition' 'English definition').  All definitions which contain a search match
	are returned.

Instance intention
      I am the model of an IEDictWindow


WORKSPACE:

IEDict initialize.

IEDict interlinguaContains: 'provider'.
IEDict interlinguaStarts: 'provider'.
IEDict interlinguaStarts: 'omni'.
IEDict englishContains: 'day'.
IEDict englishStarts: 'day'.

IEDictWindow open. "-> opens a new IEDictWindow"!

!IEDict class methodsFor: 'lookup' stamp: 'KenD 10/20/2016 14:37:46'!
englishContains: aString
    "Answer all definition pairs which contain aString looking in the Interlingua side"

    | matchStr |
    matchStr :=  ('*' , aString , '*' ) .

    ^ DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 10/20/2016 14:37:41'!
englishStarts: aString
    "Answer all definition pairs which contain aString looking in the Interlingua side"

    | matchStr |
    matchStr :=  (aString , '*' ) .

    ^ DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]! !

!IEDict class methodsFor: 'class initialization' stamp: 'KenD 10/19/2016 16:02:28'!
initialize
	"Read in my data"
"
	IEDict initialize.
"
	| curIndex aLine |
	DictData := Array new: 30811. "We know the exact size (wc -l iedict.txt) less 1"

	(self package fullFileName asFileEntry parent  // 'iedict.txt') readStreamDo: [ :fileStream |
		fileStream nextLine. "Skip initial comment line"
		curIndex := 1.
		aLine := fileStream nextLine. 
		[aLine isNil] whileFalse: [
			DictData at: curIndex put: ((aLine findBetweenSubStrs: ':') collect: [:str| str withBlanksTrimmed]). 
			aLine := fileStream nextLine. 
			curIndex := 1 + curIndex.
		]
	] ! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 10/20/2016 14:37:49'!
interlinguaContains: aString
    "Answer all definition pairs which contain aString looking in the Interlingua side"

    | matchStr |
    matchStr :=  ('*' , aString , '*' ) .

    ^ DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 10/20/2016 14:37:54'!
interlinguaStarts: aString
    "Answer all definition pairs which contain aString looking in the Interlingua side"

    | matchStr |
    matchStr :=  (aString , '*' ) .

    ^ DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !
IEDict initialize!
