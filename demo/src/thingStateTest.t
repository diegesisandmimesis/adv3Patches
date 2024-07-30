#charset "us-ascii"
//
// thingStateTest.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the adv3Patches library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f thingStateTest.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

versionInfo: GameID;
gameMain: GameMainDef initialPlayerChar = me;

class Pebble: Thing '(small) (round) blue Alice\'s pebble*pebbles' 'pebble'
	"A small, round pebble.
	It is blue and belongs to Alice. <.reveal alice> "
	isEquivalent = true
;

startRoom: Room 'Void' "This is a featureless void.";
+me: Person;
+Pebble
	allStates = static [ defaultState, aliceState ]
	getState = (gRevealed('alice') ? aliceState : defaultState)
;
defaultState: ThingState
	stateTokens = static []
;
// In stock adv3, >X ALICE'S PEBBLE will succeed, because the possessive
// adjective will be handled incorrectly.
// In this demo, with the patch, >X ALICE'S PEBBLE should fail before
// the pebble is examined (via >X PEBBLE), and then succeed afterward.
aliceState: ThingState
	stateTokens = static [ 'Alice\'s', 'blue' ]
;

