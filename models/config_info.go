/*
* @Author: sqw
* @Date:   2019-04-21 12:23:22
* @Last Modified by:   sqw
* @Last Modified time: 2019-04-22 14:57:13
 */
package models

import (
	"github.com/astaxie/beego/orm"
)

type ConfigInfo struct {
	Id           int
	CategoryName string
	CategoryId   int
	Name         string
	Value        string
	Remark       string
	Status       int
	CreateId     int
	UpdateId     int
	UpdateTime   int64
	CreateTime   int64
}

func (t *ConfigInfo) TableName() string {
	return TableName("config_info")
}

// 更新
func (t *ConfigInfo) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(t, fields...); err != nil {
		return err
	}
	return nil
}

// 新增
func ConfigInfoAdd(t *ConfigInfo) (int64, error) {
	return orm.NewOrm().Insert(t)
}

func ConfigInfoGetList(page, pageSize int, filters ...interface{}) ([]*ConfigInfo, int64) {
	offset := (page - 1) * pageSize

	logs := make([]*ConfigInfo, 0)

	query := orm.NewOrm().QueryTable(TableName("config_info"))
	if len(filters) > 0 {
		l := len(filters)
		for k := 0; k < l; k += 2 {
			query = query.Filter(filters[k].(string), filters[k+1])
		}
	}

	total, _ := query.Count()
	query.OrderBy("-id").Limit(pageSize, offset).All(&logs)

	return logs, total
}

func ConfigInfoGetById(id int) (*ConfigInfo, error) {
	obj := &ConfigInfo{
		Id: id,
	}

	err := orm.NewOrm().Read(obj)
	if err != nil {
		return nil, err
	}
	return obj, nil
}

func ConfigInfoDelById(id int) error {
	_, err := orm.NewOrm().Delete(&ConfigInfo{Id: id})
	return err
}
