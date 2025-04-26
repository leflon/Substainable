import {addProvider, addSubscription, getSubscriptionById} from "$lib/db.js";
import {json} from "@sveltejs/kit";

/* This should be a POST request but our production server, for some reason,
has issues dealing with these. As a hot fix, we're converting them to GET */
export const GET = async ({request, locals, url}) => {
	//const data = await request.formData();
	const data = url.searchParams;
	const user = locals.user;
	if (!user)
		return json({error: 'Unauthorized'}, {status: 401});

	let providerId = data.get('provider-id');
	if (providerId === '_CUSTOM') {
		const providerName = data.get('provider-name');
		const emissions = data.get('emissions');
		providerId = addProvider(providerName, emissions, user.id);
	}

	const date = new Date(data.get('base-date'));
	const subId = addSubscription(providerId, user.id, data.get('price'), date.getTime(), data.get('recurrence-unit'), data.get('recurrence'));
	const subscription = getSubscriptionById(subId)

	return json({subscription});
}