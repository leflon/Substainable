import {getUserSubscriptions} from "$lib/db.js";
import {redirect} from "@sveltejs/kit";

export const load = ({locals, url}) => {
	if (!locals.user) {
		return redirect(303, '/auth');
	}
	const subscriptions = getUserSubscriptions(locals.user.id);
	return {
		subscriptions
	};
}
