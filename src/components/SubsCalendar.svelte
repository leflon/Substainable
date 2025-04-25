<script>
	let {
		year,
		month,
		subscriptions = {}
	} = $props();

	const daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
	const daysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	const firstDay = $derived(new Date(year, month, 1));

	let offset = $derived((7 + firstDay.getDay() - 1) % 7);


	let days = $derived.by(() => {
		const arr = [];
		let day = new Date(firstDay);
		day.setDate(day.getDate() - offset);
		for (let i = 0; i < 42; i++) {
			arr.push(day.getDate());
			day.setDate(day.getDate() + 1);
		}
		return arr;
	});

</script>

<div class="container">
	{#each daysOfWeek as day}
		<div
			class="flex items-center justify-center font-title font-bold">{day}</div>
	{/each}
	{#each days as day,i}
		{@const isOtherMonth = i < offset || i >= daysPerMonth[month] + offset}
		{@const subs = isOtherMonth ? [] : (subscriptions[i - offset + 1] || [])}
		{@const price = subs.reduce((acc, i) => acc + i.price, 0)}
		<div
			class={"text-center bg-gray-100 rounded-sm px-1 py-[2px]"
			+ (isOtherMonth ? ' opacity-25' : '')}>
			<div class="flex flex-col items-center text-[7pt]
				sm:text-sm sm:flex-row sm:justify-center sm:gap-2">
				<div>{day}</div>
				{#if price > 0}
					<div class="text-xs font-bold sm:text-sm">
						€{price}
					</div>
				{/if}
			</div>
			<div class="grid grid-cols-2 grid-rows-2">
				{#each subs.slice(0, 3) as i}
					{#if i.logo}
						<img src={i.logo} class="object-fit-contain place-self-center"
						     alt={i.name}/>
					{:else}
						<div
							class="text-[7pt] font-bold text-center bg-green-300
							flex items-center justify-center sm:text-sm">
							{i.name[0].toUpperCase()}
						</div>
					{/if}
				{/each}
				{#if subs.length > 3}
					<div
						class="text-[7pt] place-self-center-safe overflow-hidden
									sm:text-sm"
					>
						+{subs.length - 3}
					</div>
				{/if}
			</div>
		</div>
	{/each}
</div>


<style>
	@import 'tailwindcss';

	.container {
		@apply grid gap-2 mx-auto max-w-150 px-2;
		grid-template-columns: repeat(7, 1fr);
		grid-template-rows: auto repeat(6, 60px);
	}
</style>