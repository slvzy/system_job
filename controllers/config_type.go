/************************************************************
** @Description: controllers
** @Author: sqw
** @Date:   2019-01-05 16:43
** @Last Modified by:  sqw
** @Last Modified time: 2019-01-05 16:43
*************************************************************/
package controllers

import (
	"system_job/models"
	"github.com/astaxie/beego"
	"strconv"

	"strings"
	"time"
)

type ConfigTypeController struct {
	BaseController
}

func (self *ConfigTypeController) List() {
	self.Data["pageTitle"] = "配置类别管理"
	self.display()
}

func (self *ConfigTypeController) Add() {
	self.Data["pageTitle"] = "新增配置类别"
	self.display()
}

func (self *ConfigTypeController) Edit() {
	self.Data["pageTitle"] = "编辑配置类别"
	id, _ := self.GetInt("id", 0)
	configType, _ := models.ConfigTypeGetById(id)
	row := make(map[string]interface{})
	row["id"] = configType.Id
	row["name"] = configType.Name
	row["code"] = configType.Code
	row["remark"] = configType.Remark
	self.Data["configType"] = row
	self.display()
}

// 查询列表
func (self *ConfigTypeController) Table() {
	//列表
	page, err := self.GetInt("page")
	if err != nil {
		page = 1
	}
	limit, err := self.GetInt("limit")
	if err != nil {
		limit = 30
	}

	self.pageSize = limit
	//查询条件
	filters := make([]interface{}, 0)

	TextStatus := []string{
		"<font color='red'><i class='fa fa-times-circle'></i>删除</font>",
		"<font color='green'><i class='fa fa-check-square'></i> 正常</font>",
	}
	// 状态
	Status, err := self.GetInt("status")
	if err == nil && Status != 9 {
		filters = append(filters, "status", Status)
	}
	// 键
	name := self.GetString("name")
	if name != "" {
		filters = append(filters, "name__icontains", name)
	}
	// 值
	value := self.GetString("code")
	if value != "" {
		filters = append(filters, "code__icontains", value)
	}

	result, count := models.ConfigTypeGetList(page, self.pageSize, filters...)
	list := make([]map[string]interface{}, len(result))

	for k, v := range result {
		row := make(map[string]interface{})
		row["id"] = v.Id
		row["name"] = v.Name
		row["code"] = v.Code
		row["remark"] = v.Remark
		row["create_time"] = beego.Date(time.Unix(v.CreateTime, 0), "Y-m-d H:i:s")
		row["create_id"] = v.CreateId
		index := v.Status
		if index > 2 {
			index = 2
		}
		row["status"] = TextStatus[index]
		list[k] = row
	}
	self.ajaxList("成功", MSG_OK, count, list)
}

// 增加
func (self *ConfigTypeController) AjaxSave() {
	config_id, _ := self.GetInt("id")
	if config_id == 0 {
		configType := new(models.ConfigType)
		configType.Name = strings.TrimSpace(self.GetString("name"))
		configType.Code = strings.TrimSpace(self.GetString("code"))
		configType.Remark = strings.TrimSpace(self.GetString("remark"))
		configType.CreateTime = time.Now().Unix()
		configType.UpdateTime = time.Now().Unix()
		configType.Status = 1
		configType.CreateId = self.userId
		if _, err := models.ConfigTypeAdd(configType); err != nil {
			self.ajaxMsg(err.Error(), MSG_ERR)
		}
		self.ajaxMsg("", MSG_OK)
	}

	configType, _ := models.ConfigTypeGetById(config_id)
	//修改
	configType.Id = config_id
	configType.UpdateTime = time.Now().Unix()
	configType.Name = strings.TrimSpace(self.GetString("name"))
	configType.Code = strings.TrimSpace(self.GetString("code"))
	configType.Remark = strings.TrimSpace(self.GetString("remark"))
	configType.UpdateId = self.userId
	if err := configType.Update(); err != nil {
		self.ajaxMsg(err.Error(), MSG_ERR)
	}
	self.ajaxMsg("", MSG_OK)
}

// 测试
func (self *ConfigTypeController) AjaxTestServer() {
	server := new(models.ConfigType)
	server.Name = strings.TrimSpace(self.GetString("name"))
	server.Code = strings.TrimSpace(self.GetString("value"))
	server.Remark = strings.TrimSpace(self.GetString("remark"))
	self.ajaxMsg("测试添加成功", MSG_OK)
}

// 批量操作日志
func (self *ConfigTypeController) AjaxDel() {
	ids := self.GetStrings("ids")
	idArr := strings.Split(ids[0], ",")

	if len(idArr) < 1 {
		self.ajaxMsg("请选择要操作的项目", MSG_ERR)
	}

	for _, v := range idArr {
		id, _ := strconv.Atoi(v)
		if id < 1 {
			continue
		}
		models.ConfigTypeDelById(id)
	}

	self.ajaxMsg("", MSG_OK)
}
