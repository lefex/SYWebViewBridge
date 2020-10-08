<template>
    <div>
        <div v-if="status === '0' || !status" class="text untest">Waiting Test</div>
        <div v-else-if="status === '1'" class="text success">Test Successful</div>
        <div v-else class="text fail">Test Failed</div>
    </div>
</template>

<script>
export default {
    props: {
        status: {
            type: String,
            value: '0'
        }
    }
};
</script>

<style scoped>
.text {
    font-family: PingFangSC-Medium;
    font-size: 30px;
}
.untest {
    color: #5B83FD;
}
.success {
    color: #2BC942;
}
.fail {
    color: #d0021b;
}
</style>