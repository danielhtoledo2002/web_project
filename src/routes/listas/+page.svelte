<script>
    import { onMount } from 'svelte';
    import { db } from '$lib/session.js';
    import NavBar from '../navBar.svelte';
    import { connect } from '$lib/session.js';

    onMount(async () => {
        try {
            let success = await connect("", "");
            if (!success) {
                window.location.href = '/login';
            }
        } catch (err) {
            console.log(err);
            window.location.href = '/login';
        }
    });
</script>

<div class=" flex flex-row grow">
    <NavBar/>
</div>

