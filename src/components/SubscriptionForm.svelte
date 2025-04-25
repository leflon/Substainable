<script>
	import TextInput from "./TextInput.svelte";
	import ProviderSelector from "./ProviderSelector.svelte";
	import {onMount} from "svelte";

	let provider = $state('');
	let emissions = $state(null);
	let providers = $state([]);
	let recurrenceUnit = $state('month');

	onMount(async () => {
		let res = await fetch('/api/providers/getAll');
		res = await res.json();
		providers = [...res.providers, {
			id: '_CUSTOM', name: 'Custom', logo_url:
				'/icons/add.png'
		}];
	});

	$effect(() => {
		emissions = providers.find(p => p.id === provider)?.carbon_footprint;
	});

	function handleSubmit(event) {
		if (provider === '') {
			event.preventDefault();
			alert('Please select a provider');
		}
	}
</script>

<div
	class="fixed w-full h-full top-0 left-0 flex justify-center items-center
		backdrop-blur-xl bg-black/40">
	<form
		action="/api/subscriptions/add"
		method="POST"
		class="overflow-hidden px-3 w-full h-full box-border bg-white
		lg:w-230 lg:h-128 lg:rounded-lg lg:shadow-lg"
		onsubmit={handleSubmit}
	>
		<h1 class="my-4 font-bold text-3xl text-center">Add subscription</h1>
		<h2>Details</h2>
		<div class="input-group">
			<div class="input-container">
				<div class="input-label">Provider</div>
				<div class="my-2">
					<ProviderSelector bind:value={provider} providers={providers} />
				</div>
			</div>
			{#if provider === '_CUSTOM'}
				<div class="input-container">
					<div class="input-label"> Provider name</div>
					<TextInput type="text"
					           name="provider-name"
					           placeholder="A great company"
					           required={true}
					/>
				</div>
			{/if}
			<div class="input-container">
				<div class="input-label">CO2 emissions</div>
				<TextInput type="number"
				           name="emissions"
				           placeholder="(kg CO₂e)"
				           value={emissions}
				           required={true}/>
			</div>
			<div class="input-container">
				<div class="input-label">Price</div>
				<TextInput type="number" name="price" placeholder="(€)" required={true}/>
			</div>
		</div>
		<h2>Timing</h2>
		<div class="input-group">
			<div class="input-container">
				<div class="input-label">First payment</div>
				<input
					name="base-date" type="date"
					value={new Date().toISOString().substring(0, 10)}
					required
				/>
			</div>
			<div class="input-container">
				<div class="input-label">Frequency Period</div>
				<select
					bind:value={recurrenceUnit}
					name="recurrence-unit"
					required
				>
					<option value="week">Week</option>
					<option value="month" selected>Month</option>
					<option value="year">Year</option>
				</select>
			</div>
			<div class="input-container">
				<div class="input-label">Interval</div>
				<TextInput
					placeholder={`Every # ${recurrenceUnit}s`}
					name="recurrence"
					required={true}
				/>
			</div>
		</div>
		<button type="submit" class="mx-auto my-2">Submit</button>
	</form>
</div>

<style>
	@import 'tailwindcss';

	h2 {
		@apply font-semibold text-xl text-center my-4;
	}

	.input-container {
		@apply flex flex-col gap-1;

		& > input, & > select {
			@apply my-2 border-2 border-black rounded-sm h-8;
		}
	}

	.input-group {
		@apply flex flex-row gap-4 flex-wrap justify-center;
	}

	.input-label {
		@apply font-bold;
	}
</style>
