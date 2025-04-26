<script>
	import {subscriptions} from "$lib/store.js";

	let {
		subscription,
		onEdit
	} = $props();


	const date =
		$derived(new Intl.DateTimeFormat('fr-FR').format(subscription.baseDate));

	const subphrase = $derived(
		`Every ${subscription.recurrence > 1 ? subscription.recurrence : ''}` +
		` ${subscription.recurrence_unit}${subscription.recurrence > 1 ? 's' : ''}` +
		` since ${date}`
	);

	const deleteSub = async () => {
		if (!confirm('Are you sure?')) return;
		const res = await fetch(`/api/subscriptions/delete/${subscription.id}`);
		const data = await res.json();
		if (data.success) {
			subscriptions.set($subscriptions.filter(sub => sub.id !== subscription.id))
		} else {
			alert(data.error);
		}
	}
</script>

<div
	class="flex gap-2 rounded-xl p-1 shadow-md"
	data-id={subscription.id}
>
	<div
		class="w-24 h-24 *:w-full *:h-full
		bg-green-400 overflow-hidden rounded-lg"
	>
		{#if subscription.logo_url}
			<img src={subscription.logo_url} alt={subscription.name}/>
		{:else}
			<div
				class="text-4xl font-bold flex justify-center items-center">
				{subscription.name[0].toUpperCase()}
			</div>
		{/if}
	</div>
	<div class="*:my-1">
		<div class="font-bold font-title text-2xl">{subscription.name}</div>
		<div class="text-gray-500 text-sm">
			{subphrase}
		</div>
		<div class="flex gap-2">
			<div>€{subscription.price}</div>
			<div>•</div>
			<div>{subscription.carbon_footprint}kgCO2e</div>
		</div>
		<div
			class="flex flex-row gap-2
				*:underline *:cursor-pointer *:hover:no-underline"
		>
			<!--svelte-ignore a11y_no_static_element_interactions -->
			<!--svelte-ignore a11y_click_events_have_key_events -->
			<div onclick={() => alert('Not yet implemented')}>Edit</div>
			<div class="no-underline!">•</div>
			<!--svelte-ignore a11y_no_static_element_interactions -->
			<!--svelte-ignore a11y_click_events_have_key_events -->
			<div class="text-red-500" onclick={deleteSub} type="button">Delete</div>
		</div>
	</div>
</div>