<?php
 
namespace app\admin\controller;

 
use cmf\controller\AdminBaseController;
 
use think\Db;

 
 
class WorkerController extends AdminBaseController
{
    private $m;
    private $order;
    private $statuss;
    private $types;
    public function _initialize()
    {
        parent::_initialize();
        $this->m=Db::name('worker');
        $this->order='sort asc,id asc';
        $this->statuss=config('suplier_status');
        $this->types=config('worker_types');
        $this->assign('flag','员工');
        $this->assign('statuss', $this->statuss);
        $this->assign('types',  $this->types);
    }
     
    /**
     * 员工
     * @adminMenu(
     *     'name'   => '员工管理',
     *     'parent' => 'admin/GoodsStore/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 0,
     *     'icon'   => '',
     *     'remark' => '员工管理',
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
     * 员工编辑
     * @adminMenu(
     *     'name'   => '员工编辑',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '员工编辑',
     *     'param'  => ''
     * )
     */
    function edit(){
        $m=$this->m;
        $id=$this->request->param('id');
        $info=$m->where('id',$id)->find();
        
        $this->assign('info',$info);
        
        
        //不同类别到不同的页面
        return $this->fetch();
    }
    /**
     * 员工编辑1
     * @adminMenu(
     *     'name'   => '员工编辑1',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '员工编辑1',
     *     'param'  => ''
     * )
     */
    function editPost(){
        $m=$this->m;
        $data= $this->request->param();
        if(empty($data['id'])){
            $this->error('数据错误');
        } 
        $data['time']=time();
        $row=$m->where('id', $data['id'])->update($data);
        if($row===1){
            $data_action=[
                'aid'=>session('ADMIN_ID'),
                'time'=>time(),
                'type'=>'worker',
                'ip'=>get_client_ip(),
                'action'=>'编辑工作人员id-'.$data['id'].'-name-'.$data['name'],
            ];
            Db::name('action')->insert($data_action);
            $this->success('修改成功',url('index'));
        }else{
            $this->error('修改失败');
        }
        
    }
    /**
     * 员工删除
     * @adminMenu(
     *     'name'   => '员工删除',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '员工删除',
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
                'type'=>'worker',
                'ip'=>get_client_ip(),
                'action'=>'删除工作人员-id'.$info['id'].'-name-'.$info['name'],
            ];
            Db::name('action')->insert($data_action);
            $this->success('删除成功');
        }else{
            $this->error('删除失败');
        }
        exit;
    }
    
    /**
     * 员工添加
     * @adminMenu(
     *     'name'   => '员工添加',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '员工添加',
     *     'param'  => ''
     * )
     */
    public function add(){
        
        return $this->fetch();
    }
    
    /**
     * 员工添加1
     * @adminMenu(
     *     'name'   => '员工添加1',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '员工添加1',
     *     'param'  => ''
     * )
     */
    public function addPost(){
        
        $m=$this->m;
        $data= $this->request->param();
        $data['insert_time']=time();
        $data['time']= $data['insert_time'];
        $row=$m->insertGetId($data);
        if($row>=1){
            $this->success('已成功添加',url('index'));
        }else{
            $this->error('添加失败');
        }
        exit;
    }
    /**
     * 员工排序
     * @adminMenu(
     *     'name'   => '员工排序',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '员工排序',
     *     'param'  => ''
     * )
     */
    public function sort()
    {
        parent::sorts(Db::name('worker'));
        $this->success("排序更新成功！", '');
    }
}
