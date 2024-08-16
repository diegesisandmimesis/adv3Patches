#charset "us-ascii"
//
// adv3PatchesNounPhrase.t
//
//	Patch to NounPhraseWithVocab.
//
//	In stock adv3 >FOO, BAR throws an exception.  This fixes that.
//
//	There are two patches here.  The first prevents the antecedent
//	cause of the exception and the second adds an exception handler
//	to address it.
//
//	The first is PROBABLY sufficient, and the second is a backstop
//	in case something else causes the same/a similar problem (because
//	it's something parsing should be checking for, instead of
//	relying on callers to be well-behaved).
//
//
#include <adv3.h>
#include <en_us.h>

#include "adv3Patches.h"


// Code originally by @BrettW
//	https://intfiction.org/t/obscure-tads-3-conversation-bug/63888
modify TryAsActorResolveResults
	unknownNounPhrase(match, resolver) { return []; }
;

// Code originally by @RealNC, taken from
//	https://intfiction.org/t/nil-object-reference-parser-bug-tads3/9198
modify NounPhraseWithVocab
	resolveNounsMatchName(results, resolver, matchList) {
		try {
			return( inherited(results, resolver, matchList));
		}
		catch(RuntimeError e) {
			// Runtime error 2203 is "nil object reference."
			if(e.errno_ == 2203) {
				results.noVocabMatch(resolver.getAction(),
					getOrigText());
				return([]);
			}
			// It wasn't a nil object reference. Re-throw the
			// error so that it's not lost.
			throw e;
		}
	}
;
