<script>
	import AuthForm from "../../components/AuthForm.svelte";

	let {data} = $props()

</script>

<AuthForm loginError={data.loginError} registerError={data.registerError}/>