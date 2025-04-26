<script>
	import SubsCalendar from "../components/SubsCalendar.svelte";
	import SubscriptionList from "../components/SubscriptionList.svelte";
	import {providers, subscriptions} from "$lib/store.js";

	let {data} = $props();
	providers.set([{id: '_CUSTOM', name: 'Custom', logo_url: '/icons/add.png'}, ...data.providers]);
	subscriptions.set(data.subscriptions);

	let showSubManager = $state(false); // Only applies on smaller viewports.

	let currentMonth = $state(new Date().getMonth())
	let currentYear = $state(new Date().getFullYear());
	let monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	const daysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	let currentMonthSubscriptions = $derived.by(() => {
		const dict = {};
		for (const s of $subscriptions) {
			const base = new Date(s.baseDate);
			if (base.getFullYear() > currentYear ||
				(base.getFullYear() === currentYear && base.getMonth() > currentMonth)
			) continue;

			const r = s.recurrence;
			// If the date of the subscription is not present in all months,
			// We just affect it to the latest date of the month
			const date = Math.min(base.getDate(), daysPerMonth[currentMonth]);

			if (s.recurrence_unit === 'year') {
				const baseYear = base.getFullYear();
				if (
					(currentYear - baseYear) % r === 0 &&
					currentMonth === base.getMonth()
				) {
					dict[date] = [...(dict[date] || []), s];
				}
			} else if (s.recurrence_unit === 'month') {
				const baseMonth = base.getMonth();
				if ((baseMonth - currentMonth) % r === 0) {
					dict[date] = [...(dict[date] || []), s];
				}
			}
		}
		return dict;
	});

	let totalExpenses = $derived(
		Object.values(currentMonthSubscriptions)
			.reduce((acc, val) =>
					acc + val.reduce((acc2, val2) => acc2 + val2.price, 0),
				0
			)
	);

	let totalEmissions =
		$derived(
			Object.values(currentMonthSubscriptions)
				.reduce((acc, val) =>
						acc + val.reduce((acc2, val2) => acc2 + val2.carbon_footprint, 0),
					0
				)
		);

	const incrementMonth = () => {
		if (currentMonth === 11) {
			currentMonth = 0;
			currentYear++;
		} else currentMonth++;
	}
	const decrementMonth = () => {
		if (currentMonth === 0) {
			currentMonth = 11;
			currentYear--;
		} else currentMonth--;
	}
</script>
<div class="flex h-dvh">
	<div
		class="relative w-2/5 max-w-128 h-full *:h-full"
		data-hidden={!showSubManager}
	>
		<SubscriptionList onClose={() => showSubManager = false}></SubscriptionList>
	</div>
	<div class="flex flex-col items-center flex-1">
		<h1 class="text-green-500 font-extrabold text-4xl lg:text-6xl text-center mt-6">Sub'stainable</h1>
		<a href="/api/logout" class="text-xs mb-3 hove:underline">Log out</a>
		<div class="month flex gap-2 items-center">
			<button onclick={decrementMonth}>
				<img src="/icons/drop_down.png" alt="<" class="rotate-90"/>
			</button>
			<div class="font-tile font-bold text-3xl text-center">{monthNames[currentMonth]} {currentYear}</div>
			<button onclick={incrementMonth}>
				<img src="/icons/drop_down.png" alt=">" class="rotate-270"/>
			</button>
		</div>
		<div class="grid mt-6 mx-auto gap-6 grid-cols-2 grid-rows-1 max-w-150 ">
			<div class="text-center">
				<h3 class="text-xs sm:text-lg">Your expenses this month</h3>
				<div class="font-extrabold font-tile text-2xl sm:text-4xl">€{totalExpenses}</div>
			</div>
			<div class="text-center">
				<h3 class="text-xs sm:text-lg">Your emissions this month</h3>
				<div class="font-extrabold font-title text-2xl sm:text-4xl">{totalEmissions}kgCO2e</div>
			</div>
		</div>
		<div class="flex gap-2 justify-center my-6">
			<button
				class="lg:hidden!"
				onclick={() => showSubManager = true}>
				Manage subscriptions
			</button>
		</div>

		<SubsCalendar year={currentYear} month={currentMonth}
		              subscriptions={currentMonthSubscriptions}
		/>
	</div>
</div>

<style>
	@import 'tailwindcss';

	[data-hidden='true'] {
		@apply max-lg:hidden;
	}

	.month button {
		@apply bg-transparent size-8 border-2 border-black rounded-full p-0;
	}
</style>