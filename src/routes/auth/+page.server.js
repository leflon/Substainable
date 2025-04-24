export const load = ({url}) => {
	const loginError = url.searchParams.get('login_error');
	const registerError = url.searchParams.get('register_error');
	return {
			loginError,
			registerError
	};
}