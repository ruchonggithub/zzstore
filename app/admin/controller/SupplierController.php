<?php
 
namespace app\admin\controller;

 
use cmf\controller\AdminBaseController;
 
use think\Db;

 
 
class SupplierController extends AdminBaseController
{
    private $m;
    private $order;
    private $statuss;
    public function _initialize()
    {
        parent::_initialize();
        $this->m=Db::name('supplier');
        $this->order='sort asc,id asc';
        $this->statuss=config('suplier_status');
        $this->assign('flag','供货商');
        $this->assign('statuss', $this->statuss);
    }
     
    /**
     * 供货商
     * @adminMenu(
     *     'name'   => '供货商管理',
     *     'parent' => 'admin/GoodsStore/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 0,
     *     'icon'   => '',
     *     'remark' => '供货商管理',
     *     'param'  => ''
     * )
     */
    public function index()
    { 
        $m=$this->m;
        $list= $m->order($this->order)->paginate(10);
       
        // 获取分页显示
        $page = $list->render(); 
        $this->assign('page',$page);
        $this->assign('list',$list); 
        return $this->fetch();
    }
    /**
     * 供货商编辑
     * @adminMenu(
     *     'name'   => '供货商编辑',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '供货商编辑',
     *     'param'  => ''
     * )
     */
    function edit(){
        $m=$this->m;
        $id=$this->request->param('id');
        $info=$m->where('id',$id)->find();
         
        $info['picss']=empty($info['pics'])?'':explode(';', $info['pics']);
        $this->assign('info',$info); 
      
        return $this->fetch();
    }
    /**
     * 供货商编辑1
     * @adminMenu(
     *     'name'   => '供货商编辑1',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '供货商编辑1',
     *     'param'  => ''
     * )
     */
    function editPost(){
        $m=$this->m;
        $data= $this->request->param();
        if(empty($data['id'])){
            $this->error('数据错误');
        } 
        $tmp='';
        if(!empty($data['photos'])){
            foreach($data['photos'] as $v){
                $tmp.=';'.$v;
            }
            $data['pics']=substr($tmp, 1);
        }
        unset($data['photos']);
        $data['time']=time();
        $row=$m->where('id', $data['id'])->update($data);
        if($row===1){
            $data_action=[
                'aid'=>session('ADMIN_ID'),
                'time'=>time(),
                'type'=>'supplier',
                'ip'=>get_client_ip(),
                'action'=>'编辑工作人员id-'.$data['id'].'-name-'.$data['name'],
            ];
            Db::name('action')->insert($data_action);
            $size = config('suplier_pic');
            $data['pic'] = zz_set_image($data['pic'], $data['pic'], $size['width'], $size['height'], 6);
            
            $this->success('修改成功',url('index'));
        }else{
            $this->error('修改失败');
        }
        
    }
    /**
     * 供货商删除
     * @adminMenu(
     *     'name'   => '供货商删除',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '供货商删除',
     *     'param'  => ''
     * )
     */
    function delete(){
        $m=$this->m;
        $id = $this->request->param('id', 0, 'intval');
        $info=$m->where('id',$id)->find();
        $row=$m->where('id',$id)->delete();
        if($row===1){
            $data_action=[
                'aid'=>session('ADMIN_ID'),
                'time'=>time(),
                'type'=>'supplier',
                'ip'=>get_client_ip(),
                'action'=>'删除供货商id-'.$info['id'].'-name-'.$info['name'],
            ];
            Db::name('action')->insert($data_action);
            $this->success('删除成功');
        }else{
            $this->error('删除失败');
        }
        exit;
    }
    
    /**
     * 供货商添加
     * @adminMenu(
     *     'name'   => '供货商添加',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '供货商添加',
     *     'param'  => ''
     * )
     */
    public function add(){
        
        return $this->fetch();
    }
    
    /**
     * 供货商添加1
     * @adminMenu(
     *     'name'   => '供货商添加1',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '供货商添加1',
     *     'param'  => ''
     * )
     */
    public function addPost(){
        
        $m=$this->m;
        $data= $this->request->param();
        $tmp='';
        if(!empty($data['photos'])){ 
            foreach($data['photos'] as $v){
                $tmp.=';'.$v;
            } 
            $data['pics']=substr($tmp, 1);
        }
        unset($data['photos']);
        $data['insert_time']=time();
        $data['time']= $data['insert_time'];
        $row=$m->insertGetId($data);
        if($row>=1){
            $size = config('suplier_pic');
            $data['pic'] = zz_set_image($data['pic'], $data['pic'], $size['width'], $size['height'], 6);
            
            $this->success('已成功添加',url('index'));
        }else{
            $this->error('添加失败');
        }
        exit;
    }
    /**
     * 供货商排序
     * @adminMenu(
     *     'name'   => '供货商排序',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '供货商排序',
     *     'param'  => ''
     * )
     */
    public function sort()
    {
        parent::sorts(Db::name('supplier'));
        $this->success("排序更新成功！", '');
    }
}
