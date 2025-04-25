import {fail, json} from "@sveltejs/kit";
import {getUserSubscriptions} from "$lib/db.js";

export const GET = ({locals}) => {
	if (!locals.user)
		return json({error: 'Unauthorized'}, {status: 401});

	const subs = getUserSubscriptions(locals.user.id);
	return json({subscriptions: subs});
}