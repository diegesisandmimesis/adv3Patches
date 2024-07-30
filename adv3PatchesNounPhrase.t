#charset "us-ascii"
//
// adv3PatchesNounPhrase.t
//
//	Patch to NounPhraseWithVocab.
//
//	In stock adv3 >FOO, BAR throws an exception.  This fixes that.
//
//
#include <adv3.h>
#include <en_us.h>

#include "adv3Patches.h"

modify NounPhraseWithVocab
	resolveNounsMatchName(results, resolver, matchList) {
		try {
			return inherited(results, resolver, matchList);
		}
		catch (RuntimeError e) {
			// Runtime error 2203 is "nil object reference."
			if (e.errno_ == 2203) {
				results.noVocabMatch(resolver.getAction(),
					getOrigText());
				return [];
			}
			// It wasn't a nil object reference. Re-throw the
			// error so that it's not lost.
			throw e;
		}
	}
;
