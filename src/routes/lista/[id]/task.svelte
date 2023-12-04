<script>
    export let tarea;

    function deleteTask() {
        console.log(tarea);
    }
</script>

<div class="flex w-full bg-white rounded-xl p-3 flex-col">
    <div class="flex flex-row gap-3">
        <p class="font-bold">{tarea.name}</p>
        <p>{tarea.description}</p>
    </div>
    <p class={ tarea.due_date_passed ? 'text-sm text-red-500' : 'text-sm text-black' }>{tarea.due_date}</p>
</div>