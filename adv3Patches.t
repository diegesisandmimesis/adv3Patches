#charset "us-ascii"
//
// adv3Patches.t
//
//	Some patches for adv3.
//
//	The intent is to only include patches for bugs and errors, rather
//	than things that extend functionality.  There's a bit of an asthetic
//	judgement in drawing the line.  For example, one of the patches
//	adds a grammar rule for parsing adjective phrases with conjunctions,
//	to handle >X SMALL, ROUND PEBBLE correctly, for example.  Stock adv3
//	doesn't crash or throw an exception in this case, but the default
//	behavior ("You see no small here.") is presumably _never_ the
//	desired response, so it's been counted as a "pure" patch, rather
//	than a feature add.
//
//
#include <adv3.h>
#include <en_us.h>

#include "adv3Patches.h"

// Module ID for the library
adv3PatchesModuleID: ModuleID {
        name = 'Adv3 Patches Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}
