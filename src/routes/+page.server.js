import {getProviders, getUserSubscriptions} from "$lib/db.js";
import {redirect} from "@sveltejs/kit";

export const load = ({locals}) => {
	if (!locals.user) {
		return redirect(303, '/auth');
	}
	const providers = getProviders();
	const subscriptions = getUserSubscriptions(locals.user.id);
	return {
		subscriptions,
		providers
	};
}
