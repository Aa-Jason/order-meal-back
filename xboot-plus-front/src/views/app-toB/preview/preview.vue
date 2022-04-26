<style lang="less" scoped>
.appb-head {
  width: 100%;
  display: flex;
  height: 60px;
  align-items: center;
  justify-content: center;
}
.appb-imgs {
  margin-top: 30px;
  width: 100%;
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  img {
    width: 260px;
    height: 563px;
    margin: 10px 0;
  }
}
.iphone-content {
  display: flex;
  justify-content: center;
  position: relative;
  .demo-model {
    width: 404px;
    height: 800px;
  }
  .model-content {
    position: absolute;
    box-sizing: border-box;
    top: 48px;
    width: 375px;
    height: 720px;
    .iframe {
      height: 100%;
      width: 100%;
      border-radius: 16px;
    }
  }
}
</style>
<template>
  <div>
    <Card>
      <Row :gutter="10">
        <Col :xs="24" :sm="24" :lg="24" :xl="10" class="iphone-content">
          <img class="demo-model" src="@/assets/icon/iPhoneX.png" />
          <div class="model-content">
            <iframe
              scrolling="auto"
              frameborder="0"
              src="http://appb.exrick.cn"
              id="demo-modal"
              class="iframe"
            ></iframe>
          </div>
        </Col>
        <Col :xs="24" :sm="24" :lg="24" :xl="14">
          <Alert type="warning" show-icon>
            说明：全新配套使用Uniapp开发的toB面向企业级App，兼容多端！功能界面完善中...
            <a href="http://xpay.exrick.cn/pay?xboot" target="_blank"
              >立即获取完整版</a
            >
          </Alert>
          <div class="appb-head">
            <Poptip trigger="hover" title="打开手机扫一扫">
              <div slot="content">
                <img
                  src="https://s2.loli.net/2022/02/22/SqOhGsJawnuL6W9.png"
                  width="180px"
                />
              </div>
              <Button
                type="primary"
                icon="md-qr-scanner"
                shape="circle"
                style="margin-right: 20px"
                >手机扫码体验</Button
              >
            </Poptip>
            <Button
              to="http://appb.exrick.cn"
              target="_blank"
              shape="circle"
              icon="md-browsers"
              style="margin-right: 20px"
              >浏览器打开</Button
            >
            <Button
              to="http://xpay.exrick.cn/pay?xboot"
              target="_blank"
              shape="circle"
              type="warning"
              icon="ios-paper-plane"
              >立即获取源码</Button
            >
          </div>
          <div class="appb-imgs">
            <img src="https://s2.loli.net/2022/02/22/b9PUaTZMFdg7GNQ.png" />
            <img src="https://s2.loli.net/2022/02/22/pRhoPmi4EaGZkvl.png" />
            <img src="https://s2.loli.net/2022/02/22/wm1LMbgu9dCXyK6.png" />
          </div>
        </Col>
      </Row>
    </Card>
  </div>
</template>

<script>
export default {
  name: "preview",
  data() {
    return {};
  },
  methods: {
    init() {},
  },
  mounted() {
    this.init();
  },
};
</script>