<style lang="less">
@import "@/styles/tree&table-common.less";
@import "@/styles/table-common.less";
@import "./file.less";
</style>
<template>
  <div class="search">
    <trash v-if="showTrash" @close="showTrash = false" />
    <Card v-show="!showTrash">
      <Row type="flex" justify="space-between">
        <Col v-show="expand" span="5">
          <fileCategory @on-select="selectCategory" />
        </Col>
        <div class="expand">
          <Icon
            :type="expandIcon"
            size="16"
            class="icon"
            @click="changeExpand"
          />
        </div>
        <Col :span="span">
          <Row v-show="openSearch" @keydown.enter.native="handleSearch">
            <Form ref="searchForm" :model="searchForm" inline :label-width="70">
              <FormItem label="文件名" prop="title">
                <Input
                  type="text"
                  v-model="searchForm.title"
                  placeholder="请输入文件名"
                  clearable
                  style="width: 200px"
                />
              </FormItem>
              <FormItem label="创建时间">
                <DatePicker
                  :options="options"
                  v-model="selectDate"
                  type="daterange"
                  format="yyyy-MM-dd"
                  clearable
                  @on-change="selectDateRange"
                  placeholder="选择起始时间"
                  style="width: 200px"
                ></DatePicker>
              </FormItem>
              <FormItem style="margin-left: -35px" class="br">
                <Button @click="handleSearch" type="primary" icon="ios-search"
                  >搜索</Button
                >
                <Button @click="handleReset">重置</Button>
              </FormItem>
            </Form>
          </Row>
          <Row class="operation" align="middle" justify="space-between">
            <div class="br">
              <Button
                :disabled="!searchForm.categoryId"
                @click="uploadVisible = true"
                type="primary"
                icon="md-cloud-upload"
                >上传文件</Button
              >
              <Dropdown @on-click="handleDropdown">
                <Button>
                  更多操作
                  <Icon type="md-arrow-dropdown" />
                </Button>
                <DropdownMenu slot="list">
                  <DropdownItem v-show="showType == 'list'" name="moveAll"
                    >移动</DropdownItem
                  >
                  <DropdownItem v-show="showType == 'list'" name="removeAll"
                    >批量删除</DropdownItem
                  >
                  <DropdownItem v-show="showType == 'thumb'" name="title"
                    >原名称排序</DropdownItem
                  >
                  <DropdownItem v-show="showType == 'thumb'" name="size"
                    >文件大小排序</DropdownItem
                  >
                  <DropdownItem v-show="showType == 'thumb'" name="type"
                    >文件类型排序</DropdownItem
                  >
                  <DropdownItem v-show="showType == 'thumb'" name="time"
                    >创建时间排序</DropdownItem
                  >
                </DropdownMenu>
              </Dropdown>
              <Button @click="showTrash = true" type="dashed" icon="md-trash"
                >回收站</Button
              >
            </div>

            <div class="icons">
              <Tooltip content="刷新" placement="top" transfer>
                <Icon
                  type="md-refresh"
                  size="18"
                  class="item"
                  @click="getDataList"
                />
              </Tooltip>
              <Tooltip
                :content="openSearch ? '关闭搜索' : '开启搜索'"
                placement="top"
                transfer
              >
                <Icon
                  type="ios-search"
                  size="18"
                  class="item tip"
                  @click="openSearch = !openSearch"
                />
              </Tooltip>
              <Tooltip
                :content="openTip ? '关闭提示' : '开启提示'"
                placement="top"
                transfer
              >
                <Icon
                  type="md-bulb"
                  size="18"
                  class="item tip"
                  @click="openTip = !openTip"
                />
              </Tooltip>
              <Select
                v-model="fileType"
                style="width: 150px; margin: 0 25px 0 15px"
                @on-change="changeFileType"
              >
                <Option value="all">所有文件</Option>
                <Option value="word">Word</Option>
                <Option value="excel">Excel</Option>
                <Option value="pdf">PDF</Option>
                <Option value="pic">图片</Option>
                <Option value="video">视频</Option>
                <Option value="audio">音频</Option>
                <Option value="text">文本</Option>
                <Option value="ppt">PPT</Option>
                <Option value="zip">ZIP</Option>
                <Option value="rar">RAR</Option>
              </Select>
              <RadioGroup
                v-model="showType"
                type="button"
                @on-change="changeShowType"
              >
                <Radio title="列表" label="list">
                  <Icon type="md-list"></Icon>
                </Radio>
                <Radio title="缩略图" label="thumb">
                  <Icon type="ios-apps"></Icon>
                </Radio>
              </RadioGroup>
            </div>
          </Row>

          <div v-show="showType == 'list'">
            <Alert show-icon v-show="openTip">
              已选择
              <span class="select-count">{{ selectList.length }}</span> 项
              <a class="select-clear" @click="clearSelectAll">清空</a>
              <span v-if="selectList.length > 0" style="margin-left: 15px"
                >共计 {{ totalSize }} 存储量</span
              >
            </Alert>
            <Table
              :loading="loading"
              border
              :columns="columns"
              :data="data"
              ref="table"
              sortable="custom"
              @on-sort-change="changeSort"
              @on-selection-change="changeSelect"
            ></Table>
          </div>
          <Row type="flex" :gutter="30" v-show="showType == 'thumb'">
            <Col :lg="6" :md="12" :xs="12" v-for="(item, i) in data" :key="i">
              <Card class="oss-card">
                <div class="content">
                  <div class="collect-icon" v-if="item.isCollect">
                    <Icon type="md-star" color="#ffc60a" size="18"/>
                  </div>
                  <img
                    @click="showPic(item)"
                    v-if="item.type.indexOf('image') >= 0"
                    class="img"
                    :src="item.url"
                  />
                  <div
                    v-else-if="item.type.indexOf('video') >= 0"
                    class="video"
                    @click="showVideo(item)"
                  >
                    <video class="cover">
                      <source :src="item.url + '#t=1'" preload="metadata" />
                    </video>
                    <img class="play" src="@/assets/icon/play.png" />
                  </div>
                  <div v-else class="other" @click="previewFile(item)">
                    <div class="name">{{ item.title }}</div>
                    <div class="key">{{ item.fkey }}</div>
                    <div class="info">
                      文件类型：{{ util.ellipsis(item.type, 30) }} 文件大小：{{
                        util.getFileSize(item.size)
                      }}
                      创建时间：{{ item.createTime }}
                    </div>
                  </div>
                  <div class="actions">
                    <div class="btn">
                      <Tooltip content="下载" placement="top">
                        <Icon
                          @click="download(item)"
                          type="md-download"
                          size="16"
                        />
                      </Tooltip>
                    </div>
                    <div class="btn">
                      <Tooltip content="分享" placement="top">
                        <Icon @click="share(item)" type="md-share" size="16" />
                      </Tooltip>
                    </div>
                    <div class="btn">
                      <Tooltip content="重命名" placement="top">
                        <Icon
                          @click="rename(item)"
                          type="md-create"
                          size="16"
                        />
                      </Tooltip>
                    </div>
                    <div class="btn-no">
                      <Dropdown @on-click="changeDropDown(item, $event)">
                        <Icon type="ios-more" size="24" />
                        <DropdownMenu slot="list">
                          <DropdownItem name="collect">{{
                            item.isCollect ? "取消收藏" : "收藏"
                          }}</DropdownItem>
                          <DropdownItem name="copy">复制</DropdownItem>
                          <DropdownItem name="remove">删除</DropdownItem>
                        </DropdownMenu>
                      </Dropdown>
                    </div>
                  </div>
                </div>
              </Card>
            </Col>
          </Row>
          <Row type="flex" justify="end" class="page">
            <Page
              :current="searchForm.pageNumber"
              :total="total"
              :page-size="searchForm.pageSize"
              @on-change="changePage"
              @on-page-size-change="changePageSize"
              :page-size-opts="pageSizeOpts"
              size="small"
              show-total
              show-elevator
              show-sizer
            ></Page>
          </Row>
        </Col>
      </Row>
    </Card>

    <Drawer
      :title="`上传文件至：${currCate}`"
      closable
      v-model="uploadVisible"
      width="500"
    >
      <Upload
        :action="uploadFileUrl"
        :headers="accessToken"
        :data="uploadData"
        :on-success="handleSuccess"
        :on-error="handleError"
        :max-size="5120"
        :on-exceeded-size="handleMaxSize"
        :before-upload="beforeUpload"
        multiple
        type="drag"
        ref="up"
      >
        <div style="padding: 20px 0">
          <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
          <p>点击这里或将文件拖拽到这里上传</p>
        </div>
      </Upload>
      <div class="drawer-footer">
        <Button @click="clearFiles">清空上传列表</Button>
      </div>
    </Drawer>

    <Modal
      :title="modalTitle"
      v-model="modalVisible"
      :mask-closable="false"
      :width="500"
    >
      <Form ref="form" :model="form" inline :rules="formValidate">
        <FormItem label="文件名" prop="title" style="width: 100%">
          <Input v-model="form.title" />
        </FormItem>
      </Form>
      <div slot="footer">
        <Button type="text" @click="handleCancel">取消</Button>
        <Button type="primary" :loading="submitLoading" @click="handleSubmit"
          >提交</Button
        >
      </div>
    </Modal>

    <Modal
      title="移动至"
      v-model="moveVisible"
      :mask-closable="false"
      :width="500"
    >
      <fileCategory
        showOnly
        @on-select="selectMoveCategory"
        class="fileMoveModal"
      />
      <div slot="footer">
        <Button type="text" @click="moveVisible = false">取消</Button>
        <Button
          type="primary"
          :loading="submitLoading"
          @click="handleSubmitMove"
          >移动至此</Button
        >
      </div>
    </Modal>

    <Modal
      v-model="videoVisible"
      :title="videoTitle"
      :width="800"
      @on-cancel="closeVideo"
      draggable
    >
      <div id="dplayer" style="height: 500px"></div>
      <div slot="footer">
        <span
          >文件类型：{{ util.ellipsis(file.type, 30) }} 文件大小：{{
            file.msize
          }}
          创建时间：{{ file.createTime }}</span
        >
      </div>
    </Modal>
  </div>
