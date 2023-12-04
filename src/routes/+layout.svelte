<script>
    import "../app.css";

    import { browser } from '$app/environment'
    import { goto } from '$app/navigation'
    import { page } from '$app/stores'
    import { connect } from '$lib/session.js';


    $: if (browser && !connect("","") && $page.url.pathname !== '/login' && $page.url.pathname !== '/signup') {
        console.log(
            'we are running in the browser, not signed in, and not on the sign in page, we are going to the sign in page'
        )
        goto('/login')
    } else if (browser && connect("","") && $page.url.pathname === '/login' && $page.url.pathname === '/signup') {
        console.log(
            'we are running in the browser, signed in, and on the sign in page, we are going to the home page'
        )
        goto('/listas')
    }
</script>

<slot />