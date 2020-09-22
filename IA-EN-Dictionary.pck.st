'From Cuis 5.0 [latest update: #4377] on 22 September 2020 at 12:31:59 pm'!
'Description '!
!provides: 'IA-EN-Dictionary' 1 7!
!requires: 'Morphic-Widgets-Extras' 1 23 nil!
SystemOrganization addCategory: #'IA-EN-Dictionary'!


!classDefinition: #IEDictWindow category: #'IA-EN-Dictionary'!
SystemWindow subclass: #IEDictWindow
	instanceVariableNames: 'entry TextMorph resultMorph promptMorph entryTextMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDictWindow class' category: #'IA-EN-Dictionary'!
IEDictWindow class
	instanceVariableNames: ''!

!classDefinition: #IEDict category: #'IA-EN-Dictionary'!
Object subclass: #IEDict
	instanceVariableNames: 'searchString searchResult resultIndex'
	classVariableNames: 'DictData'
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDict class' category: #'IA-EN-Dictionary'!
IEDict class
	instanceVariableNames: ''!


!IEDictWindow commentStamp: '<historical>' prior: 0!
GUI for Interlingua <-> English dictionary

   IEDictWindow open!

!IEDict commentStamp: 'pa 9/22/2020 10:59:46' prior: 0!
I embody a specialised dictionary for IA-EN interaction

Class intention
	I am not like a regular dictionary because I maintain in an array of two element arrays #('Interlingua definition' 'English definition'). All definitions that contain a search match are returned.


Instance intention
	I am the model of an IEDictWindow!

!IEDictWindow methodsFor: 'instance creation' stamp: 'PA 9/12/2020 15:57:12'!
open
	"IEDictWindow open"

	
	self open: (IEDict new) label: 'Interlingua <-> English'! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'PA 9/21/2020 13:50:54'!
buildMorphicWindow
	"build and layout the window and answer it"

	self layoutMorph
		beColumn; "the default"
		separation: self defaultSeparation;
		layoutSpec: LayoutSpec useAll;
		addMorph: self makeEntryArea;
		addMorph: self makeButtonArea;
		addMorph: self makeResultsArea.
		
	model when: #newSearchResult send: #searchResultsChanged to: self.
	model interlinguaContainsClick. "set initial text"
	
	^ self! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'pa 9/22/2020 12:25:57'!
makeButtonArea
	"Answer a LayoutMorph with our four buttons -- a column of two rows"
	
	|  buttonHeight buttonLayout interlinguaButtonLayout englishButtonLayout buttonArea |
	buttonHeight := self textSizeUnit * 2.
	buttonLayout := LayoutSpec proportionalWidth: 0.3 fixedHeight: buttonHeight.
	
	interlinguaButtonLayout := LayoutMorph newRow. "a row of two buttons"

	interlinguaButtonLayout
		axisEdgeWeight: #center;
		separation: 2;
		addMorph: 
			(PluggableButtonMorph 
				model: self 
				action: #interlinguaContainsClick  
				label: 'Interlingua Contains')  layoutSpec: buttonLayout;
		addMorph: 
			(PluggableButtonMorph 
				model: self 
				action: #interlinguaStartsClick  
				label: 'Interlingua Starts') layoutSpec: buttonLayout.

	englishButtonLayout := LayoutMorph newRow. "a row of two buttons"
									.
	englishButtonLayout
		axisEdgeWeight: #center;
		separation: 2;
		addMorph: 
			(PluggableButtonMorph 
				model: self 
				action: #englishContainsClick  
				label: 'English Contains') layoutSpec: buttonLayout;				
		addMorph: 
			(PluggableButtonMorph 
				model: self
				action: #englishStartsClick  
				label: 'English Starts') layoutSpec: buttonLayout.

	buttonArea := LayoutMorph newColumn.
	^ buttonArea 
			layoutSpec: (LayoutSpec proportionalWidth: 1; fixedHeight: 4 * self textSizeUnit);
			addMorph: interlinguaButtonLayout ;
			addMorph: englishButtonLayout ;
			yourself! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'pa 9/22/2020 12:15:41'!
