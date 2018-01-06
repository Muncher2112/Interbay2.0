#if !defined(USING_MAP_DATUM)

	#include "../shared/exodus_torch/_include.dm"

	#include "titan_announcements.dm"
	#include "titan_areas.dm"


	//CONTENT
	#include "../shared/job/jobs.dm"
	#include "../shared/datums/uniforms.dm"
	#include "../shared/items/cards_ids.dm"
	#include "../shared/items/clothing.dm"
	#include "titan_gamemodes.dm"
	#include "titan_presets.dm"
	#include "titan_shuttles.dm"

	#include "titan-1.dmm"
	#include "titan-2.dmm"
	#include "titan-3.dmm"
	#include "titan-4.dmm"
	#include "titan-5.dmm"
	#include "titan-6.dmm"
	#include "titan-7.dmm"

	#include "../shared/exodus_torch/_include.dm"

	#include "../../code/modules/lobby_music/generic_songs.dm"

	#define USING_MAP_DATUM /datum/map/titan

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Titan
#endif
