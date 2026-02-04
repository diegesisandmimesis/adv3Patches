#charset "us-ascii"
//
// adv3PatchesThingState.t
//
//	A patch to ThingState.  Features:
//
//		-stateTokens matching is now case-insensitive
//		-possessive adjectives now work in stateTokens
//
//
#include <adv3.h>
#include <en_us.h>

#include "adv3Patches.h"

modify ThingState
	matchName(obj, origTokens, adjustedTokens, states) {
		local i, len, tok;

		len = adjustedTokens.length();

		// Every other token is text, and those are the only
		// ones we care about.
		for(i = 1; i <= len; i += 2) {
			tok = adjustedTokens[i];
			if(matchStateToken(tok))
				continue;

			// The current token ISN'T one of the current
			// state's stateTokens.  So now we check to see if
			// it IS in another state's stateToken list.  If it
			// is, we DO NOT match, because we're not in that
			// state.
			if(states.indexWhich({ x: x.matchStateToken(tok) })
				!= nil)
				return(nil);
		}

		// Looks okay, match.
		return(obj);
	}

	// Returns bookean true if our state tokens list contains the
	// given token, matched case-insensitively, and matching possessives.
	matchStateToken(tok) {
		tok = tok.toLower();

		return(stateTokens.indexWhich(function(o) {
			// Make it lower case.
			o = o.toLower();

			// If it's a possessive, chop of the
			// apostrophe-S ending.
			if(o.endsWith('\'s'))
				o = o.substr(1, o.length() - 2);

			// See if it matches.
			return(o == tok);
		}) != nil);
	}
;
