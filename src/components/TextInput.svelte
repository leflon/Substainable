<script>
	let {
		type = 'text',
		name = '',
		placeholder = '',
		step,
		min,
		invalid = false,
		class: className,
		required = false,
		value = $bindable('')
	} = $props();
</script>

<div class={"relative my-2 h-8 w-[max-content] " + className}>
	<input
		type={type}
		name={name}
		placeholder=" "
		required={required}
		step={step}
		min={min}
		class="h-full w-full px-2 py-2 border-2 border-gray-200 rounded-sm
		outline-none transition-all duration-300 focus:border-blue-400"
		data-invalid={invalid}
		bind:value={value}
	/>
	<div
		class="placeholder absolute left-2 top-1/2 translate-y-[-50%] pointer-events-none
		transition-all duration-300 ease text-gray-400">
		{placeholder}
	</div>
</div>

<style>
	@import 'tailwindcss';

	input:focus ~ .placeholder,
	input:not(:placeholder-shown) ~ .placeholder {
		@apply text-xs top-0 bg-white px-1;
	}

	input:focus ~ .placeholder {
		@apply text-blue-400;
	}


	[data-invalid="true"] {
		@apply border-red-400;

		& ~ .placeholder {
			@apply text-red-400!;
		}
	}
</style>