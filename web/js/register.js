/**
 * Created by zhuanggangqing on 2018/2/13.
 */
$(function () {
    $('#register-from').bootstrapValidator({
        message:'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields:{
            inputEmail3:{
                validators:{
                    notEmpty:{
                        message:'邮箱不能为空'
                    },
                    emailAddress:{
                        message:'邮箱地址格式有误'
                    }
                }
            },
            inputPassword3:{
                validators:{
                    notEmpty:{
                        message:'密码不能为空'
                    },
                    stringLength:{
                        min:3,
                        max:18,
                        message:'密码必须在3到18位之间'
                    },
                    regexp:{
                        regexp:/^[a-zA-Z0-9_]+$/,
                        message:'密码只能由数字字母下划线组成'
                    }
                }
            },
            inputPassword33:{
                validators:{
                    notEmpty:{
                        message:'密码不能为空'
                    }
                },
                identical:{
                    field:'inputPassword3',
                    message:'两次密码不一样'
                }
            }
        }
    })
});