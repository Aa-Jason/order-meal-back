<template>
  <div>
    <div :id="id"></div>

    <Modal
      v-model="showHTMLModal"
      :mask-closable="false"
      :width="900"
      :fullscreen="full"
      :z-index="10001"
      class="wangeditor-model"
    >
      <div slot="header">
        <div class="ivu-modal-header-inner">编辑HTML代码</div>
        <a @click="handleFull" class="modal-fullscreen">
          <Icon
            v-show="!full"
            type="ios-expand"
            class="model-fullscreen-icon"
          />
          <Icon
            v-show="full"
            type="ios-contract"
            class="model-fullscreen-icon"
          />
        </a>
        <a @click="showHTMLModal = false" class="ivu-modal-close">
          <Icon type="ios-close" class="ivu-icon-ios-close" />
        </a>
      </div>
      <monaco
        id="monaco1"
        v-if="showHTMLModal"
        v-model="dataEdit"
        language="html"
        :height="monacoHeight"
        :showFullscreen="false"
        ref="monaco1"
      />
      <div slot="footer">
        <Button @click="editHTMLOk" type="primary">保存提交</Button>
      </div>
    </Modal>
    <Modal
      v-model="showClearModal"
      :closable="false"
      :mask-closable="false"
      :width="416"
      :footer-hide="true"
      :z-index="10001"
    >
      <div class="ivu-modal-confirm">
        <div class="ivu-modal-confirm-head">
          <div
            class="
              ivu-modal-confirm-head-icon ivu-modal-confirm-head-icon-confirm
            "
          >
            <i class="ivu-icon ivu-icon-ios-help-circle"></i>
          </div>
          <div class="ivu-modal-confirm-head-title">确认清空</div>
        </div>
        <div class="ivu-modal-confirm-body">确认要清空编辑器内容？</div>
        <div class="ivu-modal-confirm-footer">
          <Button type="text" @click="showClearModal = false">取消</Button>
          <Button @click="clear" type="primary">确定</Button>
        </div>
      </div>
    </Modal>

    <materialCenter
      v-if="material"
      v-model="showMaterialImage"
      @on-change="selectImage"
      :maxSize="maxSize"
      multiple
    />

    <materialCenter
      v-if="material"
      mode="视频"
      v-model="showMaterialVideo"
      @on-change="selectVideo"
      :maxSize="maxSize"
    />
  </div>
</template>

