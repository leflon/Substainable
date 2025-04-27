<script>

	import {onMount} from "svelte";

	let {onClose} = $props();

	let isLoading = $state(true);
	let projects = $state([]);

	onMount(async () => {
		let res = await fetch('/api/ecoprojects');
		res = await res.json();
		projects = res.projects;
		isLoading = false;
	});

</script>

<div class="z-50 fixed top-0 w-full h-full bg-black/40 backdrop-blur-2xl flex items-center justify-center">
	<div class="flex flex-col relative box-border w-full h-full py-4 bg-white text-center
		sm:w-2/3 sm:h-2/3 sm:rounded sm:max-w-200">
		<div class="absolute top-2 right-2 cursor-pointer" onclick={onClose}>
			<img src='/icons/add.png' class="rotate-45" alt="X" />
		</div>
		<h1 class="text-xl sm:text-3xl">Ecological initiatives</h1>
		<p class="text-sm py-2 sm:text-lg sm:px-4">
			Here are a few initiatives you can support to compensate your carbon footprint, and make the world a little
			better.
		</p>
		{#if isLoading}
			<div class="mx-auto w-8 h-8 rounded-full border-2 border-black border-t-transparent animate-spin"></div>
		{:else}
			<div class="px-2 items-center overflow-scroll flex-1">
				{#each projects as project}
					<a
						class="box-border mx-auto my-2 relative flex flex-col
						max-w-100 w-full h-32 justify-center rounded-lg overflow-hidden"
						href={project.link}
						target="_blank"
					>
						<img
							src={project.image_url}
							alt={project.name}
							class="z-0 absolute top-0 h-0 block w-full h-full bg-gray-100 object-cover"
						/>
						<div class="absolute w-full h-full bg-black/30 backdrop-blur-xs rounded-lg"></div>
						<div class="z-1 p-2 text-white">
							<h2 class="text-lg font-bold">{project.name}</h2>
							<p class="text-xs">{project.description}<br/> Click to learn more!</p>
						</div>
					</a>
				{/each}
			</div>
		{/if}
	</div>
</div>
