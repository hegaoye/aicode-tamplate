此模板请与springboot-redis-swagger-lombok-fronted结合使用或者与springcloud-redis-lobmbok-sentry结合使用
# pps
${projectName} Production System
<H4>代码规范说明</H4>

1.严格遵守typescript代码开发规范，驼峰命名法 例如：   xxxXXX  xxx_xxxx  XXXDDDD

2.接口/类/枚举命名采用大驼峰命名：Xxxx

3.方法命名：操作类型+目标名+数据类型，并使用小驼峰式命名  例如：getGoodsList, modifyGoodsState

4.注释说明：</br>

方法注释范例 </br>

  /**
   * 修改材料状态(网络请求方法注释)
   * @param code 材料编码
   * @param state 材料状态 ('Enable' | 'Disable')
   * @returns {Promise<T>}
   */
  modifyMaterialState(code:string, state:string) {
       return new Promise(function (resolve, reject) {
         ......//具体请求方法
       }
  }

  /**
   * 添加材料品牌（方法调用注释）
   * 1.检测数据完整性和正确定，进行提示
   * 2.验证通过提交数据
   * 3.成功之后进行处理
   * 4.错误处理
   */
  addMaterialBrand() {
    //1.进行脏检查，提示未填的必填字段
    for (const key in this.validateForm.controls) {
      this.validateForm.controls[key].markAsDirty();
      this.validateForm.controls[key].updateValueAndValidity();
    }
    if (this.validateForm.invalid) return;
    // 2.表单验证通过之后提交
    this.materialService.addMaterialBrand(this.validateForm.value).then(data => {
      //3.添加成功要刷新第一页
      this.queryMaterailBrandList(1);
    }).catch(err => {
      //4.错误处理
    )
  }

	 注意注释中的1，2，3，4，5的代码实现步骤描述非常重要,并且代码编写过程中要把注释引入到方法体中按照步骤进行逐步实现,
	 同时注意@param的变量注释

5.凡是状态，变量影响到过程的，不能写死，需要统一声明，并注释清晰，进行分类管理。

6.公共样式分类写到公共文件中，保持项目整体风格一致
