<script>
    import { db } from '$lib/session.js';
    import { goto } from '$app/navigation';

    export let id = "";
    export let descripcion = "";
    export let nombre = "";

    export let editing = false;
    export let editing_id = "";
    export let editing_nombre = "";
    export let editing_descripcion = "";

   async function deleteList() {
        await db.delete(id);
        window.location.href = '/listas';
    }

    async function beginEdit() {
        editing = !editing;
        editing_id = id;
        editing_nombre = nombre;
        editing_descripcion = descripcion;
    }

    async function gotoList() {
        goto('/lista/' + id);
    }
</script>

<div class="flex p-5 bg-[#A0E9FF] rounded-lg text-white-400  space-x-1 justify-center group">
    <div class="flex flex-col items-center gap-2">
        <p class="text-opacity-50 font-bold text-black space-x-5 ">{nombre}</p>
        <div class="invisible flex space-x-5 text-black text-opacity-50 flex-row group-hover:visible">
            <button class="hover:opacity-70 fa-solid fa-pen-to-square" on:click={beginEdit}></button>
            <button class="hover:opacity-70 fa-solid fa-trash" on:click={deleteList}></button>
            <button class="hover:opacity-70 fa-solid fa-play" on:click={gotoList}></button>
        </div>
    </div>
</div>