<script>
	let {
		year,
		month
	} = $props();

	const daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
	const daysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	const firstDay = new Date(year, month, 1);

	let offset = (7 + firstDay.getDay() - 1) % 7;

	let day = new Date(firstDay);
	day.setDate(day.getDate() - offset);

	let days = [];
	for (let i = 0; i < 42; i++) {
		days.push(day.getDate());
		day.setDate(day.getDate() + 1);
	}

	//TODO: get subscriptions from props
	const exampleSubscriptions = [
		{
			name: 'Netflix Premium Ultra HD VVidfwefewfweoe',
			logo:
				'https://images.ctfassets.net/4cd45et68cgf/Rx83JoRDMkYNlMC9MKzcB/2b14d5a59fc3937afd3f03191e19502d/Netflix-Symbol.png',
			price: 10
		},
		{
			name: 'Custom...',
			logo: null,
			price: 10
		},
		{
			name: 'Prime Video',
			logo:
				'https://get-picto.com/wp-content/uploads/2023/08/logo-amazon-prime-video.webp',
			price: 10
		},
		{
			name: 'Tinder Gold',
			logo:
				'https://cdn-images.dzcdn.net/images/cover/26b86405974831a98014e2815cc2149a/0x1900-000000-80-0-0.jpg',
			price: 10
		},
		{
			name: 'YouTube Premium',
			logo:
				'https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png',
			price: 10
		},
		{
			name: 'OVH',
			logo: 'https://s3-symbol-logo.tradingview.com/ovh-groupe--600.png',
			price: 10
		},
	];

</script>

<div class="container">
	{#each daysOfWeek as day}
		<div
			class="flex items-center justify-center font-title font-bold">{day}</div>
	{/each}
	{#each days as day,i}
		<!-- TODO: Get actual subscriptions -->
		{@const subs = exampleSubscriptions.slice(0, Math.floor(Math.random() *
			exampleSubscriptions.length))}
		{@const price = subs.reduce((acc, i) => acc + i.price, 0)}
		{@const isOtherMonth = i < offset || i >= daysPerMonth[month] + offset}
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
		grid-template-rows: 60px repeat(6, 1fr);
	}
</style>