#if !defined(using_map_DATUM)

	#include "utopia_announcements.dm"
	#include "utopia_areas.dm"


	//CONTENT
	#include "utopia_gamemodes.dm"
	#include "utopia_presets.dm"
	#include "utopia_shuttles.dm"

	#include "utopia-1.dmm"
	#include "utopia-2.dmm"
	#include "utopia-3.dmm"
	#include "utopia-4.dmm"
	#include "utopia-5.dmm"
	#include "utopia-6.dmm"

	#include "job/jobs.dm"

	#define using_map_DATUM /datum/map/utopia

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Utopia
#endif
