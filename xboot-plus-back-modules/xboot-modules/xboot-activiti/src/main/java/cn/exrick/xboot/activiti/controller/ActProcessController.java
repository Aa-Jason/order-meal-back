package cn.exrick.xboot.activiti.controller;

import cn.exrick.xboot.activiti.controller.modeler.DefaultProcessDiagramGenerator;
import cn.exrick.xboot.activiti.entity.*;
import cn.exrick.xboot.activiti.properties.ActivitiExtendProperties;
import cn.exrick.xboot.activiti.service.*;
import cn.exrick.xboot.activiti.vo.ProcessNodeVo;
import cn.exrick.xboot.core.common.constant.ActivitiConstant;
import cn.exrick.xboot.core.common.exception.XbootException;
import cn.exrick.xboot.core.common.utils.PageUtil;
import cn.exrick.xboot.core.common.utils.ResultUtil;
import cn.exrick.xboot.core.common.utils.SecurityUtil;
import cn.exrick.xboot.core.common.vo.PageVo;
import cn.exrick.xboot.core.common.vo.Result;
import cn.exrick.xboot.core.common.vo.SearchVo;
import cn.exrick.xboot.core.entity.User;
import cn.exrick.xboot.core.entity.UserRole;
import cn.exrick.xboot.core.service.UserRoleService;
import cn.exrick.xboot.core.service.UserService;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.Process;
import org.activiti.bpmn.model.*;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.image.ProcessDiagramGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.util.*;

/**
 * @author Exrick
 */
@Slf4j
@RestController
@Api(tags = "????????????????????????")
@RequestMapping("/xboot/actProcess")
@Transactional
public class ActProcessController {

    @Autowired
    private ActivitiExtendProperties properties;

    @Autowired
    private ActModelService actModelService;

    @Autowired
    private ActProcessService actProcessService;

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private ActNodeService actNodeService;

    @Autowired
    private ActCategoryService actCategoryService;

    @Autowired
    private ActBusinessService actBusinessService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityUtil securityUtil;

    @RequestMapping(value = "/getByCondition", method = RequestMethod.GET)
    @ApiOperation(value = "?????????????????????????????????")
    public Result<Object> getByCondition(@ApiParam("????????????????????????") @RequestParam(required = false) Boolean showLatest,
                                         @ApiParam("???????????????????????????") @RequestParam(required = false, defaultValue = "false") Boolean filter,
                                         ActProcess actProcess,
                                         SearchVo searchVo,
                                         PageVo pageVo) {

        Page<ActProcess> page = actProcessService.findByCondition(showLatest, actProcess, searchVo, PageUtil.initPage(pageVo));
        // ???????????????
        if (!filter) {
            return ResultUtil.data(page);
        }
        // ????????????
        User user = securityUtil.getCurrUser();
        List<ActProcess> content = new ArrayList<>();
        for (ActProcess ap : page.getContent()) {
            // ?????????????????? ??????????????????????????????????????? ?????????????????????????????????????????????
            if (filter) {
                if (ap.getAllUser() != null && !ap.getAllUser()) {
                    // ??????
                    if (actNodeService.hasRecord(ap.getId(), user)) {
                        content.add(ap);
                    }
                } else {
                    content.add(ap);
                }
            }
        }
        Map<Object, Object> result = new HashMap<>(16);
        result.put("content", content);
        result.put("totalPages", page.getTotalPages());
        return ResultUtil.data(result);

    }

    @RequestMapping(value = "/getByKey/{key}", method = RequestMethod.GET)
    @ApiOperation(value = "??????key??????????????????")
    public Result<ActProcess> getByCondition(@PathVariable String key) {

        ActProcess actProcess = actProcessService.findByProcessKeyAndLatest(key, true);
        return new ResultUtil<ActProcess>().setData(actProcess);
    }

