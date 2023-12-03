<script>
    import { onMount } from 'svelte';
    import NavBar from '../navBar.svelte';
    import { connect, session } from '$lib/session.js';
    import { get } from 'svelte/store';
    import List from '../list.svelte';

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


<div class="p-9 font-semibold tracking-tight ml-2">
    <h1>Bienvenido</h1>
</div>

<div class="p-9">
    <div class=" p-6  h-12 rounded-lg bg-slate-100 flex flex-row w-64 space-x-5 justify-items-center content-center justify-center items-center">
        <div>
            <i class="fa-solid fa-plus"></i>
        </div>
        <div>
            Create Task
        </div>
    
    </div>
</div>


<div class=" grid grid-cols-4  flew-wrape  justify-center gap-4 p-6">
    <List />

</div>
