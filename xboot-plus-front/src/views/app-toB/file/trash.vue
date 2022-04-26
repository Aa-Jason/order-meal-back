<style lang="less">
@import "@/styles/single-common.less";
</style>
<template>
  <div>
    <Card>
      <div slot="title">
        <div class="edit-head">
          <a @click="close" class="back-title">
            <Icon type="ios-arrow-back" />返回
          </a>
          <div class="head-name">回收站</div>
          <span></span>
          <a @click="close" class="window-close">
            <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
          </a>
        </div>
      </div>
      <Row class="operation" align="middle" justify="space-between">
        <div class="br">
          <Button @click="clear" type="error" icon="md-trash"
            >清空回收站</Button
          >
          <Input
            v-model="searchForm.title"
            suffix="ios-search"
            @on-change="getDataList"
            placeholder="输入文件名搜索"
            clearable
            style="width: 250px"
          />
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
        </div>
      </Row>
      <Alert show-icon v-show="openTip">
        已选择
        <span class="select-count">{{ selectList.length }}</span> 项
        <a class="select-clear" @click="clearSelectAll">清空</a>
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
      <Row type="flex" justify="end" class="page">
        <Page
          :current="searchForm.pageNumber"
          :total="total"
          :page-size="searchForm.pageSize"
          @on-change="changePage"
          size="small"
          show-total
          show-elevator
        ></Page>
      </Row>
    </Card>
  </div>
</template>