    @RequestMapping(value = "/updateInfo", method = RequestMethod.POST)
    @ApiOperation(value = "???????????????????????????????????????")
    public Result<Object> updateInfo(ActProcess actProcess) {

        ActProcess old = actProcessService.get(actProcess.getId());
        ProcessDefinition pd = repositoryService.getProcessDefinition(actProcess.getId());
        if (pd == null) {
            return ResultUtil.error("?????????????????????");
        }
        PageUtil.SQLInject(actProcess.getBusinessTable());
        repositoryService.setProcessDefinitionCategory(actProcess.getId(), actProcess.getCategoryId());
        repositoryService.setDeploymentCategory(pd.getDeploymentId(), actProcess.getCategoryId());
        old.setRouteName(actProcess.getRouteName());
        old.setBusinessTable(actProcess.getBusinessTable());
        old.setDescription(actProcess.getDescription());
        ActCategory c = actCategoryService.findById(actProcess.getCategoryId());
        if (c != null) {
            old.setCategoryId(actProcess.getCategoryId());
            old.setCategoryTitle(c.getTitle());
        }
        actProcessService.update(old);
        return ResultUtil.data("????????????");
    }

    @RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
    @ApiOperation(value = "???????????????????????????")
    public Result<Object> updateStatus(@ApiParam("????????????id") @RequestParam String id,
                                       @RequestParam Integer status) {

        if (ActivitiConstant.PROCESS_STATUS_ACTIVE.equals(status)) {
            repositoryService.activateProcessDefinitionById(id, true, new Date());
        } else if (ActivitiConstant.PROCESS_STATUS_SUSPEND.equals(status)) {
            repositoryService.suspendProcessDefinitionById(id, true, new Date());
        }

        ActProcess actProcess = actProcessService.get(id);
        actProcess.setStatus(status);
        actProcessService.update(actProcess);
        return ResultUtil.data("????????????");
    }

