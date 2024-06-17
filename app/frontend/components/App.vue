<template>
    <div>
        <h3>{{ course }}</h3>
        <button-counter></button-counter>
    </div>
</template>

<script>
    export default {
        data() {
            return {
            course: 'Intro to Vue 3 and Rails'
            }
        }
    }
</script>
  