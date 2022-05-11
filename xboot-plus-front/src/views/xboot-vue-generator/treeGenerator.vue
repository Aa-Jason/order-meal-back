<template>
  <div class="search">
    <Card>
      <Row v-show="true" @keydown.enter.native="handleSearch">
        <Form ref="searchForm" :model="searchForm" inline :label-width="70">
         <FormItem label="查询时间">
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
          <FormItem label="查询部门" prop="departmentTitle">
            <Select
              v-model="searchForm.departmentTitle"
              placeholder="请选择"
              clearable
              style="width: 200px"
            >
              <Option v-for="(dep,index) in department" :key="index":value="dep">{{dep}}</Option>
              
            </Select>
          </FormItem>
          <FormItem label="查询姓名" prop="nickname">
            <Input
              type="text"
              v-model="searchForm.nickname"
              placeholder="请输入"
              clearable
              style="width: 200px"
            />
          </FormItem>
          
         
          <FormItem style="margin-left: -35px" class="br">
            <Button @click="handleSearch" type="primary" icon="ios-search"
              >搜索</Button
            >
            <Button @click="handleReset">重置</Button>
          </FormItem>
        </Form>
      </Row>
      <Row align="middle" justify="space-between" class="operation">
        
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
          <Tooltip content="表格密度" placement="top" transfer>
            <Dropdown @on-click="changeTableSize" trigger="click">
              <Icon type="md-list" size="18" class="item" />
              <DropdownMenu slot="list">
                <DropdownItem :selected="tableSize == 'default'" name="default"
                  >默认</DropdownItem
                >
                <DropdownItem :selected="tableSize == 'large'" name="large"
                  >宽松</DropdownItem
                >
                <DropdownItem :selected="tableSize == 'small'" name="small"
                  >紧密</DropdownItem
                >
              </DropdownMenu>
            </Dropdown>
          </Tooltip>
          <Tooltip content="导出数据" placement="top" transfer>
            <Icon
              type="md-download"
              size="18"
              class="item"
              @click="exportData"
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
        :size="tableSize"
        sortable="custom"
        @on-sort-change="changeSort"
        @on-selection-change="showSelect"
        ref="table"
      ></Table>
      <Row type="flex" justify="end" class="page">
        <Page
          
          :total="total"
          
          show-total
          
        ></Page>
      </Row>
    </Card>

    
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { getCountMealList,getDepartment} from "@/api/count";
// 根据你的实际添加编辑组件位置路径修改
import addEdit from "./editAdd.vue";
import { shortcuts } from "@/libs/shortcuts";
export default {
  name: "countMeal",
  components: {
    addEdit,
  },
  data() {
    return {
      tableSize: "default",
      openTip: true, // 显示提示
      showType: "0", // 添加或编辑标识
      showDrawer: false, // 显示添加编辑抽屉
      loading: true, // 表单加载状态
      searchForm: {
        // 搜索框对应data对象
        nickname: "",
        departmentTitle: "",
        startDate: "", // 起始时间
        endDate: "", // 终止时间
      },
      searchForm1:{
        pageNumber: 1, // 当前页数
        pageSize: 10, // 页面大小
        sort: "createTime", // 默认排序字段
        order: "desc", // 默认排序方式
      },
      selectList: [], // 多选数据
      form: {},
      columns: [
      // 表头
      {
        type: "selection",
        width: 60,
        align: "center"
      },
      {
        type: "index",
        width: 60,
        align: "center"
      },
      {
        title: "日期",
        key: "date",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "早餐",
        key: "breakfast",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "午餐",
        key: "lunch",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "晚餐",
        key: "dinner",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "操作",
        key: "action",
        align: "center",
        width: 150,
        render: (h, params) => {
          return h("div", [
            h(
              "a",
              {
                on: {
                  click: () => {
                    this.edit(params.row);
                  }
                }
              },
              "编辑"
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
                    this.remove(params.row);
                  }
                }
              },
              "删除"
            )
          ]);
        }
      }
    ],
      data: [], // 表单数据
      pageNumber: 1, // 当前页数
      pageSize: 10, // 页面大小
      total: 0 ,// 表单数据总数
      department:[]
    };
  },
  
  methods: {
    init() {
      
      this.getDepartmentList();
    },
    getDepartmentList(){
      getDepartment().then(res => {
        console.log(res)
          if (res.success) {
            
            this.department = res.result
            
          }
        });
    },
    handleSearch() {
      this.searchForm1.pageNumber = 1;
      this.searchForm.pageSize = 10;
      this.getDataList();
    },
    selectDateRange(v) {
      if (v) {
        this.searchForm.startDate = v[0];
        this.searchForm.endDate = v[1];
      }
    },
    changePage(v) {
      this.searchForm1.pageNumber = v;
      this.getDataList();
      this.clearSelectAll();
    },
    changePageSize(v) {
      this.searchForm.pageSize = v;
      this.getDataList();
    },
    handleReset() {
      this.$refs.searchForm.resetFields();
      this.searchForm1.pageNumber = 1;
      this.searchForm.pageSize = 10;
      // 重新加载数据
      this.getDataList();
    },
    changeSort(e) {
      this.searchForm.sort = e.key;
      this.searchForm.order = e.order;
      if (e.order === "normal") {
        this.searchForm.order = "";
      }
      this.getDataList();
    },
    clearSelectAll() {
      this.$refs.table.selectAll(false);
    },
    changeSelect(e) {
      this.selectList = e;
    },
    changeTableSize(v) {
      this.tableSize = v;
    },
    exportData() {
      this.$refs.table.exportCsv({
        filename: "数据",
      });
    },
    getDataList() {
      this.loading = true;
        getCountMealList(this.searchForm).then(res => {
          this.loading = false;
          console.log(res)
          if (res.success) {
            for(let i=0;i<res.result.length;i++){
              if(res.result[i].date !== null){
                this.data.push(res.result[i])
              }
            }

            this.total = this.data.length;
            if (this.data.length == 0 && this.searchForm1.pageNumber > 1) {
              this.searchForm1.pageNumber -= 1;
              this.getDataList();
            }
          }
        });
    },
    add() {
      this.showType = "2";
      this.showDrawer = true;
    },
    edit(v) {
      // 转换null为""
      for (let attr in v) {
        if (v[attr] == null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let data = JSON.parse(str);
      this.form = data;
      this.showType = "1";
      this.showDrawer = true;
    },
    remove(v) {
      this.$Modal.confirm({
        title: "确认删除",
        // 记得确认修改此处
        content: "您确认要删除该条数据?",
        loading: true,
        onOk: () => {
          // 删除
            deleteCountMeal({ids: v.id}).then(res => {
              this.$Modal.remove();
              if (res.success) {
                this.$Message.success("操作成功");
                this.clearSelectAll();
                this.getDataList();
              }
            });
        }
      });
    },
    delAll() {
      if (this.selectList.length <= 0) {
        this.$Message.warning("您还未选择要删除的数据");
        return;
      }
      this.$Modal.confirm({
        title: "确认删除",
        content: "您确认要删除所选的 " + this.selectList.length + " 条数据?",
        loading: true,
        onOk: () => {
          let ids = "";
          this.selectList.forEach(function(e) {
            ids += e.id + ",";
          });
          ids = ids.substring(0, ids.length - 1);
          // 批量删除
            deleteCountMeal({ids: ids}).then(res => {
              this.$Modal.remove();
              if (res.success) {
                this.$Message.success("操作成功");
                this.clearSelectAll();
                this.getDataList();
              }
            });
        }
      });
    }
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
@import "@/styles/table-common.less";
</style>