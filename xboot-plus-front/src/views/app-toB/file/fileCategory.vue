<template>
  <div>
    <Row class="operation" v-if="!showOnly">
      <Button @click="add" type="primary" icon="md-add">添加文件夹</Button>
      <Dropdown @on-click="handleTreeDropdown">
        <Button>
          更多操作
          <Icon type="md-arrow-dropdown" />
        </Button>
        <DropdownMenu slot="list">
          <DropdownItem
            name="edit"
            :disabled="selectNode.id == 0 || selectNode.id == -1"
            >编辑文件夹</DropdownItem
          >
          <DropdownItem
            name="del"
            :disabled="selectNode.id == 0 || selectNode.id == -1"
            >删除文件夹</DropdownItem
          >
          <DropdownItem name="refresh">刷新</DropdownItem>
        </DropdownMenu>
      </Dropdown>
    </Row>
    <Alert show-icon v-if="!showOnly">
      当前选择：
      <span class="select-title">{{ editTitle }}</span>
      <a
        class="select-clear"
        v-if="editTitle && selectNode.id != '0'"
        @click="cancelEdit"
        >取消选择</a
      >
    </Alert>
    <Input
      v-model="searchKey"
      suffix="ios-search"
      @on-change="search"
      placeholder="输入搜索文件夹名称"
      clearable
    />
    <div style="position: relative">
      <div class="tree-bar" :style="{ maxHeight: maxHeight }">
        <Tree
          ref="tree"
          :data="data"
          :load-data="loadData"
          :render="renderContent"
          @on-check-change="changeSelect"
          @on-select-change="selectTree"
        ></Tree>
      </div>
      <Spin size="large" fix v-if="loading"></Spin>
    </div>

    <Modal
      :title="modalTitle"
      v-model="modalVisible"
      :mask-closable="false"
      :width="500"
    >
      <Form ref="form" :model="form" :label-width="85" :rules="formValidate">
        <FormItem label="上级节点："
          >{{ form.parentTitle }}
          <Tooltip
            :content="
              selectNode.id == '0'
                ? '若需添加子目录，请先点击选择一个文件夹'
                : '若需添加一级目录，请先取消选择当前文目录'
            "
            placement="right"
            transfer
            max-width="290"
            style="display: inline-block !important"
          >
            <Icon
              type="md-help-circle"
              size="20"
              color="#c5c5c5"
              style="margin-left: 10px; cursor: pointer"
            />
          </Tooltip>
        </FormItem>
        <FormItem label="文件夹名" prop="title">
          <Input v-model="form.title" />
        </FormItem>
        <FormItem label="排序值" prop="sortOrder">
          <Tooltip
            trigger="hover"
            placement="right"
            content="值越小越靠前，支持小数"
          >
            <InputNumber
              :max="1000"
              :min="0"
              v-model="form.sortOrder"
            ></InputNumber>
          </Tooltip>
        </FormItem>
      </Form>
      <div slot="footer">
        <Button type="text" @click="modalVisible = false">取消</Button>
        <Button type="primary" :loading="submitLoading" @click="handelSubmit"
          >提交</Button
        >
      </div>
    </Modal>
  </div>
</template>

