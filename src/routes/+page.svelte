<script>
	import SubsCalendar from "../components/SubsCalendar.svelte";
	import SubscriptionForm from "../components/SubscriptionForm.svelte";

	let {data} = $props();
	let isAdding = $state(false);

	let currentMonth = $state(new Date().getMonth())
	let currentYear = $state(new Date().getFullYear());
	let monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	const daysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	let currentMonthSubscriptions = $derived.by(() => {
		const dict = {};
		for (const s of data.subscriptions) {
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
					currentMonth[0] === base.getMonth()
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

<h1 class="text-center">Sub'stainable</h1>
<h2 class="text-center">{monthNames[currentMonth]} {currentYear}</h2>
<div class="grid grid-rows-2 my-6 mx-auto sm:grid-cols-2 sm:grid-rows-1 sm:w-150 ">
	<div class="text-center">
		<h3>Your expenses this month</h3>
		<div class="font-extrabold font-tile text-4xl">€{totalExpenses}</div>
	</div>
	<div class="text-center">
		<h3>Your emissions this month</h3>
		<div class="font-extrabold font-title text-4xl">{totalEmissions}kgCO2e</div>
	</div>
</div>
<div class="flex gap-2 justify-center my-6">
<button onclick={decrementMonth}> Prev</button>
<button onclick={incrementMonth}> Next</button>
<button onclick={() => isAdding = !isAdding}>Add subscription</button>
</div>

<SubsCalendar year={currentYear} month={currentMonth}
              subscriptions={currentMonthSubscriptions}/>

{#if isAdding}
	<SubscriptionForm/>
{/if}