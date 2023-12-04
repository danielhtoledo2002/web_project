<script>
    export let tarea;

    function deleteTask() {
        console.log(tarea);
    }
</script>

<div class="flex w-full bg-white rounded-xl p-3 flex-col">
    <div class={ tarea.due_date_passed ? 'flex justify-between flex-row text-sm text-red-500' : 'flex justify-between flex-row text-sm text-black' }>
        <p>{tarea.due_date_passed ? 'Expired' : tarea.remain.split('m')[0] + 'm' }</p>
        <p>{tarea.due_date_format}</p>
    </div>
    <div class="flex flex-row justify-between">
        <div>
            <p class="font-bold">{tarea.name}</p>
        </div>
        <div class="flex flex-row gap-3">
            <button class="hover:opacity-70 fa-solid fa-pen-to-square"></button>
            <button class="hover:opacity-70 fa-solid fa-trash" on:click={deleteTask}></button>
        </div>
    </div>
    <p class="text-sm">Description: {tarea.description}</p>
</div>