<script>
import {
  getFileCate,
  addFileCate,
  editFileCate,
  trashFileCate,
  searchFileCate,
} from "@/api/index";
export default {
  name: "fileCategory",
  props: {
    showOnly: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      loading: false, // 树加载状态
      maxHeight: "500px",
      searchKey: "", // 搜索树
      selectNode: {},
      selectList: [], // 多选数据
      modalVisible: false,
      modalTitle: "",
      editTitle: "",
      submitLoading: false,
      form: {
        title: "",
        sortOrder: 0,
        parentId: 0,
      },
      formValidate: {
        // 表单验证规则
        title: [{ required: true, message: "不能为空", trigger: "blur" }],
        sortOrder: [
          {
            required: true,
            type: "number",
            message: "排序值不能为空",
            trigger: "change",
          },
        ],
      },
      data: [],
      editData: {},
    };
  },
  methods: {
    init() {
      this.getParentList();
      this.editTitle = "未归档";
      this.selectNode = {
        id: "0",
        title: "未归档",
      };
      this.$emit("on-select", this.selectNode);
    },
    renderContent(h, { root, node, data }) {
      let icon = "md-folder-open";
      if (data.id == "0") {
        icon = "md-pricetags";
      } else if (data.id == "-1") {
        icon = "md-star-outline";
      }
      return h("span", [
        h(
          "span",

          [
            h("Icon", {
              props: {
                type: icon,
                size: 16,
              },
              style: {
                "margin-right": "8px",
              },
            }),
            h("span", data.title),
          ]
        ),
      ]);
    },
    getParentList() {
      this.loading = true;
      let param = {
        parentId: 0,
        delFlag: 0,
      };
      getFileCate(param).then((res) => {
        this.loading = false;
        if (res.success) {
          res.result.forEach(function (e) {
            if (e.isParent) {
              e.loading = false;
              e.children = [];
              e._loading = false;
            }
          });
          this.data = res.result;
          this.data.unshift(
            {
              id: "0",
              title: "未归档",
              selected: true,
            },
            {
              id: "-1",
              title: "收藏夹",
              selected: false,
            }
          );
        }
      });
    },
    loadData(item, callback) {
      let param = {
        parentId: item.id,
        delFlag: 0,
      };
      getFileCate(param).then((res) => {
        if (res.success) {
          res.result.forEach(function (e) {
            if (e.isParent) {
              e.loading = false;
              e.children = [];
              e._loading = false;
            }
          });
          callback(res.result);
        }
      });
    },
    search() {
      // 搜索树
      if (this.searchKey) {
        this.loading = true;
        searchFileCate({ title: this.searchKey }).then((res) => {
          this.loading = false;
          if (res.success) {
            this.data = res.result;
          }
        });
      } else {
        // 为空重新加载
        this.getParentList();
      }
    },
    selectTree(v) {
      if (v.length > 0) {
        this.$refs.form.resetFields();
        // 转换null为""
        for (let attr in v[0]) {
          if (v[0][attr] == null) {
            v[0][attr] = "";
          }
        }
        let str = JSON.stringify(v[0]);
        let data = JSON.parse(str);
        this.selectNode = data;
        this.form = data;
        this.editData = data;
        this.editTitle = data.title;
        this.$emit("on-select", this.selectNode);
      } else {
        this.cancelEdit();
      }
    },
    cancelEdit() {
      if (this.selectNode.id == "0") {
        this.data[0].selected = true;
        return;
      }
      let data = this.$refs.tree.getSelectedNodes()[0];
      if (data) {
        data.selected = false;
      }
      this.$refs.form.resetFields();
      this.editData = {};
      // 取消选择后获取全部数据
      this.selectNode = {
        id: "0",
        title: "未归档",
      };
      this.editTitle = "未归档";
      this.data[0].selected = true;
      this.$emit("on-select", this.selectNode);
    },
    changeSelect(v) {
      this.selectList = v;
    },
    handleTreeDropdown(name) {
      if (name == "edit") {
        this.edit();
      } else if (name == "del") {
        this.del();
      } else if (name == "refresh") {
        this.init();
      }
    },
    add() {
      this.modalType = 0;
      if (this.selectNode.id == "0" || this.selectNode.id == "-1") {
        // 一级目录
        this.modalTitle = "添加一级文件夹";
        this.form = {
          parentId: "0",
          parentTitle: "一级目录",
          sortOrder: this.data.length + 1,
        };
      } else {
        // 子目录
        this.modalTitle = "添加子文件夹";
        if (!this.form.children) {
          this.form.children = [];
        }
        this.form = {
          parentId: this.selectNode.id,
          parentTitle: this.selectNode.title,
          sortOrder: this.form.children.length + 1,
        };
      }
      this.modalVisible = true;
    },
    edit() {
      if (this.selectNode.id == "0" || this.selectNode.id == "-1") {
        this.$Message.warning("您还未选择要编辑的文件夹");
        return;
      }
      if (this.editData) {
        this.form = this.editData;
      }
      this.modalType = 1;
      this.modalTitle = "编辑文件夹";
      this.modalVisible = true;
    },
    handelSubmit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          this.submitLoading = true;
          if (this.modalType == 0) {
            // 添加 避免编辑后传入id等数据 记得删除
            delete this.form.id;
            addFileCate(this.form).then((res) => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.getParentList();
                this.modalVisible = false;
              }
            });
          } else if (this.modalType == 1) {
            // 编辑
            editFileCate(this.form).then((res) => {
              this.submitLoading = false;
              if (res.success) {
                this.editTitle = this.form.title;
                this.$Message.success("操作成功");
                this.getParentList();
                this.modalVisible = false;
              }
            });
          }
        }
      });
    },
    del() {
      if (this.selectNode.id == "0" || this.selectNode.id == "-1") {
        this.$Message.warning("您还未选择要删除的文件夹");
        return;
      }
      this.$Modal.confirm({
        title: "确认删除",
        loading: true,
        content:
          "您确认要将文件夹 " +
          this.selectNode.title +
          " 及其所有文件移入回收站， 7天内后自动彻底删除",
        onOk: () => {
          // 删除
          trashFileCate({ id: this.selectNode.id }).then((res) => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("操作成功");
              this.init();
            }
          });
        },
      });
    },
  },
  mounted() {
    // 计算高度
    let height = document.documentElement.clientHeight;
    this.maxHeight = Number(height - 287) + "px";
    this.init();
  },
};
</script>

<style lang="less">
</style>