    @RequestMapping(value = "/export", method = RequestMethod.GET)
    @ApiOperation(value = "????????????????????????")
    public void exportResource(@ApiParam("????????????id") @RequestParam String id,
                               @ApiParam("0XML 1??????") @RequestParam Integer type,
                               HttpServletResponse response) {

        ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(id).singleResult();

        String resourceName;
        InputStream inputStream;
        if (ActivitiConstant.RESOURCE_TYPE_XML.equals(type)) {
            resourceName = pd.getResourceName();
            inputStream = repositoryService.getResourceAsStream(pd.getDeploymentId(), resourceName);
        } else if (ActivitiConstant.RESOURCE_TYPE_IMAGE.equals(type)) {
            resourceName = pd.getDiagramResourceName();
            BpmnModel bpmnModel = repositoryService.getBpmnModel(id);
            ProcessDiagramGenerator diagramGenerator = new DefaultProcessDiagramGenerator();
            inputStream = diagramGenerator.generateDiagram(bpmnModel, "png",
                    properties.getActivityFontName(), properties.getLabelFontName(), properties.getLabelFontName(), null, 1.0);
        } else {
            throw new XbootException("??????type?????????");
        }

        try {
            response.setContentType("application/octet-stream;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(resourceName, "UTF-8"));
            byte[] b = new byte[1024];
            int len = -1;
            while ((len = inputStream.read(b, 0, 1024)) != -1) {
                response.getOutputStream().write(b, 0, len);
            }
            response.flushBuffer();
        } catch (IOException e) {
            log.error(e.toString());
            throw new XbootException("??????????????????????????????");
        }
    }

    @RequestMapping(value = "/convertToModel/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "?????????????????????")
    public Result<Object> convertToModel(@ApiParam("????????????id") @PathVariable String id) {

        ProcessDefinition pd = repositoryService.createProcessDefinitionQuery().processDefinitionId(id).singleResult();
        InputStream bpmnStream = repositoryService.getResourceAsStream(pd.getDeploymentId(), pd.getResourceName());
        ActProcess actProcess = actProcessService.get(id);

        try {
            XMLInputFactory xif = XMLInputFactory.newInstance();
            // ??????XXE??????
            xif.setProperty(XMLInputFactory.IS_SUPPORTING_EXTERNAL_ENTITIES, Boolean.FALSE);
            xif.setProperty(XMLInputFactory.SUPPORT_DTD, Boolean.FALSE);

            InputStreamReader in = new InputStreamReader(bpmnStream, "UTF-8");
            XMLStreamReader xtr = xif.createXMLStreamReader(in);
            BpmnModel bpmnModel = new BpmnXMLConverter().convertToBpmnModel(xtr);
            BpmnJsonConverter converter = new BpmnJsonConverter();

            ObjectNode modelNode = converter.convertToJson(bpmnModel);
            Model modelData = repositoryService.newModel();
            modelData.setKey(pd.getKey());
            modelData.setName(pd.getResourceName());

            ObjectNode modelObjectNode = new ObjectMapper().createObjectNode();
            modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, actProcess.getName());
            modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, modelData.getVersion());
            modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, actProcess.getDescription());
            modelData.setMetaInfo(modelObjectNode.toString());

            repositoryService.saveModel(modelData);
            repositoryService.addModelEditorSource(modelData.getId(), modelNode.toString().getBytes("utf-8"));

            // ??????????????????????????????
            ActModel actModel = new ActModel();
            actModel.setId(modelData.getId());
            actModel.setName(modelData.getName());
            actModel.setModelKey(modelData.getKey());
            actModel.setDescription(actProcess.getDescription());
            actModel.setVersion(modelData.getVersion());
            actModelService.save(actModel);
        } catch (Exception e) {
            log.error(e.toString());
            return ResultUtil.error("???????????????????????????");
        }
        return ResultUtil.data("????????????");
    }

    @RequestMapping(value = "/getProcessNode/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "??????????????????id??????????????????")
    public Result<List<ProcessNodeVo>> getProcessNode(@ApiParam("????????????id") @PathVariable String id) {

        BpmnModel bpmnModel = repositoryService.getBpmnModel(id);

        List<ProcessNodeVo> list = new ArrayList<>();

        List<Process> processes = bpmnModel.getProcesses();
        if (processes == null || processes.isEmpty()) {
            return new ResultUtil<List<ProcessNodeVo>>().setData(null);
        }
        for (Process process : processes) {
            Collection<FlowElement> elements = process.getFlowElements();
            for (FlowElement element : elements) {
                ProcessNodeVo node = new ProcessNodeVo();
                node.setId(element.getId());
                node.setTitle(element.getName());
                if (element instanceof StartEvent) {
                    // ????????????
                    node.setType(ActivitiConstant.NODE_TYPE_START);
                    // ??????????????????
                    node.setUsers(actNodeService.findUserByNodeId(id));
                    // ??????????????????
                    node.setRoles(actNodeService.findRoleByNodeId(id));
                    // ??????????????????
                    node.setDepartments(actNodeService.findDepartmentByNodeId(id));
                } else if (element instanceof UserTask) {
                    // ????????????
                    node.setType(ActivitiConstant.NODE_TYPE_TASK);
                    // ??????????????????
                    node.setUsers(actNodeService.findUserByNodeId(element.getId()));
                    // ??????????????????
                    node.setRoles(actNodeService.findRoleByNodeId(element.getId()));
                    // ??????????????????
                    node.setDepartments(actNodeService.findDepartmentByNodeId(element.getId()));
                    // ??????????????????????????????
                    node.setChooseDepHeader(actNodeService.hasChooseDepHeader(element.getId()));
                    // ??????????????????????????????
                    node.setCustomUser(actNodeService.hasCustomUser(element.getId()));
                } else if (element instanceof EndEvent) {
                    // ??????
                    node.setType(ActivitiConstant.NODE_TYPE_END);
                } else {
                    // ???????????????????????????
                    continue;
                }
                list.add(node);
            }
        }
        return new ResultUtil<List<ProcessNodeVo>>().setData(list);
    }

    @RequestMapping(value = "/editStartUser", method = RequestMethod.POST)
    @ApiOperation(value = "???????????????????????????")
    public Result<Object> editStartUser(@ApiParam("????????????id") @RequestParam String nodeId,
                                        @ApiParam("????????????????????????") @RequestParam Boolean allUser,
                                        @RequestParam(required = false) String[] userIds,
                                        @RequestParam(required = false) String[] roleIds,
                                        @RequestParam(required = false) String[] departmentIds) {

        // ?????????????????????
        actNodeService.deleteByNodeId(nodeId);
        ActProcess actProcess = actProcessService.get(nodeId);
        actProcess.setAllUser(allUser);
        actProcessService.update(actProcess);
        if (!allUser) {
            List<ActNode> listNode = new ArrayList<>();
            // ???????????????
            if (userIds != null) {
                for (String userId : userIds) {
                    // ????????????
                    ActNode actNode = new ActNode().setNodeId(nodeId).setRelateId(userId).setType(ActivitiConstant.NODE_USER);
                    listNode.add(actNode);
                }
            }
            // ????????????????????????
            if (roleIds != null) {
                for (String roleId : roleIds) {
                    ActNode actNode = new ActNode().setNodeId(nodeId).setRelateId(roleId).setType(ActivitiConstant.NODE_ROLE);
                    listNode.add(actNode);
                }
            }
            // ???????????????
            if (departmentIds != null) {
                for (String departmentId : departmentIds) {
                    ActNode actNode = new ActNode().setNodeId(nodeId).setRelateId(departmentId).setType(ActivitiConstant.NODE_DEPARTMENT);
                    listNode.add(actNode);
                }
            }
            // ????????????
            actNodeService.saveOrUpdateAll(listNode);
        }
        return ResultUtil.success("????????????");
    }

    @RequestMapping(value = "/editNodeUser", method = RequestMethod.POST)
    @ApiOperation(value = "????????????????????????")
    public Result<Object> editNodeUser(@RequestParam String nodeId,
                                       @RequestParam(required = false) String[] userIds,
                                       @RequestParam(required = false) String[] roleIds,
                                       @RequestParam(required = false) String[] departmentIds,
                                       @ApiParam("??????????????????????????????????????????") @RequestParam(required = false) Boolean chooseDepHeader,
                                       @ApiParam("????????????????????????") @RequestParam(required = false) Boolean customUser) {

        // ?????????????????????
        actNodeService.deleteByNodeId(nodeId);
        if (customUser != null && customUser) {
            ActNode actNode = new ActNode().setNodeId(nodeId).setType(ActivitiConstant.NODE_CUSTOM);
            actNodeService.save(actNode);
            return ResultUtil.success("????????????");
        }
        List<ActNode> list = new ArrayList<>();
        // ???????????????
        if (userIds != null) {
            for (String userId : userIds) {
                ActNode actNode = new ActNode().setNodeId(nodeId).setRelateId(userId).setType(ActivitiConstant.NODE_USER);
                list.add(actNode);
            }
        }
        // ???????????????
        if (roleIds != null) {
            for (String roleId : roleIds) {
                ActNode actNode = new ActNode().setNodeId(nodeId).setRelateId(roleId).setType(ActivitiConstant.NODE_ROLE);
                list.add(actNode);
            }
        }
        // ???????????????
        if (departmentIds != null) {
            for (String departmentId : departmentIds) {
                ActNode actNode = new ActNode().setNodeId(nodeId).setRelateId(departmentId).setType(ActivitiConstant.NODE_DEPARTMENT);
                list.add(actNode);
            }
        }
        if (chooseDepHeader != null && chooseDepHeader) {
            ActNode actNode = new ActNode().setNodeId(nodeId).setType(ActivitiConstant.NODE_DEP_HEADER);
            list.add(actNode);
        }
        // ????????????
        actNodeService.saveOrUpdateAll(list);
        return ResultUtil.success("????????????");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "??????id????????????")
    public Result<Object> delByIds(@RequestParam String[] ids) {

        for (String id : ids) {
            if (CollectionUtil.isNotEmpty(actBusinessService.findByProcDefId(id))) {
                return ResultUtil.error("?????????????????????????????????????????????");
            }
            ActProcess actProcess = actProcessService.get(id);
            // ?????????????????????????????? ??????????????????
            if (actProcess.getVersion() == 1) {
                deleteNodeUsers(id);
            }
            // ????????????
            repositoryService.deleteDeployment(actProcess.getDeploymentId(), true);
            actProcessService.delete(id);
            // ??????????????????
            actProcessService.setLatestByProcessKey(actProcess.getProcessKey());
        }
        return ResultUtil.data("????????????");
    }

    public void deleteNodeUsers(String processId) {

        BpmnModel bpmnModel = repositoryService.getBpmnModel(processId);
        List<Process> processes = bpmnModel.getProcesses();
        for (Process process : processes) {
            Collection<FlowElement> elements = process.getFlowElements();
            for (FlowElement element : elements) {
                actNodeService.deleteByNodeId(element.getId());
            }
        }
    }
}