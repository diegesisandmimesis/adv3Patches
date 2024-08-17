#charset "us-ascii"
//
// adv3PatchesAdjFailure.t
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
