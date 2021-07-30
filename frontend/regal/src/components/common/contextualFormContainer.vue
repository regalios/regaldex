<template>
    
</template>

<script>
export default {
    name: "contextualFormContainer",
    props: {
        isModal: bool,
        modalAction?: Function,
        form_data: Object

    },
    data() {
        return {
            formData: {}
        }
    }
}
</script>