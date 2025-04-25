import {json} from "@sveltejs/kit";
import {deleteSubscription, getSubscriptionById} from "$lib/db.js";

export const GET = async ({locals, params}) => {
	const {id} = params;
	if (!id)
		return json({error: 'Missing id'}, {status: 400});
	if (!locals.user)
		return json({error: 'Unauthorized'}, {status: 401});

	const sub = getSubscriptionById(id);

	if (!sub)
		return json({error: 'Subscription not found'}, {status: 404});

	if (sub.user_id !== locals.user.id)
		return json({error: 'Unauthorized'}, {status: 401});

	deleteSubscription(id);

	return json({success: true});
}