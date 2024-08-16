#charset "us-ascii"
//
// adv3PatchesAdjConj.t
//
//	Adds grammar rules for adjective lists.
//
//	The problem:  An object declared with...
//
//		pebble: Thing '(small) (round) pebble' 'pebble'
//			"A small, round pebble. "
//		;
//
//	...gives you...
//
//		> X SMALL, ROUND PEBBLE
//		You see no small here.
//
//	...because "small, round pebble" is parsed as a noun list consisting
//	of two noun phrases, "small" and "round pebble".
//
//	This patch adds a rule for adjectives separated by commas, leading
//	to the phrase being parsed as referring to a single object.
//
//
#include <adv3.h>
#include <en_us.h>

#include "adv3Patches.h"

grammar adjectiveConjunction(main):
	','
	: BasicProd
	isEndOfSentence() { return(nil); }
;

grammar completeNounPhrase(adjConj):
	adjPhrase->ap_ adjectiveConjunction completeNounPhrase->np_
	: NounListProd
	resolveNouns(resolver, results) {
		return(np_.resolveNouns(resolver, results));
	}
	getAdjustedTokens() {
		return(ap_.getAdjustedTokens());
	}
;
