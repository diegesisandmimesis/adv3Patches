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
		local cur, i, len;

		len = adjustedTokens.length();

		// Every other token is text, and those are the only
		// ones we care about.
		for(i = 1; i <= len; i += 2) {
			// Make sure the tokens are lower-case
			cur = adjustedTokens[i].toLower();

			// Check to see if the current token is in the
			// curent state's stateTokens list.  If it is,
			// we're done with it;  we're happy to match
			// vocabulary associated with the current
			// state, regardless of whether or not the token
			// is in another state's vocabulary.
			if(stateTokens.indexWhich(function(o) {
				// Make it lower case.
				o = o.toLower();

				// If it's a possessive, chop of the
				// apostrophe-S ending.
				if(o.endsWith('\'s'))
					o = o.substr(1, o.length() - 2);

				// See if it matches.
				return(o == cur);
			}) != nil)
				continue;

			// The current token ISN'T one of the current
			// state's stateTokens.  So now we check to see if
			// it IS in another state's stateToken list.  If it
			// is, we DO NOT match, because we're not in that
			// state.
			if(states.indexWhich({ x: x.stateTokens
				.indexWhich(function(o) {
					// Make it lower case.
					o = o.toLower();

					// Check for apostrophe-S, truncate
					// if so.
					if(o.endsWith('\'s'))
						o = o.substr(1, o.length() - 2);

					// Compare.
					return(o == cur);
				})
			}) != nil)
				return(nil);
		}

		// Looks okay, match.
		return(obj);
	}
;