makeEntryArea
	"Answer a LayoutMoph containing the prompt and text entry area"
	
	| entryLayout entryHeight |
	entryHeight := self defaultSeparation * 2 + self textSizeUnit.
	
	entryLayout := LayoutMorph newRow.
	
	promptMorph := (StringMorph contents: 'Enter Text: ') 
					emphasis: AbstractFont boldCode; 
					yourself.
	promptMorph  layoutSpec: 
		(LayoutSpec fixedWidth: (promptMorph measureContents x)).
			
	entryTextMorph := (OneLineEditorMorph contents: 'salute'). "initial text"
	entryTextMorph 
		crAction: [self interlinguaContainsClick]; "Same action as IA-Contains button"
		layoutSpec: 
			(LayoutSpec proportionalWidth: 0.9).
			
	^ entryLayout 
		axisEdgeWeight: #rowLeft;
		separation: self defaultSeparation;
		layoutSpec: (LayoutSpec proportionalWidth: 1 fixedHeight: entryHeight);
		addMorph: promptMorph;
		addMorph: entryTextMorph;
		yourself! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'PA 9/14/2020 14:37:07'!
makeResultsArea
	"Answer a LayoutMoph containing the results of the query"
	
	resultMorph := (PluggableListMorph
		model: model 
		listGetter: #resultAsList
		indexGetter: #resultIndex
		indexSetter: #resultIndex:
		mainView: self
		menuGetter: nil
		keystrokeAction: nil).
		
	^ resultMorph 
		layoutSpec: (LayoutSpec proportionalWidth: 1.0 proportionalHeight: 0.98);  
		color: (Theme current textHighlight);
		yourself! !

!IEDictWindow methodsFor: 'events' stamp: 'PA 9/14/2020 14:35:44'!
englishContainsClick

	self model searchString: self searchString; englishContainsClick! !

!IEDictWindow methodsFor: 'events' stamp: 'PA 9/14/2020 14:36:09'!
englishStartsClick

	self model searchString: self searchString; englishStartsClick! !

!IEDictWindow methodsFor: 'events' stamp: 'PA 9/14/2020 14:34:52'!
interlinguaContainsClick

	self model searchString: self searchString; interlinguaContainsClick! !

!IEDictWindow methodsFor: 'events' stamp: 'PA 9/14/2020 14:35:20'!
interlinguaStartsClick

	self model searchString: self searchString; interlinguaStartsClick! !

!IEDictWindow methodsFor: 'events' stamp: 'PA 9/21/2020 13:51:28'!
searchResultsChanged
	"Display updated search results"
	
	resultMorph updateList ! !

!IEDictWindow methodsFor: 'geometry' stamp: 'PA 9/14/2020 14:47:27'!
defaultSeparation
	"Answer the number of pixels between fields/layouts"
	
	^ 5 "pixels"! !

!IEDictWindow methodsFor: 'geometry' stamp: 'pa 9/22/2020 12:28:52'!
textSizeUnit
	"Answer the scaling factor for sizing; note  method #fontPreferenceChanged"

	^  12.0! !

!IEDictWindow methodsFor: 'accessing' stamp: 'PA 9/18/2020 16:55:28'!
entryTextMorph
	^entryTextMorph! !

!IEDictWindow methodsFor: 'accessing' stamp: 'PA 9/18/2020 16:55:59'!
promptMorph
	^ promptMorph! !

!IEDictWindow methodsFor: 'accessing' stamp: 'PA 9/18/2020 16:56:22'!
resultMorph
	^ resultMorph! !

!IEDictWindow methodsFor: 'accessing' stamp: 'PA 9/18/2020 16:56:44'!
searchString

	^ entryTextMorph contents asString ! !

!IEDictWindow class methodsFor: 'instance creation' stamp: 'PA 9/14/2020 15:21:52'!
open
	"
	IEDictWindow open.
	"

	self open: (IEDict new) label: 'Interlingua <-> English'! !

