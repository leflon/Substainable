<script>
	import SubscriptionListItem from "./SubscriptionListItem.svelte";
	import {subscriptions} from "$lib/store.js";
	import SubscriptionForm from "./SubscriptionForm.svelte";

	let {onClose} = $props();

	let isEditing = $state(false);


</script>
<div class="z-30 fixed w-full h-full top-0 left-0
					  flex items-center justify-center bg-black/40 backdrop-blur-xl
					  lg:bg-transparent lg:backdrop-blur-none lg:relative lg:w-auto lg:h-full
">
	<div class="box-border relative w-full h-full bg-white flex flex-col py-2
						  sm:max-lg:w-3/4 sm:max-lg:h-3/4 sm:max-lg:rounded-lg lg:border-r-2 lg:border-r-gray-200">
		<!--svelte-ignore a11y_no_static_element_interactions -->
		<!--svelte-ignore a11y_click_events_have_key_events -->
		<div
			class="absolute top-1 right-1 cursor-pointer lg:hidden"
			onclick={onClose}>
			<img src="/icons/add.png" class="rotate-45" alt="+" />
		</div>
		<h1 class="my-4 text-center font-bold text-2xl">My subscriptions</h1>

		<button class="mx-auto my-2" onclick={() => isEditing = true}>Add subscription</button>

		<div class="relative flex flex-col gap-2 overflow-y-scroll flex-1 px-4">
			{#each $subscriptions as sub (sub.id)}
				<SubscriptionListItem subscription={sub}/>
			{/each}
		</div>
	</div>
</div>

{#if isEditing}
	<SubscriptionForm onClose={() => isEditing = false} />
{/if}