</template>

<script>
import {
  uploadFile,
  checkOssSet,
  getUserFileListData,
  copyUserFile,
  moveFile,
  renameUserFile,
  trashFile,
  collectFile,
} from "@/api/index";
import fileCategory from "@/views/app-toB/file/fileCategory";
import trash from "./trash.vue";
import DPlayer from "dplayer";
import "viewerjs/dist/viewer.css";
import Viewer from "viewerjs";
import { shortcuts } from "@/libs/shortcuts";
export default {
  name: "file",
  components: {
    fileCategory,
    trash,
  },
  data() {
    return {
      showTrash: false,
      uploadData: {},
      currCate: "",
      expand: true,
      span: 18,
      expandIcon: "ios-arrow-back",
      dp: null,
      uploadFileUrl: uploadFile,
      openSearch: true,
      openTip: true,
      accessToken: {}, // 上传token鉴权
      loading: false, // 表单加载状态
      fileType: "all",
      showType: "list",
      modalVisible: false, // 添加或编辑显示
      moveVisible: false,
      uploadVisible: false,
      videoVisible: false,
      picVisible: false,
      picTitle: "",
      videoTitle: "",
      modalTitle: "", // 添加或编辑标题
      moveCategoryId: "",
      moveFileIds: [],
      searchForm: {
        // 搜索框对应data对象
        title: "",
        type: "",
        pageNumber: 1, // 当前页数
        pageSize: 5, // 页面大小
        sort: "createTime", // 默认排序字段
        order: "desc", // 默认排序方式
        startDate: "", // 起始时间
        endDate: "", // 终止时间
        categoryId: "0",
        isCollect: null,
      },
      selectDate: null, // 选择日期绑定modal
      options: {
        shortcuts: shortcuts,
      },
      form: {
        title: "",
        fkey: "",
      },
      file: {},
      // 表单验证规则
      formValidate: {
        title: [{ required: true, message: "不能为空", trigger: "blur" }],
        fkey: [{ required: true, message: "不能为空", trigger: "blur" }],
      },
      submitLoading: false, // 添加或编辑提交状态
      selectList: [], // 多选数据
      totalSize: "", // 文件大小统计
      columns: [
        // 表头
        {
          type: "selection",
          width: 60,
          align: "center",
        },
        {
          type: "index",
          width: 60,
          align: "center",
        },
        {
          title: "文件名",
          key: "title",
          minWidth: 150,
          sortable: true,
          render: (h, params) => {
            if (params.row.isCollect) {
              return h("div", [
                h("span", params.row.title),
                h("Icon", {
                  style: {
                    marginLeft: "5px",
                  },
                  props: {
                    type: "md-star",
                    color: "#ffc60a",
                    size: "18",
                  },
                }),
              ]);
            }
            return h("span", params.row.title);
          },
        },
        {
          title: "缩略图(点击预览)",
          key: "url",
          width: 150,
          align: "center",
          render: (h, params) => {
            if (params.row.type.includes("image") > 0) {
              return h("img", {
                attrs: {
                  src: params.row.url,
                },
                style: {
                  cursor: "zoom-in",
                  width: "80px",
                  height: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.showPic(params.row);
                  },
                },
              });
            } else if (params.row.type.includes("video") > 0) {
              return h(
                "video",
                {
                  style: {
                    cursor: "pointer",
                    width: "80px",
                    height: "60px",
                    margin: "10px 0",
                    "object-fit": "contain",
                  },
                  on: {
                    click: () => {
                      this.showVideo(params.row);
                    },
                  },
                },
                [
                  h("source", {
                    attrs: {
                      src: params.row.url + "#t=1",
                      preload: "metadata",
                    },
                  }),
                ]
              );
            } else if (params.row.type.includes("word") > 0) {
              return h("img", {
                attrs: {
                  src: require("@/assets/icon/word.png"),
                },
                style: {
                  cursor: "zoom-in",
                  width: "80px",
                  height: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.showOffice(params.row);
                  },
                },
              });
            } else if (
              params.row.fkey.includes(".xlsx") > 0 ||
              params.row.fkey.includes(".xls") > 0 ||
              params.row.type.includes("sheet") > 0
            ) {
              return h("img", {
                attrs: {
                  src: require("@/assets/icon/xls.png"),
                },
                style: {
                  cursor: "zoom-in",
                  width: "80px",
                  height: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.showOffice(params.row);
                  },
                },
              });
            } else if (params.row.type.includes("presentation") > 0) {
              return h("img", {
                attrs: {
                  src: require("@/assets/icon/ppt.png"),
                },
                style: {
                  cursor: "zoom-in",
                  width: "80px",
                  height: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.showOffice(params.row);
                  },
                },
              });
            } else if (params.row.type.includes("pdf") > 0) {
              return h("img", {
                attrs: {
                  src: require("@/assets/icon/pdf.png"),
                },
                style: {
                  cursor: "zoom-in",
                  width: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.showFile(params.row);
                  },
                },
              });
            } else if (params.row.type.includes("audio") > 0) {
              return h("img", {
                attrs: {
                  src: require("@/assets/icon/mp3.png"),
                },
                style: {
                  cursor: "zoom-in",
                  width: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.showVideo(params.row);
                  },
                },
              });
            } else if (
              params.row.type.includes("zip") > 0 ||
              params.row.type.includes("rar") > 0 ||
              params.row.type.includes("7z") > 0
            ) {
              return h("img", {
                attrs: {
                  src: require("@/assets/icon/zip.png"),
                },
                style: {
                  width: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.$Message.warning("暂不支持预览");
                  },
                },
              });
            } else if (
              params.row.type.includes("text") > 0 ||
              params.row.type.includes("octet") > 0
            ) {
              return h("img", {
                attrs: {
                  src: require("@/assets/icon/file.png"),
                },
                style: {
                  cursor: "zoom-in",
                  width: "55px",
                  height: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.showFile(params.row);
                  },
                },
              });
            } else {
              return h("img", {
                attrs: {
                  src: require("@/assets/icon/file.png"),
                },
                style: {
                  width: "55px",
                  height: "60px",
                  margin: "10px 0",
                  "object-fit": "contain",
                },
                on: {
                  click: () => {
                    this.$Message.warning("暂不支持预览");
                  },
                },
              });
            }
          },
        },
        {
          title: "文件类型",
          key: "type",
          width: 120,
          sortable: true,
          tooltip: true,
        },
        {
          title: "文件大小",
          key: "size",
          width: 120,
          align: "center",
          sortable: true,
          render: (h, params) => {
            let m = this.util.getFileSize(params.row.size);
            return h("span", m);
          },
        },
        {
          title: "创建时间",
          key: "createTime",
          width: 180,
          sortable: true,
          sortType: "desc",
        },
        {
          title: "操作",
          key: "action",
          align: "center",
          fixed: "right",
          width: 170,
          render: (h, params) => {
            return h("div", [
              h(
                "a",
                {
                  on: {
                    click: () => {
                      this.download(params.row);
                    },
                  },
                },
                "下载"
              ),
              h("Divider", {
                props: {
                  type: "vertical",
                },
              }),
              h(
                "Dropdown",
                {
                  props: { transfer: true },
                  on: {
                    "on-click": (v) => {
                      this.changeDropDown(params.row, v);
                    },
                  },
                },
                [
                  h("a", [
                    "更多操作",
                    h("Icon", {
                      props: {
                        type: "ios-arrow-down",
                      },
                    }),
                  ]),
                  h("DropdownMenu", { slot: "list" }, [
                    h("DropdownItem", { props: { name: "share" } }, "分享"),
                    h(
                      "DropdownItem",
                      { props: { name: "collect" } },
                      params.row.isCollect ? "取消收藏" : "收藏"
                    ),
                    h("DropdownItem", { props: { name: "rename" } }, "重命名"),
                    h("DropdownItem", { props: { name: "move" } }, "移动"),
                    h("DropdownItem", { props: { name: "copy" } }, "复制"),
                    h("DropdownItem", { props: { name: "remove" } }, "删除"),
                  ]),
                ]
              ),
            ]);
          },
        },
      ],
      data: [], // 表单数据
      total: 0, // 表单数据总数
      pageSizeOpts: [5, 10, 20],
    };
  },
  methods: {
    handleDropdown(name) {
      if (name == "moveAll") {
        this.moveAll();
      } else if (name == "removeAll") {
        this.removeAll();
      } else if (name == "title") {
        this.searchForm.sort = "title";
        this.getDataList();
      } else if (name == "size") {
        this.searchForm.sort = "size";
        this.getDataList();
      } else if (name == "type") {
        this.searchForm.sort = "type";
        this.getDataList();
      } else if (name == "time") {
        this.searchForm.sort = "createTime";
        this.getDataList();
      }
    },
    init() {
      this.accessToken = {
        accessToken: this.getStore("accessToken"),
      };
      checkOssSet().then((res) => {
        if (!res.success) {
          this.$Modal.confirm({
            title: "系统还未配置OSS",
            content: "管理员还未配置第三方OSS服务，是否现在立即去配置?",
            onOk: () => {
              this.$router.push({
                name: "setting",
                query: { name: "oss" },
              });
            },
          });
        }
      });
    },
    selectCategory(v) {
      if (v.id == "-1") {
        // 收藏夹
        this.searchForm.categoryId = "";
        this.searchForm.isCollect = true;
        this.getDataList();
      } else {
        this.searchForm.isCollect = null;
        this.searchForm.categoryId = v.id;
        this.uploadData = {
          categoryId: v.id,
        };
        this.currCate = v.title;
        this.getDataList();
      }
    },
    changeExpand() {
      this.expand = !this.expand;
      if (this.expand) {
        this.expandIcon = "ios-arrow-back";
        this.span = 18;
      } else {
        this.expandIcon = "ios-arrow-forward";
        this.span = 23;
      }
    },
    showPic(v) {
      let image = new Image();
      image.src = v.url;
      let viewer = new Viewer(image, {
        hidden: function () {
          viewer.destroy();
        },
      });
      viewer.show();
    },
    showVideo(v) {
      this.dp = new DPlayer({
        container: document.getElementById("dplayer"),
        screenshot: true,
        video: {
          url: v.url,
        },
      });
      this.file = v;
      this.file.msize = this.util.getFileSize(v.size);
      this.videoTitle = v.title + "(" + v.fkey + ")";
      this.videoVisible = true;
    },
    closeVideo() {
      if (this.dp) {
        this.dp.destroy();
      }
    },
    changePage(v) {
      this.searchForm.pageNumber = v;
      this.getDataList();
      this.clearSelectAll();
    },
    changePageSize(v) {
      this.searchForm.pageSize = v;
      this.getDataList();
    },
    changeSort(e) {
      this.searchForm.sort = e.key;
      this.searchForm.order = e.order;
      if (e.order == "normal") {
        this.searchForm.order = "";
      }
      this.getDataList();
    },
    selectDateRange(v) {
      if (v) {
        this.searchForm.startDate = v[0];
        this.searchForm.endDate = v[1];
      }
    },
    changeShowType() {
      this.searchForm.pageNumber = 1;
      if (this.showType == "list") {
        this.searchForm.pageSize = 5;
      } else {
        this.searchForm.pageSize = 12;
      }
      this.getDataList();
    },
    getDataList() {
      if (this.showType == "list") {
        this.pageSizeOpts = [5, 10, 20];
      } else {
        this.pageSizeOpts = [12, 24];
      }
      this.loading = true;
      getUserFileListData(this.searchForm).then((res) => {
        this.loading = false;
        if (res.success) {
          this.data = res.result.content;
          this.total = res.result.totalElements;
          if (this.data.length == 0 && this.searchForm.pageNumber > 1) {
            this.searchForm.pageNumber -= 1;
            this.getDataList();
          }
        }
      });
    },
    handleSearch() {
      this.searchForm.pageNumber = 1;
      if (this.showType == "list") {
        this.searchForm.pageSize = 5;
      } else {
        this.searchForm.pageSize = 12;
      }
      this.getDataList();
    },
    changeFileType() {
      let name = this.fileType;
      if (name == "all") {
        this.searchForm.type = "";
      } else if (name == "pic") {
        this.searchForm.type = "image";
      } else if (name == "video") {
        this.searchForm.type = "video";
      } else if (name == "word") {
        this.searchForm.type = "word";
      } else if (name == "excel") {
        this.searchForm.type = "sheet";
      } else if (name == "ppt") {
        this.searchForm.type = "presentation";
      } else if (name == "pdf") {
        this.searchForm.type = "pdf";
      } else if (name == "audio") {
        this.searchForm.type = "audio";
      } else if (name == "text") {
        this.searchForm.type = "text";
      } else if (name == "zip") {
        this.searchForm.type = "zip";
      } else if (name == "rar") {
        this.searchForm.type = "rar";
      }
      this.handleSearch();
    },
    handleReset() {
      this.$refs.searchForm.resetFields();
      this.searchForm.pageNumber = 1;
      if (this.showType == "list") {
        this.searchForm.pageSize = 5;
      } else {
        this.searchForm.pageSize = 12;
      }
      this.selectDate = null;
      this.searchForm.startDate = "";
      this.searchForm.endDate = "";
      // 重新加载数据
      this.getDataList();
    },
    beforeUpload() {
      return true;
    },
    handleMaxSize(file) {
      this.$Notice.warning({
        title: "文件大小过大",
        desc: "所选文件‘ " + file.name + " ’大小过大, 不得超过 5M.",
      });
    },
    handleSuccess(res, file, fileList) {
      if (res.success) {
        this.$Message.success("上传文件 " + file.name + " 成功");
        this.getDataList();
      } else {
        file.percentage = 0;
        file.status = "fail";
        file.name += "（上传失败）";
        this.$Message.error(res.message);
      }
    },
    handleError(error, file, fileList) {
      this.$Message.error(error.toString());
    },
    clearFiles() {
      this.$refs.up.clearFiles();
    },
    handleCancel() {
      this.modalVisible = false;
    },
    download(v) {
      window.open(
        v.url +
          "?attname=&response-content-type=application/octet-stream&filename=" +
          v.title
      );
    },
    showOffice(v) {
      window.open("https://view.officeapps.live.com/op/view.aspx?src=" + v.url);
    },
    showFile(v) {
      window.open(v.url + "?preview=true");
    },
    previewFile(v) {
      if (v.type.indexOf("audio") >= 0) {
        this.showVideo(v);
      } else if (v.type.indexOf("office") >= 0 || v.type.indexOf("word") >= 0) {
        this.showOffice(v);
      } else if (
        v.type.indexOf("pdf") >= 0 ||
        v.type.indexOf("text") >= 0 ||
        v.type.indexOf("octet") >= 0
      ) {
        this.showFile(v);
      }
    },
    changeDropDown(row, v) {
      if (v == "rename") {
        this.rename(row);
      } else if (v == "copy") {
        this.copy(row);
      } else if (v == "remove") {
        this.remove(row);
      } else if (v == "move") {
        this.move(row);
      } else if (v == "share") {
        this.share(row);
      } else if (v == "collect") {
        this.collect(row);
      }
    },
    share(v) {
      this.$copyText(v.url).then((e) => {
        this.$Message.success("复制链接成功");
      });
    },
    selectMoveCategory(v) {
      this.moveCategoryId = v.id;
    },
    moveAll() {
      if (this.selectList.length <= 0) {
        this.$Message.warning("您还未选择要移动的文件");
        return;
      }
      let ids = "";
      this.selectList.forEach(function (e) {
        ids += e.id + ",";
      });
      ids = ids.substring(0, ids.length - 1);
      this.moveFileIds = ids;
      this.moveVisible = true;
    },
    move(v) {
      this.moveFileIds = [v.id];
      this.moveVisible = true;
    },
    handleSubmitMove() {
      this.submitLoading = true;
      moveFile({ ids: this.moveFileIds, categoryId: this.moveCategoryId }).then(
        (res) => {
          this.submitLoading = false;
          if (res.success) {
            this.$Message.success("操作成功");
            this.moveVisible = false;
            this.clearSelectAll();
            this.getDataList();
          }
        }
      );
    },
    copy(v) {
      this.$Modal.confirm({
        title: "确认复制",
        content: "您确认要复制文件 " + v.title + " ?",
        loading: true,
        onOk: () => {
          copyUserFile({ id: v.id, key: v.fkey }).then((res) => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("复制文件成功，新文件名为 副本_" + v.title);
              this.getDataList();
            }
          });
        },
      });
    },
    collect(v) {
      collectFile({ id: v.id }).then((res) => {
        this.$Modal.remove();
        if (res.success) {
          this.$Message.success(v.isCollect ? "取消收藏成功" : "收藏成功");
          this.getDataList();
        }
      });
    },
    removeAll() {
      if (this.selectList.length <= 0) {
        this.$Message.warning("您还未选择要删除的文件");
        return;
      }
      this.$Modal.confirm({
        title: "确认删除",
        content:
          "您确认要将所选的 " +
          this.selectList.length +
          " 个文件移入回收站， 7天内后自动彻底删除",
        loading: true,
        onOk: () => {
          let ids = "";
          this.selectList.forEach(function (e) {
            ids += e.id + ",";
          });
          ids = ids.substring(0, ids.length - 1);
          trashFile({ ids: ids }).then((res) => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("批量删除文件成功");
              this.clearSelectAll();
              this.getDataList();
            }
          });
        },
      });
    },
    remove(v) {
      this.$Modal.confirm({
        title: "确认删除",
        content:
          "您确认要将文件 " + v.title + " 移入回收站， 7天内后自动彻底删除",
        loading: true,
        onOk: () => {
          trashFile({ ids: v.id }).then((res) => {
            this.$Modal.remove();
            if (res.success) {
              this.clearSelectAll();
              this.$Message.success("删除文件 " + v.title + " 成功");
              this.getDataList();
            }
          });
        },
      });
    },
    handleSubmit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          this.submitLoading = true;
          let params = {
            id: this.form.id,
            newKey: this.form.fkey,
            newTitle: this.form.title,
          };
          renameUserFile(params).then((res) => {
            this.submitLoading = false;
            if (res.success) {
              this.$Message.success("操作成功");
              this.getDataList();
              this.modalVisible = false;
            }
          });
        }
      });
    },
    rename(v) {
      this.modalTitle = "编辑文件名";
      // 转换null为""
      for (let attr in v) {
        if (v[attr] == null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let data = JSON.parse(str);
      this.form = data;
      this.modalVisible = true;
    },
    clearSelectAll() {
      this.$refs.table.selectAll(false);
      this.totalSize = "";
    },
    changeSelect(e) {
      this.selectList = e;
      let size = 0;
      e.forEach((item) => {
        size += item.size * 1.0;
      });
      this.totalSize = this.util.getFileSize(size);
    },
  },
  mounted() {
    this.init();
  },
};
</script>