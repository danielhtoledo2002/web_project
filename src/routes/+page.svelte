<script>
    import { onMount } from 'svelte';
    import { db, connect } from '$lib/session.js';

    onMount(async () => {
        try {
            let success = await connect("", "");
            if (!success) {
                window.location.href = '/login';
            } else {
                const res = await db.info();
                window.location.href = '/listas';
            }
        } catch (err) {
            console.log(err);
            window.location.href = '/login';
        }
    });
</script>


