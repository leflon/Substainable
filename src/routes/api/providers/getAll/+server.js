import {getProviders} from "$lib/db.js";
import {json} from "@sveltejs/kit";

export const GET = () => {
	return json({
		providers: getProviders()
	});
};