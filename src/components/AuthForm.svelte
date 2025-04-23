<script>
	let selectedTab = $state('register');

	let emailValue = $state('');
	let passwordValue = $state('');
	let confirmPasswordValue = $state('');

	const passwordRequirements = [
		{
			description: 'Password contains at least 8 characters',
			regex: /.{8,}/
		},
		{
			description: 'Password contains at least one lowercased letter',
			regex: /[a-z]/
		},
		{
			description: 'Password contains at least one uppercased letter',
			regex: /[A-Z]/
		},
		{
			description: 'Password contains at least one digit',
			regex: /\d/
		},
		{
			description: 'Password contains at least one special character',
			regex: /[!@#$%&*()_\- +<>?|{}"';:\[\]\/\\.,]/
		}
	];

	let emailValid = $derived(/\w+@\w+/gi.test(emailValue));
	let passwordValid = $derived(
		passwordRequirements.every(r => r.regex.test(passwordValue))
	);
	let passwordsMatch = $derived(passwordValue === confirmPasswordValue);


</script>

<div
	class="relative fixed w-full h-full overflow-hidden
		md:w-128 md:h-128 md:border-2 md:border-gray-200 md:rounded-lg md:shadow-md
		shadow-gray-200 md:top-1/2 md:left-1/2 md:transform-[translate(-50%,-50%)]"
     data-selected={selectedTab}
>
	<div class="relative flex h-16 border-b-2 border-b-gray-100">
		<button class="form-tab" onclick={() => selectedTab = 'login'}>Login</button>
		<button class="form-tab" onclick={() => selectedTab = 'register'}>Register</button>
		<div
			class="indicator absolute w-1/2 h-1 bg-blue-400 left-0 bottom-0 duration-200 transition-all"
			data-selected={selectedTab}>
		</div>
	</div>
	<form action="/api/auth/login" method="GET" data-tab='login'>
		<h1>Welcome back!</h1>
		<div class="input-container">
			<input name='email' type="text" placeholder=" "  />
			<div class="input-placeholder">E-mail</div>
		</div>
		<div class="input-container">
			<input name='password' type="password" placeholder=" "/>
			<div class="input-placeholder">Password</div>
		</div>
		<div class="form-footer">
			<a
				href="#"
				class="text-xs hover:underline">
				I forgot my password
			</a>
			<button type="submit">Login</button>
		</div>
	</form>
	<form action="/api/auth/register" method="POST" data-tab="register">
		<h1>Welcome to the family!</h1>
		<div class="input-container">
			<input type="text" name="email" placeholder=" " bind:value={emailValue} data-valid={emailValid}/>
			<div class="input-placeholder">E-mail</div>
		</div>
		<div class="input-container">
			<input type="password" name="password" placeholder=" "
			       bind:value={passwordValue} data-valid={passwordValid}/>
			<div class="input-placeholder">Password</div>
		</div>
		<div class="input-container">
			<input type="password" name="" placeholder=" "
			       bind:value={confirmPasswordValue} data-valid={passwordsMatch} />
			<div class="input-placeholder">Confirm Password</div>
		</div>
		<div class="my-4">
			{#each passwordRequirements as r}
				<div class="text-sm text-red-500 transition-all duration-200"
				     data-valid={r.regex.test(passwordValue)}
				>
					{r.description}
				</div>
			{/each}
		</div>
		<div class="form-footer">
			<button type="submit"
			        disabled={!emailValid || !passwordsMatch || !passwordValid}>Register
			</button>
		</div>
	</form>
</div>

<style>
	@import 'tailwindcss';

	.form-tab {
		@apply h-full w-1/2 flex items-center justify-center text-xl;
	}

	.indicator[data-selected='register'] {
		@apply left-1/2;
	}

	form {
		@apply absolute w-full px-4 transition duration-200;
	}

	[data-selected='login'] {
		& form[data-tab='login'] {
			@apply translate-x-0;
		}

		& form[data-tab='register'] {
			@apply translate-x-full;
		}
	}

	[data-selected='register'] {
		& form[data-tab='login'] {
			@apply translate-x-[-100%];
		}

		& form[data-tab='register'] {
			@apply translate-x-0;
		}
	}

	h1 {
		@apply font-bold text-2xl text-center my-4;
	}

	.input-container {
		@apply relative w-full mx-auto my-4;
	}

	.input-placeholder {
		@apply absolute left-2 top-1/2 translate-y-[-50%] pointer-events-none
		transition-all
		duration-200;
	}

	input {
		@apply h-full w-full px-2 py-2 border-2 border-gray-200 rounded-sm
		outline-none
		transition-all duration-300;
	}

	input:focus {
		@apply border-green-300;
	}

	input:focus ~ .input-placeholder,
	input:not(:placeholder-shown) ~ .input-placeholder {
		@apply text-xs top-0 bg-white px-1;
	}

	.form-footer {
		@apply flex items-center justify-end gap-2;
	}

	.form-footer button {
		@apply flex items-center justify-center px-4 py-1 rounded-sm bg-blue-400
		text-white text-lg transition-all duration-200;
	}

	button[disabled] {
		@apply cursor-not-allowed bg-gray-300;
	}

	input[data-valid='false'],
	input[data-valid='valid']:focus {
		@apply border-red-500;
	}

	div[data-valid='true'] {
		@apply text-green-500;
	}


</style>
