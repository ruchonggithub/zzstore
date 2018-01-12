<?php
 
namespace app\admin\controller;

 
use cmf\controller\AdminBaseController;
 
use think\Db;

 
 
class ConfigController extends AdminBaseController
{
    
    public function _initialize()
    {
        parent::_initialize();
        
    }
     
    /**
     * 网站配置
     * @adminMenu(
     *     'name'   => '网站配置',
     *     'parent' => '',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 15,
     *     'icon'   => '',
     *     'remark' => '网站配置',
     *     'param'  => ''
     * )
     */
    public function index()
    { 
        $info=[
            'zztitle'=>config('zztitle'),
            'units'=>implode('-',config('units')),
        ];
        $this->assign('info',$info);
        
        return $this->fetch();
    }
    
    /**
     * 网站配置编辑1
     * @adminMenu(
     *     'name'   => '网站配置编辑1',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '网站配置编辑1',
     *     'param'  => ''
     * )
     */
    function editPost(){
       
        $data= $this->request->param();
        $info=[
            'zztitle'=>$data['zztitle'],
            'units'=>explode('-',$data['units']),
        ];
        $result=cmf_set_dynamic_config($info);
        if(empty($result)){
            $this->error('修改失败');
           
        }else{
            $data_action=[
                'aid'=>session('ADMIN_ID'),
                'time'=>time(),
                'type'=>'config',
                'ip'=>get_client_ip(),
                'action'=>'编辑网站配置',
            ];
            Db::name('action')->insert($data_action);
            $this->success('修改成功',url('index'));
        }
        
    }
     
     
}
