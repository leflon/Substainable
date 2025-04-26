import {addProvider, addSubscription, getSubscriptionById} from "$lib/db.js";
import {fail, json} from "@sveltejs/kit";

export const POST = async ({request, locals}) => {
	const data = await request.formData();
	const user = locals.user;
	if (!user)
		return json({error: 'Unauthorized'}, {status: 401});

	let providerId = data.get('provider-id');
	if (providerId === '_CUSTOM') {
		const providerName = data.get('provider-name');
		const emissions = data.get('emissions');
		providerId =	addProvider(providerName, emissions, user.id);
	}

	const date = new Date(data.get('base-date'));
	const subId = addSubscription(providerId, user.id, data.get('price'), date.getTime(), data.get('recurrence-unit'), data.get('recurrence'));
	const subscription = getSubscriptionById(subId)

	return json({subscription});
}