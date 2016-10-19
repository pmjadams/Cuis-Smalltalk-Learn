'From Cuis 4.2 of 25 July 2013 [latest update: #2953] on 19 October 2016 at 3:18:08 pm'!
'Description Please enter a description for this package'!
!provides: 'IA-EN-Dictionary' 1 0!
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
