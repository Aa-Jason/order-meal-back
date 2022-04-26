package cn.exrick.xboot.file.controller;

import cn.exrick.xboot.core.common.constant.OssConstant;
import cn.exrick.xboot.core.common.constant.SettingConstant;
import cn.exrick.xboot.core.common.exception.XbootException;
import cn.exrick.xboot.core.common.redis.RedisTemplateHelper;
import cn.exrick.xboot.core.common.utils.PageUtil;
import cn.exrick.xboot.core.common.utils.ResultUtil;
import cn.exrick.xboot.core.common.utils.SecurityUtil;
import cn.exrick.xboot.core.common.vo.PageVo;
import cn.exrick.xboot.core.common.vo.Result;
import cn.exrick.xboot.core.common.vo.SearchVo;
import cn.exrick.xboot.core.entity.User;
import cn.exrick.xboot.core.service.SettingService;
import cn.exrick.xboot.core.vo.OssSetting;
import cn.exrick.xboot.file.entity.File;
import cn.exrick.xboot.file.manage.FileManageFactory;
import cn.exrick.xboot.file.manage.impl.LocalFileManage;
import cn.exrick.xboot.file.service.FileService;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;


/**
 * @author Exrick
 */
@Slf4j
@RestController
@Api(tags = "文件管理管理接口")
@RequestMapping("/xboot/file")
@Transactional
public class FileController {

    @Autowired
    private FileService fileService;

    @RequestMapping(value = "/getByCondition", method = RequestMethod.GET)
    @ApiOperation(value = "多条件分页获取")
    public Result<Page<File>> getFileList(File file, SearchVo searchVo, PageVo pageVo) {

        Page<File> page = fileService.getFileList(file, searchVo, pageVo, false);
        return new ResultUtil<Page<File>>().setData(page);
    }

    @RequestMapping(value = "/rename", method = RequestMethod.POST)
    @ApiOperation(value = "文件重命名")
    public Result<Object> renameUserFile(@RequestParam String id,
                                         @RequestParam String newKey,
                                         @RequestParam String newTitle) {

        fileService.rename(id, newKey, newTitle, false);
        return ResultUtil.data(null);
    }

    @RequestMapping(value = "/copy", method = RequestMethod.POST)
    @ApiOperation(value = "文件复制")
    public Result<Object> copy(@RequestParam String id) {

        fileService.copy(id, false);
        return ResultUtil.data(null);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ApiOperation(value = "文件删除")
    public Result<Object> delete(@RequestParam String[] ids) {

        fileService.delete(ids, false);
        return ResultUtil.data(null);
    }
}