!IEDict methodsFor: 'accessing' stamp: 'PA 9/14/2020 14:55:53'!
resultIndex
	
	^ resultIndex! !

!IEDict methodsFor: 'accessing' stamp: 'pa 9/22/2020 11:00:54'!
resultIndex: aNumber
	
	resultIndex _ aNumber! !

!IEDict methodsFor: 'accessing' stamp: 'PA 9/14/2020 14:55:16'!
searchResult
	
	^ searchResult! !

!IEDict methodsFor: 'accessing' stamp: 'PA 9/21/2020 13:48:20'!
searchResult: newResult

	searchResult := newResult.
	self triggerEvent: #newSearchResult! !

!IEDict methodsFor: 'accessing' stamp: 'PA 9/14/2020 14:51:42'!
searchString
	
	^ searchString! !

!IEDict methodsFor: 'accessing' stamp: 'PA 9/14/2020 14:52:09'!
searchString: aRegularExpressionString
	
	searchString := aRegularExpressionString! !

!IEDict methodsFor: 'ui-support' stamp: 'PA 9/14/2020 14:59:44'!
englishContainsClick
	
	self searchResult:  (IEDict englishContains: (self searchString)).
	self resultIndex: 0.! !

!IEDict methodsFor: 'ui-support' stamp: 'PA 9/14/2020 15:00:05'!
englishStartsClick
	
	self searchResult:  (IEDict englishStarts: (self searchString)).
	self resultIndex: 0.! !

!IEDict methodsFor: 'ui-support' stamp: 'PA 9/14/2020 14:58:22'!
interlinguaContainsClick
	
	self searchResult:  (IEDict interlinguaContains: (self searchString)).
	self resultIndex: 0.! !

!IEDict methodsFor: 'ui-support' stamp: 'PA 9/14/2020 14:59:21'!
interlinguaStartsClick
	
	self searchResult:  (IEDict interlinguaStarts: (self searchString)).
	self resultIndex: 0.! !

!IEDict methodsFor: 'ui-support' stamp: 'PA 9/14/2020 15:00:37'!
resultAsList
	"Answer a list of form 'this <---> that' "
	
	^ self searchResult collect:[ :elt | (elt at: 1) , ' <---> ', (elt at: 2) ]! !

!IEDict methodsFor: 'initialization' stamp: 'PA 9/14/2020 14:57:12'!
initialize

	super initialize.
	searchString := 'salute'.
	searchResult := #().
	resultIndex  := 0.! !

!IEDict class methodsFor: 'lookup' stamp: 'PA 9/11/2020 17:02:37'!
englishContains: aString
	"Answer all definition pairs which contain aString looking in the English side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'PA 9/11/2020 17:09:09'!
englishStarts: aString
	"Answer all definition pairs which starts with aString looking in the English side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'PA 9/11/2020 17:01:13'!
interlinguaContains: aString
	"Answer all definition pairs which contain aString looking in the Interlingua side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'PA 9/11/2020 17:01:55'!
interlinguaStarts: aString
	"Answer all definition pairs which starts with aString looking in the Interlingua side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !

!IEDict class methodsFor: 'class initialization' stamp: 'PA 9/11/2020 16:46:49'!
initialize
	"Read in my data"
"
	IEDict initialize.
"
	| curIndex aLine |
	DictData := Array new: 31034. "We know the exact size (wc -l iedict.txt) less 1"

	(self package fullFileName asFileEntry parent  // 'iedict.txt') readStreamDo: [ :fileStream |
		fileStream nextLine. "Skip initial comment line"
		curIndex := 1.
		aLine := fileStream nextLine. 
		[aLine isNil] whileFalse: [
			DictData at: curIndex 
				  put: ((aLine findBetweenSubStrs: ':') 
						collect: [:str| str withBlanksTrimmed]). 
			aLine := fileStream nextLine. 
			curIndex := 1 + curIndex.
		]
	] ! !
IEDict initialize!
