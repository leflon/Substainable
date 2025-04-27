import {getEcoProjects} from "$lib/db.js";
import {json} from "@sveltejs/kit";

export const GET = () => {
	const projects = getEcoProjects();

	return json({projects});
}