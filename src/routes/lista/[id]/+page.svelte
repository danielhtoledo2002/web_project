<script>
    import { onMount } from 'svelte';
    import { db, connect, session } from '$lib/session.js';
    import { goto } from '$app/navigation';
    import { page } from '$app/stores'
    import { get } from 'svelte/store';
    import NavBar from '../../navBar.svelte';
    import Task from './task.svelte';

    let id = $page.url.pathname.split('/')[2];
    let nombre = "";
    let descripcion = "";
    let tareas = []

    let nombre_u = "";
    let segundo = "";

    let creating = false;

    function createTask() {
        creating = !creating;
    }

    onMount(async () => {
        try {
            let success = await connect("", "");
            if (!success) {
                goto('/login');
            }
        } catch (err) {
            console.log(err);
            goto('/login');
        }

        try {
            let res = await db.select(id);
            let lista = res[0];
            nombre = lista.name;
            descripcion = lista.description;

            let session_info = get(session);
            nombre_u = session_info.first_name;
            segundo = session_info.last_name;

            let tareas_lista = await db.query('SELECT *, time::format(due_date - 6h, "%v %r") AS due_date_format, (due_date - time::now()) AS remain FROM $task_list->has_task->task ORDER BY completed, due_date DESC', {
                task_list: id
            });

            let lista_tareas = tareas_lista[0];
            tareas = lista_tareas;

            document.onkeyup = function(e) {
                // Set creating to false if the user presses the escape key
                if (e.key === "Escape") {
                    creating = false;
                }
            }
        } catch (err) {
            console.log(err);
            goto('/listas');
        }
    });
</script>

<div>
    <NavBar nombre={nombre_u} apellido={segundo}/>

    <div class="relative">
        <div class={ creating ? 'blur-sm' : '' }>
            <div class="flex flex-col justify-start gap-2 p-6 w-full">
                <div class="flex flex-row justify-between w-full items-start">
                    <div class="flex flex-col">
                        <h1 class="text-4xl font-bold">{nombre}</h1>
                        <p class="text-sm">{descripcion}</p>
                    </div>
                    <!-- Create task toggle -->
                    <button on:click={createTask} class="bg-white rounded-xl flex flex-row items-center p-2 gap-2 hover:opacity-70">
                        <i class="fa-solid fa-plus"></i>
                        <p>Crear Tarea</p>
                    </button>
                </div>

                <div class="flex flex-col gap-2">
                    {#each tareas as tarea}
                        <Task {tarea}/>
                    {/each}
                </div>
            </div>
        </div>
        {#if creating}
        <div class="absolute inset-0 z-10">
            <p>A</p>
        </div>
        {/if}
    </div>
</div>