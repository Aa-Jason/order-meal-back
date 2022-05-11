<template>
  <div>
    <div class="header">
      <img
        src="@/assets/logo-white.png"
        width="220px"
        v-if="mainTheme == 'darkMode'"
      />
      
      <div style="font-size:30px">欢迎来到报餐管理系统</div>
    </div>
  </div>
</template>

<script>
export default {
  name: "xboot-header",
  computed: {
    // 主题
    mainTheme() {
      return this.$store.state.theme.theme.mainTheme;
    },
  },
};
</script>

<style lang="less" scoped>
.header {
  margin-top: 8vh;
  margin-bottom: 5vh;
  text-align: center;

  .description {
    font-size: 14px;
    color: rgba(0, 0, 0, 0.45);
    margin-top: 1vh;
  }
}
</style>
