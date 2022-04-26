<template>
  <div>
    <Divider class="component-blue" orientation="left"
      >wangEditor 富文本编辑器</Divider
    >
    <Alert type="info" show-icon>
      基于
      <a href="http://www.wangeditor.com" target="_blank">wangEditor v4</a>
      封装，已配置好图片上传(上传至XBoot文件服务或Base64)、视频上传；扩展编辑HTML代码、清空、XSS攻击过滤等。
    </Alert>
    <Tabs v-model="tabName">
      <TabPane label="素材中心上传" name="material"> </TabPane>
      <TabPane label="直接上传" name="direct"> </TabPane>
    </Tabs>
    <editor id="editor-material" v-model="editorData" material v-show="tabName=='material'"></editor>
    <editor id="editor-direct" v-show="tabName=='direct'"></editor>
    <h3 class="component-article">基础用法</h3>
    使用
    <code>v-model</code>
    实现数据的双向绑定，赋值时外层需包含一个HTML标签（编辑HTML代码时同需注意）。单页面同时使用两个及以上该组件时，需设定不同的id值加以区分。
    <h3 class="component-article">props</h3>
    <Table
      :columns="props"
      :data="data1"
      border
      size="small"
      width="1000"
    ></Table>
    <h3 class="component-article">events</h3>
    <Table
      :columns="events"
      :data="data2"
      border
      size="small"
      width="1000"
    ></Table>
    <h3 class="component-article">methods</h3>
    <Table
      :columns="methods"
      :data="data3"
      border
      size="small"
      width="1000"
    ></Table>
  </div>
</template>
<script>
import { props, events, methods } from "./columns";
import editor from "@/views/my-components/xboot/editor";
export default {
  components: {
    editor,
  },
  data() {
    return {
      tabName: "material",
      props: props,
      events: events,
      methods: methods,
      editorData:
        '<p><img src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a1/2018new_doge02_org.png" alt="[doge]"></p>',
      data1: [
        {
          name: "value",
          desc: "绑定的值，可使用 v-model 双向绑定（赋值时外层需包含一个HTML标签）",
          type: "String",
          value: "空",
        },
        {
          name: "id",
          desc: "富文本编辑器的id值，用于绑定富文本编辑器，当同时使用两个及以上该组件时，需设定不同的id值加以区分",
          type: "String",
          value: "editor",
        },
        {
          name: "height",
          desc: "编辑器的高度层级，默认为300，单位px",
          type: "Number | String",
          value: "300",
        },
        {
          name: "placeholder",
          desc: "占位文本",
          type: "String",
          value: "在这里输入内容",
        },
        {
          name: "material",
          desc: "是否启用素材中心上传图片、视频",
          type: "Boolean",
          value: "false",
        },
        {
          name: "maxSize",
          desc: "启用素材中心时，单个上传文件最大限制大小（单位Mb）",
          type: "Number",
          value: "5",
        },
        {
          name: "uploadPic",
          desc: "是否开启上传图片功能",
          type: "Boolean",
          value: "true",
        },
        {
          name: "base64",
          desc: "是否使用base64存储图片，默认false上传至XBoot配置的文件存储服务中，不推荐使用base64存储",
          type: "Boolean",
          value: "false",
        },
        {
          name: "uploadVideo",
          desc: "是否开启上传视频功能",
          type: "Boolean",
          value: "true",
        },
        {
          name: "expandHtml",
          desc: "是否显示顶部扩展 编辑Html代码 按钮",
          type: "Boolean",
          value: "true",
        },
        {
          name: "expandClear",
          desc: "是否显示顶部扩展 清空 按钮",
          type: "Boolean",
          value: "true",
        },
        {
          name: "showFullScreen",
          desc: "是否显示 全屏 按钮",
          type: "Boolean",
          value: "true",
        },
        {
          name: "openXss",
          desc: "是否打开XSS过滤，无需过滤的标签请自行在组件中添加白名单 https://github.com/leizongmin/js-xss",
          type: "Boolean",
          value: "false",
        },
        {
          name: "zIndex",
          desc: "编辑器的z-index层级，默认为1",
          type: "Number",
          value: "1",
        },
        {
          name: "uploadImgTimeout",
          desc: "图片上传超时时间，单位毫秒，默认为10秒",
          type: "Number",
          value: "10000",
        },
        {
          name: "uploadVideoTimeout",
          desc: "视频上传超时时间，单位毫秒，默认为5分钟",
          type: "Number",
          value: "300000",
        },
      ],
      data2: [
        {
          name: "on-change",
          type: "返回富文本编辑器内容",
          value: "value（富文本编辑器内容）",
        },
      ],
      data3: [
        {
          name: "setData",
          type: "设置富文本编辑器内容（外层需包含一个HTML标签）",
          value: "你要传入的内容，示例 setData(‘<p>data</p>’)",
        },
      ],
    };
  },
  methods: {},
  mounted() {},
};
</script>