<script>
    import { onMount } from 'svelte';
    import NavBar from '../navBar.svelte';
    import Newtask from '../newtask.svelte';
    import { connect, session } from '$lib/session.js';
    import { get } from 'svelte/store';

    let nombre = "";
    let apellido = "";

    onMount(async () => {
        try {
            let success = await connect("", "");
            if (!success) {
                window.location.href = '/login';
            }

            let session_info = get(session);
            nombre = session_info.first_name;
            apellido = session_info.last_name;
        } catch (err) {
            console.log(err);
            window.location.href = '/login';
        }
    });
</script>

<div class=" flex flex-row grow">
    <NavBar nombre={nombre} apellido={apellido}/>
</div>

<div class=" flex flex-row grow">
    <Newtask/>
</div>
