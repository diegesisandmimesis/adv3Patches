#charset "us-ascii"
//
// adv3PatchesAdjFailure.t
//
//	Change the default failure message for no matching object
//	in scope if the input is only used in-game as an adjective.
//
//	So, for example >X SMALL will produce, "You do not see
//	anything small here" instead of "You see no small here".
//
//
#include <adv3.h>
#include <en_us.h>

#include "adv3Patches.h"

_isNoun(txt) { return(cmdDict.findWord(txt, &noun).length > 0); }
_isAdjective(txt) { return(cmdDict.findWord(txt, &adjective).length > 0); }

modify playerMessages
	noMatchCannotSee(actor, txt) {
		if(_isAdjective(txt) && !_isNoun(txt))
			"{You/he} {does} not see anything <<txt>> {|t}here. ";
		else
			"{You/he} {sees} no <<txt>> {|t}here. ";
	}
;