<script>
import { uploadFile } from "@/api/index";
import E from "wangeditor";
import xss from "xss";
import monaco from "@/views/my-components/xboot/monaco";
import materialCenter from "@/views/my-components/xboot/material-center";
export default {
  components: {
    monaco,
    materialCenter,
  },
  name: "editor",
  props: {
    id: {
      type: String,
      default: "editor",
    },
    value: String,
    zIndex: {
      type: Number,
      default: 1,
    },
    height: {
      type: [Number, String],
      default: 300,
    },
    placeholder: {
      type: String,
      default: "在这里输入内容",
    },
    material: {
      type: Boolean,
      default: false,
    },
    maxSize: {
      type: Number,
      default: 5,
    },
    base64: {
      type: Boolean,
      default: false,
    },
    uploadPic: {
      type: Boolean,
      default: true,
    },
    uploadImgTimeout: {
      type: Number,
      default: 10000,
    },
    uploadVideo: {
      type: Boolean,
      default: true,
    },
    uploadVideoTimeout: {
      type: Number,
      default: 300000,
    },
    expandHtml: {
      type: Boolean,
      default: true,
    },
    expandClear: {
      type: Boolean,
      default: true,
    },
    showFullScreen: {
      type: Boolean,
      default: true,
    },
    openXss: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      editor: null,
      data: this.value, // 富文本数据
      dataEdit: "", // 编辑数据
      showHTMLModal: false, // 显示html
      full: false, // html全屏开关
      showClearModal: false,
      monacoHeight: 500,
      fullHeight: 100,
      showMaterialImage: false,
      showMaterialVideo: false,
    };
  },
  methods: {
    initEditor() {
      let that = this;
      this.editor = new E(`#${this.id}`);

      const { $, BtnMenu, DropListMenu, PanelMenu, DropList, Panel, Tooltip } =
        E;
      // 扩展菜单
      class EditHTMLMenu extends BtnMenu {
        constructor(editor) {
          const $elem = E.$(
            `<div class="w-e-menu" data-title="编辑源代码"><i class="ivu-icon ivu-icon-md-code-working" style="font-size: 22px;"></i></div>`
          );
          super($elem, editor);
        }
        // 菜单点击事件
        clickHandler() {
          that.editHTML();
        }
        // 菜单激活状态
        tryChangeActive() {}
      }
      class ClearMenu extends BtnMenu {
        constructor(editor) {
          const $elem = E.$(
            `<div class="w-e-menu" data-title="清空"><i class="ivu-icon ivu-icon-md-trash" style="font-size: 18px;"></i></div>`
          );
          super($elem, editor);
        }
        // 菜单点击事件
        clickHandler() {
          that.showClearModal = true;
        }
        // 菜单激活状态
        tryChangeActive() {}
      }
      class ImageMenu extends BtnMenu {
        constructor(editor) {
          const $elem = E.$(
            `<div class="w-e-menu" data-title="图片"><i class="w-e-icon-image"></i></div>`
          );
          super($elem, editor);
        }
        // 菜单点击事件
        clickHandler() {
          that.showMaterialImage = true;
        }
        // 菜单激活状态
        tryChangeActive() {}
      }
      class VideoMenu extends BtnMenu {
        constructor(editor) {
          const $elem = E.$(
            `<div class="w-e-menu" data-title="视频"><i class="w-e-icon-play"></i></div>`
          );
          super($elem, editor);
        }
        // 菜单点击事件
        clickHandler() {
          that.showMaterialVideo = true;
        }
        // 菜单激活状态
        tryChangeActive() {}
      }
      if (this.expandHtml) {
        // 扩展注册菜单 将菜单加入到 editor.config.menus 中
        this.editor.menus.extend("editHTMLMenu", EditHTMLMenu);
        this.editor.config.menus.push("editHTMLMenu");
      }
      if (this.expandClear) {
        this.editor.menus.extend("clearMenu", ClearMenu);
        this.editor.config.menus.push("clearMenu");
      }

      if (this.material) {
        // 移除原图片视频上传菜单
        this.editor.config.excludeMenus = ["image", "video"];
        // 添加新素材中心版
        if (this.uploadPic) {
          this.editor.menus.extend("imageMenu", ImageMenu);
          this.editor.config.menus.splice(17, 0, "imageMenu");
        }
        if (this.uploadVideo) {
          this.editor.menus.extend("videoMenu", VideoMenu);
          this.editor.config.menus.splice(18, 0, "videoMenu");
        }
      }

      // 全屏
      this.editor.config.showFullScreen = this.showFullScreen;
      // 编辑内容绑定数据
      this.editor.config.onchange = (html) => {
        if (this.openXss) {
          this.data = xss(html);
        } else {
          this.data = html;
        }
        this.$emit("input", this.data);
        this.$emit("on-change", this.data);
      };
      // 高度
      this.editor.config.height = this.height;
      // z-index
      this.editor.config.zIndex = this.zIndex;
      // placeholder
      this.editor.config.placeholder = this.placeholder;
      // 图片上传超时时间
      this.editor.config.uploadImgTimeout = this.uploadImgTimeout;
      // 视频上传超时时间
      this.editor.config.uploadVideoTimeout = this.uploadVideoTimeout;
      // 图片上传
      if (this.uploadPic) {
        if (this.base64) {
          // 使用 base64 保存图片
          this.editor.config.uploadImgShowBase64 = true;
        } else {
          // 配置上传图片服务器端地址
          this.editor.config.uploadImgServer = uploadFile;
          // xboot如要header中传入token鉴权
          this.editor.config.uploadImgHeaders = {
            accessToken: that.getStore("accessToken"),
          };
          this.editor.config.uploadFileName = "file";
          this.editor.config.uploadImgHooks = {
            before: function (xhr, editor, files) {
              // 图片上传之前触发
            },
            success: function (xhr, editor, result) {
              // 图片上传并返回结果，图片插入成功之后触发
            },
            fail: function (xhr, editor, result) {
              // 图片上传并返回结果，但图片插入错误时触发
              that.$Message.error("上传图片失败");
            },
            error: function (xhr, editor) {
              // 图片上传出错时触发
              that.$Message.error("上传图片出错");
            },
            timeout: function (xhr, editor) {
              // 图片上传超时时触发
              that.$Message.error("上传图片超时");
            },
            // 如果服务器端返回的不是 {errno:0, data: [...]} 这种格式，可使用该配置
            customInsert: function (insertImg, result, editor) {
              if (result.success == true) {
                let url = result.result;
                insertImg(url);
                that.$Message.success("上传图片成功");
              } else {
                that.$Message.error(result.message);
              }
            },
          };
        }
      }
      // 视频上传
      if (this.uploadVideo) {
        this.editor.config.uploadVideoServer = uploadFile;
        this.editor.config.uploadVideoHeaders = {
          accessToken: that.getStore("accessToken"),
        };
        this.editor.config.uploadVideoName = "file";
        this.editor.config.uploadVideoHooks = {
          before: function (xhr, editor, files) {
            // 视频上传之前触发
          },
          success: function (xhr, editor, result) {
            // 视频上传并返回结果，图片插入成功之后触发
          },
          fail: function (xhr, editor, result) {
            // 视频上传并返回结果，但图片插入错误时触发
            that.$Message.error("上传视频失败");
          },
          error: function (xhr, editor) {
            // 图片上传出错时触发
            that.$Message.error("上传视频出错");
          },
          timeout: function (xhr, editor) {
            // 图片上传超时时触发
            that.$Message.error("上传视频超时");
          },
          // 如果服务器端返回的不是 {errno:0, data: [...]} 这种格式，可使用该配置
          customInsert: function (insertVideo, result, editor) {
            if (result.success == true) {
              let url = result.result;
              insertVideo(url);
              that.$Message.success("上传视频成功");
            } else {
              that.$Message.error(result.message);
            }
          },
        };
      }
      this.editor.config.customAlert = (info) => {
        // info 是需要提示的内容
        // this.$Message.info(info);
      };
      this.editor.create();
      if (this.value) {
        if (this.openXss) {
          this.editor.txt.html(xss(this.value));
        } else {
          this.editor.txt.html(this.value);
        }
      }
    },
    selectImage(v) {
      v.forEach((e) => {
        this.editor.cmd.do(
          "insertHTML",
          `<img src="${e}" contenteditable="false" style="max-width: 100%;"/>`
        );
      });
    },
    selectVideo(v) {
      this.editor.cmd.do(
        "insertHTML",
        `<video src="${v}"  controls="controls" style="max-width:100%"></video>`
      );
    },
    handleFull() {
      this.full = !this.full;
      if (this.full) {
        this.monacoHeight = this.fullHeight;
      } else {
        this.monacoHeight = 500;
      }
      setTimeout(() => {
        this.$refs.monaco1.layout();
      }, 10);
    },
    editHTML() {
      this.dataEdit = this.data;
      this.showHTMLModal = true;
    },
    editHTMLOk() {
      this.editor.txt.html(this.dataEdit);
      this.$emit("input", this.dataEdit);
      this.$emit("on-change", this.dataEdit);
      this.showHTMLModal = false;
    },
    clear() {
      this.data = "";
      this.editor.txt.html(this.data);
      this.$emit("input", this.data);
      this.$emit("on-change", this.data);
      this.showClearModal = false;
    },
    setData(value) {
      if (!this.editor) {
        this.initEditor();
      }
      if (value != this.data) {
        this.data = value;
        this.editor.txt.html(this.data);
        this.$emit("input", this.data);
        this.$emit("on-change", this.data);
      }
    },
  },
  beforeDestroy() {
    // 调用销毁 API 对当前编辑器实例进行销毁
    if (this.editor != null) {
      this.editor.destroy();
    }
  },
  watch: {
    value(val) {
      this.setData(val);
    },
  },
  mounted() {
    this.initEditor();
    this.fullHeight = Number(document.body.clientHeight - 144);
  },
};
</script>

<style lang="less">
.w-e-toolbar p,
.w-e-text-container p,
.w-e-menu-panel p {
  font-size: 1em !important;
}
.wangeditor-model {
  .ivu-modal-body {
    padding: 0px;
  }
}
</style>

