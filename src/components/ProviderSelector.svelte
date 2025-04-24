<script>

	let {value = $bindable('')} = $props();
	let isOpen = $state(false);


	//TODO: Fetch providers from API
	const providers = [
		{
			id: 'id1',
			name: 'Netflix Premium Ultra HD VVidfwefewfweoe',
			logo: 'https://images.ctfassets.net/4cd45et68cgf/Rx83JoRDMkYNlMC9MKzcB/2b14d5a59fc3937afd3f03191e19502d/Netflix-Symbol.png'
		},
		{
			id: 'id2',
			name: 'Prime Video',
			logo: 'https://get-picto.com/wp-content/uploads/2023/08/logo-amazon-prime-video.webp'
		},
		{
			id: 'id3',
			name: 'Tinder Gold',
			logo: 'https://cdn-images.dzcdn.net/images/cover/26b86405974831a98014e2815cc2149a/0x1900-000000-80-0-0.jpg'
		},
		{
			id: 'id4',
			name: 'YouTube Premium',
			logo: 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png'
		},
		{
			id: 'id5',
			name: 'OVH',
			logo: 'https://s3-symbol-logo.tradingview.com/ovh-groupe--600.png'
		},
		{
			id: '_CUSTOM',
			name: 'Custom...',
			logo: 'icons/add.png'
		}
	];


</script>


<!-- svelte-ignore a11y_click_events_have_key_events -->
<!-- svelte-ignore a11y_no_static_element_interactions -->
<div
	class="relative px-1 box-border h-8 border-2 border-black rounded-sm"
	data-open={isOpen}
	onclick={() =>
 isOpen = !isOpen}>
	<input type="hidden" name="provider-id" bind:value={value}/>
	<div class="h-7 flex flex-row items-center gap-1">
		{#if value}
			{@const provider = providers.find(p => p.id === value)}
			<div class="provider-item">
				<img src={provider.logo}
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
		class="list absolute z-50 bg-white w-full left-0 translate-y-1
			border-2 border-black overflow-hidden px-2 rounded-sm">
		{#each providers as provider (provider.id)}
			{#if provider.id !== value}
				<div class="provider-item"
				        onclick={() => value = provider.id}
				>
					<img src={provider.logo}
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