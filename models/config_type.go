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

type ConfigType struct {
	Id         int
	Name       string
	Code       string
	Remark     string
	Status     int
	CreateId   int
	UpdateId   int
	UpdateTime int64
	CreateTime int64
}

func (t *ConfigType) TableName() string {
	return TableName("config_type")
}

// 更新
func (t *ConfigType) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(t, fields...); err != nil {
		return err
	}
	return nil
}

// 新增
func ConfigTypeAdd(t *ConfigType) (int64, error) {
	return orm.NewOrm().Insert(t)
}

func ConfigTypeGetList(page, pageSize int, filters ...interface{}) ([]*ConfigType, int64) {
	offset := (page - 1) * pageSize

	logs := make([]*ConfigType, 0)

	query := orm.NewOrm().QueryTable(TableName("config_type"))
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

func ConfigTypeGetById(id int) (*ConfigType, error) {
	obj := &ConfigType{
		Id: id,
	}

	err := orm.NewOrm().Read(obj)
	if err != nil {
		return nil, err
	}
	return obj, nil
}

func ConfigTypeDelById(id int) error {
	_, err := orm.NewOrm().Delete(&ConfigType{Id: id})
	return err
}