<script>
import {
  getFileCate,
  getUserFileListData,
  trashFileCate,
  trashFile,
  deleteUserFile,
  clearTrashFile,
  deleteFileCate,
  clearTrashFileCate,
} from "@/api/index";
import { vi } from "date-fns/locale";
export default {
  name: "trash",
  data() {
    return {
      loading: false,
      openTip: true,
      selectList: [],
      searchForm: {
        // 搜索框对应data对象
        title: "",
        pageNumber: 1, // 当前页数
        pageSize: 10, // 页面大小
        sort: "updateTime", // 默认排序字段
        order: "desc", // 默认排序方式
        delFlag: 2,
      },
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
            return h(
              "div",
              {
                style: {
                  display: "flex",
                  "align-items": "center",
                },
              },
              [
                h("img", {
                  attrs: {
                    src: this.getFileIcon(params.row),
                  },
                  style: {
                    width: "30px",
                    height: "40px",
                    margin: "0 10px 0 0",
                    "object-fit": "contain",
                  },
                }),
                h("span", params.row.title),
              ]
            );
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
            if (!params.row.isFolder) {
              let m = this.util.getFileSize(params.row.size);
              return h("span", m);
            }
          },
        },
        {
          title: "创建时间",
          key: "createTime",
          width: 180,
          sortable: true,
        },
        {
          title: "更新时间",
          key: "createTime",
          width: 180,
          sortable: true,
          sortType: "desc",
        },
        {
          title: "剩余时间",
          key: "restDelTime",
          width: 150,
          sortable: true,
          align: "center",
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
                      this.revert(params.row);
                    },
                  },
                },
                "恢复"
              ),
              h("Divider", {
                props: {
                  type: "vertical",
                },
              }),
              h(
                "a",
                {
                  on: {
                    click: () => {
                      this.delete(params.row);
                    },
                  },
                },
                "彻底删除"
              ),
            ]);
          },
        },
      ],
      data: [], // 表单数据
      total: 0, // 表单数据总数
    };
  },
  methods: {
    init() {
      this.getDataList();
    },
    getDataList() {
      this.loading = true;
      getFileCate(this.searchForm).then((res) => {
        if (res.success) {
          res.result.forEach((e) => {
            e.isFolder = true;
            e.type = "文件夹";
          });
          this.data = res.result;
          let totalElements = res.result.length;
          getUserFileListData(this.searchForm).then((res) => {
            this.loading = false;
            if (res.success) {
              this.data = this.data.concat(res.result.content);
              this.total = totalElements + res.result.totalElements;
              if (this.data.length == 0 && this.searchForm.pageNumber > 1) {
                this.searchForm.pageNumber -= 1;
                this.getDataList();
              }
            }
          });
        } else {
          this.loading = false;
        }
      });
    },
    getFileIcon(v) {
      if (!v) {
        return "";
      }
      if (v.isFolder) {
        return require("@/assets/icon/folder.png");
      }
      let url = "";
      if (!v.type) {
        url = require("@/assets/icon/file-unknown.png");
      } else if (v.type.indexOf("image") >= 0) {
        url = v.url;
      } else if (v.type.indexOf("video") >= 0) {
        url = require("@/assets/icon/file-video.png");
      } else if (v.type.indexOf("audio") >= 0) {
        url = require("@/assets/icon/mp3.png");
      } else if (v.type.indexOf("pdf") >= 0) {
        url = require("@/assets/icon/pdf.png");
      } else if (v.type.indexOf("word") >= 0) {
        url = require("@/assets/icon/word.png");
      } else if (
        v.type.indexOf("sheet") >= 0 ||
        v.fkey.indexOf(".xlsx") >= 0 ||
        v.fkey.indexOf(".xls") >= 0
      ) {
        url = require("@/assets/icon/xls.png");
      } else if (v.type.indexOf("presentation") >= 0) {
        url = require("@/assets/icon/ppt.png");
      } else if (
        v.type.indexOf("zip") >= 0 ||
        v.type.indexOf("rar") >= 0 ||
        v.type.indexOf("7z") >= 0
      ) {
        url = require("@/assets/icon/zip.png");
      } else if (v.type.indexOf("text") >= 0 || v.type.indexOf("octet") >= 0) {
        url = require("@/assets/icon/file.png");
      } else {
        url = require("@/assets/icon/file.png");
      }
      return url;
    },
    clearSelectAll() {
      this.$refs.table.selectAll(false);
    },
    changePage(v) {
      this.searchForm.pageNumber = v;
      this.getDataList();
      this.clearSelectAll();
    },
    changeSort(e) {
      this.searchForm.sort = e.key;
      this.searchForm.order = e.order;
      if (e.order == "normal") {
        this.searchForm.order = "";
      }
      this.getDataList();
    },
    clear() {
      this.$Modal.confirm({
        title: "请谨慎进行此操作！",
        content: "确认彻底清空回收站所有文件？",
        loading: true,
        onOk: () => {
          clearTrashFile().then((res) => {
            if (res.success) {
              clearTrashFileCate().then((res) => {
                this.$Modal.remove();
                if (res.success) {
                  this.getDataList();
                  this.$Message.success("清空回收站成功");
                }
              });
            }
          });
        },
      });
    },
    revert(v) {
      if (!v.isFolder) {
        trashFile({ ids: v.id }).then((res) => {
          if (res.success) {
            this.getDataList();
            this.$Message.success("操作成功");
          }
        });
      } else {
        trashFileCate({ id: v.id }).then((res) => {
          if (res.success) {
            this.getDataList();
            this.$Message.success("操作成功");
          }
        });
      }
    },
    delete(v) {
      this.$Modal.confirm({
        title: "确认彻底删除",
        content: v.isFolder
          ? "确定彻底删除文件夹 " + v.title
          : "确定彻底删除文件 " + v.title,
        loading: true,
        onOk: () => {
          if (!v.isFolder) {
            deleteUserFile({ ids: v.id }).then((res) => {
              this.$Modal.remove();
              if (res.success) {
                this.getDataList();
                this.$Message.success("删除文件 " + v.title + " 成功");
              }
            });
          } else {
            deleteFileCate({ ids: v.id }).then((res) => {
              this.$Modal.remove();
              if (res.success) {
                this.getDataList();
                this.$Message.success("删除文件夹 " + v.title + " 成功");
              }
            });
          }
        },
      });
    },
    close() {
      this.$emit("close", true);
    },
    submited() {
      this.$emit("submited", true);
    },
  },
  mounted() {
    this.init();
  },
};
</script>