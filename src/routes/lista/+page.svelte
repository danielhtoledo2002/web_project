<script>
    import { onMount } from 'svelte';
    import { db, connect } from '$lib/session.js';
    import { goto } from '$app/navigation';

    onMount(async () => {
        try {
            let success = await connect("", "");
            if (!success) {
                goto('/login');
            } else {
                const res = await db.info();
                goto('/listas');
            }
        } catch (err) {
            console.log(err);
            goto('/login');
        }
    });
</script>


