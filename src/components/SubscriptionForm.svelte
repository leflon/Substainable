<script>
	import TextInput from "./TextInput.svelte";
	import ProviderSelector from "./ProviderSelector.svelte";
	import {providers, subscriptions} from "$lib/store.js";

	let {onClose} = $props();

	let provider = $state('');
	let emissions = $state(null);
	let recurrenceUnit = $state('month');

	let form = $state();

	$effect(() => {
		emissions = $providers.find(p => p.id === provider)?.carbon_footprint;
	});

	async function handleSubmit(event) {
		event.preventDefault();
		if (provider === '') {
			alert('Please select a provider');
			return;
		}

		event.preventDefault();

		const formData = new FormData(event.target);
		let res = await fetch('/api/subscriptions/add?'
			+ new URLSearchParams(formData).toString());
		res = await res.json();
		subscriptions.update(subs => [...subs, res.subscription]);
		onClose();
	}
</script>

<div
	class="z-100 fixed w-full h-full top-0 left-0 flex justify-center items-center
		backdrop-blur-xl bg-black/40">
	<form
		class="relative overflow-hidden px-3 w-full h-full box-border bg-white
		lg:w-230 lg:h-128 lg:rounded-lg lg:shadow-lg"
		onsubmit={handleSubmit}
	>
		<!--svelte-ignore a11y_no_static_element_interactions -->
		<!--svelte-ignore a11y_click_events_have_key_events -->
		<div
			class="absolute top-1 right-1 cursor-pointer"
			onclick={onClose}>
			<img src="/icons/add.png" class="rotate-45" alt="+"/>
		</div>
		<h1 class="my-4 font-bold text-3xl text-center">Add subscription</h1>
		<h2>Details</h2>
		<div class="input-group">
			<div class="input-container">
				<div class="input-label">Provider</div>
				<div class="my-2">
					<ProviderSelector bind:value={provider} providers={providers}/>
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
				           step="0.01"
				           min={0}
				           placeholder="(kg CO₂e)"
				           value={emissions}
				           required={true}/>
			</div>
			<div class="input-container">
				<div class="input-label">Price</div>
				<TextInput
					type="number"
					step="0.01"
					name="price"
					min={0}
					placeholder="(€)"
					required={true}
				/>
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
					<option value="month" selected>Month</option>
					<option value="year">Year</option>
				</select>
			</div>
			<div class="input-container">
				<div class="input-label">Interval</div>
				<TextInput
					type="number"
					placeholder={`Every # ${recurrenceUnit}s`}
					name="recurrence"
					min={1}
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
