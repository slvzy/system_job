/************************************************************
** @Description: system_job
** @Author: sqw
** @Date:   2018-06-05 22:24
** @Last Modified by:   sqw
** @Last Modified time: 2018-06-05 22:24
*************************************************************/
package main

import (
	"github.com/astaxie/beego"
	"system_job/jobs"
	"system_job/models"
	_ "system_job/routers"
	"time"
)

func init() {
	//初始化数据模型
	var StartTime = time.Now().Unix()
	models.Init(StartTime)
	jobs.InitJobs()
}

func main() {
	beego.Run()
}
