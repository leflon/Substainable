<script>
	import {providers} from "$lib/store.js";

	let {value = $bindable('')} = $props();
	let isOpen = $state(false);
</script>


<!-- svelte-ignore a11y_click_events_have_key_events -->
<!-- svelte-ignore a11y_no_static_element_interactions -->
<div
	class="cursor-pointer relative px-1 box-border h-8 border-2 border-black rounded-sm"
	data-open={isOpen}
	onclick={() =>
 isOpen = !isOpen}>
	<input type="hidden" name="provider-id" bind:value={value}/>
	<div class="h-7 flex flex-row items-center gap-1">
		{#if value}
			{@const provider = $providers.find(p => p.id === value)}
			<div class="provider-item">
				<img src={provider.logo_url}
				     width="24" height="24"
				     class="object-contain"
				     alt={provider.name}>
				<span>{provider.name}</span>
			</div>
		{:else}
			<div class="provider-item">Choose a provider...</div>
		{/if}
		<img class={isOpen ? 'rotate-180' : ''}
		     src="/icons/drop_down.png"
		     width="24"
		     alt="v">
	</div>

	<div
		class="list h-32 overflow-y-scroll absolute z-50 bg-white w-full
		left-0 translate-y-1 border-2 border-black overflow-hidden px-2 rounded-sm">
		{#each $providers as provider (provider.id)}
			{#if provider.id !== value}
				<div class="provider-item"
				        onclick={() => value = provider.id}
				>
					<img src={provider.logo_url}
					     width="24" height="24"
					     class="object-contain"
					     alt={provider.name}/>
					<span>{provider.name}</span>
				</div>
			{/if}
		{/each}
	</div>
</div>

<style>
	@import 'tailwindcss';


	[data-open="false"] .list {
		@apply hidden;
	}

	.provider-item {
		@apply flex flex-row items-center gap-1 w-40 h-7;

		& span {
			@apply truncate;
		}
	}
</style>