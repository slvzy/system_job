/************************************************************
** @Description: controllers
** @Author: george hao
** @Date:   2018-07-05 16:43
** @Last Modified by:  george hao
** @Last Modified time: 2018-07-05 16:43
*************************************************************/
package controllers

import (
	"system_job/models"
	"github.com/astaxie/beego"
	"strconv"

	"strings"
	"time"
)

type ConfigInfoController struct {
	BaseController
}

func (self *ConfigInfoController) List() {
	self.Data["pageTitle"] = "配置管理"
	self.Data["productGroup"] = productGroupLists()
	self.display()
}

func (self *ConfigInfoController) Add() {
	self.Data["pageTitle"] = "新增配置信息"
	self.Data["productGroup"] = productGroupLists()
	self.display()
}

func (self *ConfigInfoController) Edit() {
	self.Data["pageTitle"] = "编辑配置"
	id, _ := self.GetInt("id", 0)
	configInfo, _ := models.ConfigInfoGetById(id)
	row := make(map[string]interface{})
	row["id"] = configInfo.Id
	row["category_id"] = configInfo.CategoryId
	row["category_name"] = configInfo.CategoryName
	row["name"] = configInfo.Name
	row["value"] = configInfo.Value
	row["remark"] = configInfo.Remark
	self.Data["config"] = row
	self.Data["productGroup"] = productGroupLists()
	self.display()
}

func (self *ConfigInfoController) Table() {
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
	// 分类
	category := self.GetString("categoryId")
	if category != "" {
		filters = append(filters, "categoryId", category)
	}
	// 键
	name := self.GetString("name")
	if name != "" {
		filters = append(filters, "name__icontains", name)
	}
	// 值
	value := self.GetString("value")
	if value != "" {
		filters = append(filters, "value__icontains", value)
	}

	result, count := models.ConfigInfoGetList(page, self.pageSize, filters...)
	list := make([]map[string]interface{}, len(result))

	for k, v := range result {
		row := make(map[string]interface{})
		row["id"] = v.Id
		row["category_id"] = v.CategoryId
		row["category_name"] = v.CategoryName
		row["name"] = v.Name
		row["value"] = v.Value
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

func (self *ConfigInfoController) AjaxSave() {
	config_id, _ := self.GetInt("id")
	if config_id == 0 {
		config := new(models.ConfigInfo)
		categoryId, _ := self.GetInt("categoryId")
		if categoryId != 0 {
			configType, err := models.ConfigTypeGetById(categoryId)
			if err == nil {
				config.CategoryName = configType.Name
			}
		}
		config.CategoryId = categoryId
		config.Name = strings.TrimSpace(self.GetString("name"))
		config.Value = strings.TrimSpace(self.GetString("value"))
		config.Remark = strings.TrimSpace(self.GetString("remark"))
		config.CreateTime = time.Now().Unix()
		config.UpdateTime = time.Now().Unix()
		config.Status = 1
		config.CreateId = self.userId
		if _, err := models.ConfigInfoAdd(config); err != nil {
			self.ajaxMsg(err.Error(), MSG_ERR)
		}
		self.ajaxMsg("", MSG_OK)
	}

	config, _ := models.ConfigInfoGetById(config_id)
	//修改
	config.Id = config_id
	config.UpdateTime = time.Now().Unix()
	categoryId, _ := self.GetInt("categoryId")
	config.CategoryId = categoryId
	if categoryId != 0 {
		configType, err := models.ConfigTypeGetById(categoryId)
		if err == nil {
			config.CategoryName = configType.Name
		}
	}
	config.Name = strings.TrimSpace(self.GetString("name"))
	config.Value = strings.TrimSpace(self.GetString("value"))
	config.Remark = strings.TrimSpace(self.GetString("remark"))
	config.UpdateId = self.userId
	if err := config.Update(); err != nil {
		self.ajaxMsg(err.Error(), MSG_ERR)
	}
	self.ajaxMsg("", MSG_OK)
}

func (self *ConfigInfoController) AjaxTestServer() {
	server := new(models.ConfigInfo)
	categoryId, _ := self.GetInt("categoryId")
	server.CategoryName = strings.TrimSpace(self.GetString("categoryName"))
	server.CategoryId = categoryId
	server.Name = strings.TrimSpace(self.GetString("name"))
	server.Value = strings.TrimSpace(self.GetString("value"))
	server.Remark = strings.TrimSpace(self.GetString("remark"))
	self.ajaxMsg("测试添加成功", MSG_OK)
}

// 批量操作日志
func (self *ConfigInfoController) AjaxDel() {
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
		models.ConfigInfoDelById(id)
	}

	self.ajaxMsg("", MSG_OK)
}
