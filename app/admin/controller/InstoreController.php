<?php
 
namespace app\admin\controller;

 
use cmf\controller\AdminBaseController;
use app\admin\model\CateModel;
use think\Db;
use app\admin\model\GoodsAttrModel;
use app\admin\model\InstoreModel;
use PHPExcel_IOFactory;
use PHPExcel;
use PHPExcel_Cell_DataType;
use PHPExcel_Style_Border;
/**
 * Class InstoreController
 * @package app\admin\controller
 * @adminMenuRoot(
 *     'name'   => '产品入库',
 *     'action' => 'default',
 *     'parent' => '',
 *     'display'=> true,
 *     'order'  => 10,
 *     'icon'   => '',
 *     'remark' => '产品入库'
 * )
 */
class InstoreController extends AdminBaseController
{
    private $m;
    private $m1;
    private $order;
    
    public function _initialize()
    {
        parent::_initialize();
        $this->order='oid desc';
        $this->m=Db::name('instore');
        $this->m1=Db::name('instore_info');
        $this->assign('flag','产品入库');
    }
    /**
     * 产品入库记录
     * @adminMenu(
     *     'name'   => '产品入库记录',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 11,
     *     'icon'   => '',
     *     'remark' => '产品入库记录',
     *     'param'  => ''
     * )
     */
    public function index()
    {
        
        $m=$this->m;
        $where=[];
        $data=$this->request->param();
        if(empty($data['search_name'])){
            $data['name']='';
            $data['type']='';
        }else{
            $data['name']=trim($data['search_name']);
            $data['type']=trim($data['search_type']);
            switch($data['type']){
                case 'oid': $where['oid']=['like','%'.$data['name'].'%'];break;
                case 'gid':$where['gid']=['eq',$data['name']];break;
                case 'sn':$where['gsn']=['eq',$data['name']];break;
                case 'cid':$where['cid']=['eq',$data['name']];break;
                case 'cname':$where['cname']=['like','%'.$data['name'].'%'];break;
                case 'gname':$where['gname']=['like','%'.$data['name'].'%'];break;
                default:
                    $data['name']='';
                    $data['type']='';
                    break;
            }
        }
        //分类获取
        if(empty($data['cid'])){
            $data['cid']=0;
        }else{
            $cates=Db::name('cate')->where('path','like','%-'.$data['cid'].'-%')->select();
            $cids=[$data['cid']];
            foreach($cates as $v){
                $cids[]=$v['id'];
            }
            $where['cid']=['in',$cids];
        }
       
        $list= $m->where($where)->order($this->order)->paginate(10);
        // 获取分页显示
        $page = $list->render();
        
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree($data['cid']);
        
       
        $this->assign('cates_tree',$catesTree);
        $this->assign('page',$page);
        $this->assign('list',$list);
         
        $this->assign('name',$data['name']); 
        $this->assign('type',$data['type']);
        return $this->fetch();
    }
    /**
     * 产品入库单
     * @adminMenu(
     *     'name'   => '产品入库单',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品入库单',
     *     'param'  => ''
     * )
     */
    public function instores()
    {
        
        $m=$this->m1;
        $where=[];
        $data=$this->request->param();
        if(empty($data['oid'])){
            $data['oid']=''; 
        }else{
            $where['oid']=['like','%'.$data['oid'].'%'];
        }
        if(empty($data['supplier'])){
            $data['supplier']=0;
        }else{
            $where['seller_id']=['eq', $data['supplier']];
        }
        if(empty($data['store'])){
            $data['store']=0;
        }else{
            $where['store_id']=['eq', $data['store']];
        }
        if(empty($data['worker'])){
            $data['worker']=0;
        }else{
            $where['buyer_id']=['eq', $data['worker']];
        }
        if(empty($data['status'])){
            $data['status']=0;
        }else{
            $where['status']=['eq', $data['status']-1];
        }
        $list= $m->where($where)->order($this->order)->paginate(10);
        // 获取分页显示
        $page = $list->render();
        
        //得到供货商，仓库和购货员
        $order='status desc,sort asc,id asc';
        $suppliers=Db::name('supplier')->order($order)->select();
        $stores=Db::name('store')->order($order)->select();
        $where_worker=[
            'type'=>['in',[1,3]]
        ];
        $workers=Db::name('worker')->where($where_worker)->order($order)->select();
        
        $this->assign('page',$page);
        $this->assign('list',$list);
        
        $this->assign('data',$data);
        $this->assign('statuss',config('store_status'));
       
        $this->assign('suppliers',$suppliers);
        $this->assign('stores',$stores);
        $this->assign('workers',$workers);
      
        return $this->fetch();
    }
    
    /**
     * 添加产品入库
     * @adminMenu(
     *     'name'   => '添加产品入库',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '添加产品入库',
     *     'param'  => ''
     * )
     */
    public function add()
    {
       
        
        //得到分类
        $parentId            = $this->request->param('parent', 0, 'intval');
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree($parentId); 
        $this->assign('cates_tree', $catesTree);
        //所有商品
        $model= new GoodsAttrModel();
        $goods=$model->attr_all();
        foreach($goods as $k=>$v){
            $tmp=explode('-', $v['path']);
            $pathes='';
            foreach ($tmp as $vv){
                $pathes.=' goods'.$vv;
            }
            $goods[$k]['pathes']=$pathes;
        }
        //得到供货商，仓库和购货员
        $order='sort asc,id asc';
        $suppliers=Db::name('supplier')->where('status',1)->order($order)->select();
        $stores=Db::name('store')->where('status',1)->order($order)->select();
        $where_worker=[
           'status'=>['eq',1],
           'type'=>['in',[1,3]]
        ];
        $workers=Db::name('worker')->where($where_worker)->order($order)->select();
        
        //得到入库单号,当月的次序
        $date=getdate();
        
        $date0=$date['year'].'-'.$date['mon'];
        $time0=strtotime($date0);
         
        $m1=$this->m1;
        $count=$m1->where('insert_time','egt',$time0)->count();
        $oid=$date0.'-'.($count+1);
        
        $this->assign('oid', $oid);
        $this->assign('goods', $goods);
        $this->assign('suppliers', $suppliers);
        $this->assign('stores', $stores);
        $this->assign('workers', $workers);
        
       
        return $this->fetch();
    }
    /**
     * 添加产品入库记录
     * @adminMenu(
     *     'name'   => '添加产品入库记录',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '添加产品入库记录',
     *     'param'  => ''
     * )
     */
    public function instore_add()
    {
        
        $data=$this->request->param();
        //不能修改已提交的入库单s
        $m1=$this->m1;
        $instore_info=$m1->where('oid',$data['oid'])->find();
        if(empty($instore_info)){
            $this->error('此单号信息已不存在');
        }
        if($instore_info['status']!==0){
            $this->error('不能修改已提交的入库单'.$instore_info['status']);
        }
        if($instore_info['aid0']!=session('ADMIN_ID')){
            $this->error('不能编辑他人的入库单号');
        } 
        $model= new GoodsAttrModel();
        $goods=$model->attr($data['id']);
 
        $m=$this->m;
        $data_add=[
            'oid'=>$data['oid'],
            'time'=>time(),
            'cid'=>$goods['cid'],
            'cname'=>$goods['cname'],
            'gid'=>$goods['gid'],
            'gaid'=>$goods['id'],
            'gname'=>$goods['gname'],
            'gsn'=>$goods['sn'],
            'gsn0'=>$goods['sn0'],
            'ganame'=>$goods['attr'],
            'unit'=>$goods['unit'],
            'inprice0'=>$goods['inprice'],
            'num'=>$data['num'],
            'inprice'=>$data['price'],
            'dsc'=>$data['dsc'],
            'cprice'=>bcmul($data['num'],$data['price'],2),
        ]; 
        // 启动事务
        Db::startTrans();
        try{
            //入库
            $id=$m->insertGetId($data_add);
            if($id>0){
                
                $data_add['id']=$id;
                //更新入库单
                $instore_model=new InstoreModel();
                $data_info=$instore_model->update_info($data['oid']);
                //更新失败
                if(empty($data_info)){
                    throw \Exception();
                } 
            }else{
                throw \Exception();
            }
            
            Db::commit();
        }catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error('添加失败');
        }
        $data_add['ccount']=$data_info['count'];
        $data_add['ccprice']=$data_info['cprice'];
        $data_add['cnum']=$data_info['num'];
        $data_action=[
            'aid'=>$instore_info['aid0'],
            'time'=>time(),
            'type'=>'instore',
            'ip'=>get_client_ip(),
            'action'=>'对入库单'.$instore_info['oid'].'添加了产品'.$data_add['gname'].'-'.$data_add['ganame'],
        ];
        Db::name('action')->insert($data_action);
        $this->success('已添加',null,$data_add,1);
        exit;
    }
    /**
     * 删除产品入库记录
     * @adminMenu(
     *     'name'   => '删除产品入库记录',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '删除产品入库记录',
     *     'param'  => ''
     * )
     */
    public function instore_delete()
    {
        //  // success($msg = '', $url = null, $data = '', $wait = 3, array $header = [])
        
        $id=$this->request->param('id',0,'intval');
       
        //先根据得到入库单号和入库状态
        $m=$this->m;
        $info=$m->where('id',$id)->find();
        if(empty($info)){
            $this->error('该记录不存在，请刷新');
        }
        //不能修改已提交的入库单
        $m1=$this->m1;
        $instore_info=$m1->where('oid',$info['oid'])->find();
        if(empty($instore_info)){
            $this->error('此单号信息已不存在');
        }
        if($instore_info['status']!==0){
            $this->error('不能修改已提交的入库单');
        }
        if($instore_info['aid0']!=session('ADMIN_ID')){
            $this->error('不能编辑他人的入库单号');
        } 
        // 启动事务
        Db::startTrans();
        try{
            $row=$m->where('id',$id)->delete();
            if($row!==1){
                throw \Exception();
            }
            //更新入库单
            $instore_model=new InstoreModel();
            $data_info=$instore_model->update_info($info['oid']);
            if(empty($data_info)){
                throw \Exception(); 
            }
            Db::commit();
        }catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error('删除失败');
        }
        $data_action=[
            'aid'=>$instore_info['aid0'],
            'time'=>time(),
            'type'=>'instore',
            'ip'=>get_client_ip(),
            'action'=>'对入库单'.$instore_info['oid'].'删除了产品'.$info['gname'].'-'.$info['ganame'],
        ];
        Db::name('action')->insert($data_action);
        $this->success('已删除',null,$data_info,1);
    }   
    
    /**
     * 添加产品入库提交
     * @adminMenu(
     *     'name'   => '添加产品入库提交',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '添加产品入库提交',
     *     'param'  => ''
     * )
     */
    public function addPost()
    {
         
       $data = $this->request->param(); 
       $data_info=[
           'insert_time'=>time(),
           'time'=>time(),
           'status'=>0,
           'aid0'=>session('ADMIN_ID'),
           'aname0'=>$data['uname'],
           'cdsc'=>$data['cdsc'],
           'oid'=>$data['oid'],
           'freight'=>$data['freight'],
           'is_freight'=>$data['is_freight']
          
       ]; 
        try{
            $tmp=explode('-', $data['store']);
            $data_info['store_id']=$tmp[0];
            $data_info['store_name']=$tmp[1];
            $tmp=explode('-', $data['supplier']);
            $data_info['seller_id']=$tmp[0];
            $data_info['seller_name']=$tmp[1];
            $tmp=explode('-', $data['worker']);
            $data_info['buyer_id']=$tmp[0];
            $data_info['buyer_name']=$tmp[1];
          
            //更新入库单
            $m1=$this->m1;
            $insert=$m1->insertGetId($data_info);
            if($insert<1){
                throw \Exception();
            }
        }catch (\Exception $e) {
          
            $this->error('保存失败');
        } 
        $data_action=[
            'aid'=>$data_info['aid0'],
            'time'=>time(),
            'type'=>'instore',
            'ip'=>get_client_ip(),
            'action'=>'添加了入库单'.$data_info['oid']
        ];
        Db::name('action')->insert($data_action);
        $this->success('添加成功!',url('edit',['id'=>$insert]));

    }

    /**
     * 编辑产品入库
     * @adminMenu(
     *     'name'   => '编辑产品入库',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '编辑产品入库',
     *     'param'  => ''
     * )
     */
    public function edit()
    {
        //得到入库单信息
        $data=$this->request->param();
        
        $m1=$this->m1;
        if(empty($data['id'])){
            $where=['oid'=>$data['oid']];
        }else{
            $where=['id'=>$data['id']];
        }
        $info=$m1->where($where)->find();
        if(empty($info)){
            $this->error('此单号信息已不存在');
        }
        
        //得到分类 
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree();
        $this->assign('cates_tree', $catesTree);
        //所有商品
        $model= new GoodsAttrModel();
        $goods=$model->attr_all();
        foreach($goods as $k=>$v){
            $tmp=explode('-', $v['path']);
            $pathes='';
            foreach ($tmp as $vv){
                $pathes.=' goods'.$vv;
            }
            $goods[$k]['pathes']=$pathes;
        }
          
        //list入库记录
        $m=$this->m;
        $list=$m->where('oid',$info['oid'])->select();
        $this->assign('info', $info);
        $this->assign('goods', $goods);
        
        $this->assign('list', $list);
        $this->assign('statuss',config('store_status'));
        return $this->fetch();

    }

    /**
     * 编辑产品入库提交
     * @adminMenu(
     *     'name'   => '编辑产品入库提交',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '编辑产品入库提交',
     *     'param'  => ''
     * )
     */
    public function editPost()
    {
      
        $data = $this->request->param();
        
        $m1=$this->m1;
        $info=$m1->where('id',$data['id'])->find();
        if(empty($info)){
            $this->error('此单号信息已不存在');
        }
        if($info['status']>1){
            $this->error('不能编辑已审核的单号');
        }
        //审核
        if($data['status']>1){
            if($info['status']==0){
                $this->error('不能审核未提交的入库');
            }else{
                $this->redirect(url('review',$data));
            }
        }elseif($info['aid0']!=session('ADMIN_ID')){
            $this->error('不能编辑他人的入库单号');
        } 
       
        $data_info=[
            'time'=>time(),
            'status'=>$data['status'], 
            'cdsc'=>$data['cdsc'], 
        ];
        if($data['status']==1){
            if($info['status']!=0){ 
                $this->error('不能编辑已提交的单号，请先改为未提交'); 
            }
            $action='提交了入库单';
            $data_info['cdsc']=$data['cdsc'];
            $data_info['cdsc']=$data['cdsc'];
            //本站支付运费则产品售价-运费
            $data_info['cprice1']=($info['is_freight']==0)?$info['cprice']:(bcsub($info['cprice'],$info['freight'],2));
        }else{
            if($info['status']==1){
                $action='把已提交的入库单改为未提交';
            }else{
                $action='保存了未提交的入库单';
            }
        }
        //更新入库单 
        $row=$m1->where('id',$data['id'])->update($data_info);
        if($row!==1){
            $this->error('保存失败');
        }
        $data_action=[
            'aid'=>$info['aid0'],
            'time'=>time(),
            'type'=>'instore',
            'ip'=>get_client_ip(),
            'action'=>'对入库单'.$info['oid'].'编辑保存，'.$action,
        ];
        Db::name('action')->insert($data_action);
        $this->success('保存成功!',url('instores'));
    }
    /**
     * 审核产品入库 
     * @adminMenu(
     *     'name'   => '审核产品入库 ',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '审核产品入库 ',
     *     'param'  => ''
     * )
     */
    public function review(){
       
        $data = $this->request->param();
        $data['rdsc']=(empty($data['rdsc']))?'':$data['rdsc'];
     
        $m1=$this->m1;
        $info=$m1->where('id',$data['id'])->find();
        if(empty($info)){
            $this->error('此单号信息已不存在');
        }
        if($info['status']!=1){
            $this->error('只能审核已提交且未审核的单号');
        }
        //审核
        if( $data['status']<2){
            $this->error('不能审核');
        } 
       
        $admin0=Db::name('user')->where('id',$info['aid0'])->find();
        $mail=[
            'to'=>$admin0['user_email'],
            'subject'=>'入库审核通知',
            'content'=>'审核人'.$data['uname'].'审核了你的入库单'.$info['oid'].'，决定',
        ];
        switch($data['status']){
            case 2:$status_info='审核通过';break;
            case 3:$status_info='审核不通过';break;
            case 4:$status_info='暂不审核';break;
            default:$this->error('审核信息错误'); 
        }
        $mail['content'].=$status_info;
        $time=time();
        $data_info=[
            'time'=>$time, 
            'aname1'=>$data['uname'],
            'aid1'=>session('ADMIN_ID'),
            'rdsc'=>$data['rdsc'],
        ];
        $data_action=[
            'aid'=>$data_info['aid1'],
            'time'=>$time,
            'type'=>'instore',
            'ip'=>get_client_ip(),
            'action'=>'对入库单'.$info['oid'].'审核，结果为'.$status_info,
        ];
       
        //如果是暂不审核就只记录审核人和备注，不改变状态
        if($data['status']==4){
            $row=$m1->where('id',$data['id'])->update($data_info);
            if($row===1){
                cmf_send_email($mail['to'], $mail['subject'], $mail['content']); 
                Db::name('action')->insert($data_action);
                $this->success('保存成功!','instores');
            }else{
                $this->error('保存失败');
            }
        }
        $data_info['status']=$data['status'];
        // 启动事务
        Db::startTrans();
        $row=$m1->where('id',$data['id'])->update($data_info);
        
        //审核不通过则结束
        if($data['status']==3){
            Db::commit();
            cmf_send_email($mail['to'], $mail['subject'], $mail['content']);
            Db::name('action')->insert($data_action);
            $this->success('保存成功!','instores');
        }
        try{
            if($row!==1){
                throw \Exception('审核更新错误');
            } 
            //审核完成更新库存
            $m=$this->m;
            $list=$m->where('oid',$info['oid'])->select();
            $m_store=Db::name('goods_store');
            foreach($list as $k=>$v){  
                $where=[ 
                    'store'=>$info['store_id'],
                    'goods'=>$v['gaid'],
                ]; 
                $data_info=[
                    'time'=>time(), 
                ];
                //有记录则更新时间和数量，没有则添加
                $row=$m_store->where($where)->data($data_info)->setInc('num', $v['num']);
               
                if($row===0){ 
                    $data_info['store']=$where['store'];
                    $data_info['goods']=$where['goods'];
                    $data_info['num']=$v['num'];
                    $insert=$m_store->insertGetId($data_info);
                    if($insert<=0){ 
                        throw \Exception('库存添加错误');
                    }
                }elseif($row!==1){ 
                    throw \Exception('库存更新错误');
                }
            }
            Db::commit();
        }catch (\Exception $e) {
            Db::rollback();
            //echo 'Message: ' .$e->getMessage();
            $this->error('保存失败!'.$e->getMessage());
        }
        cmf_send_email($mail['to'], $mail['subject'], $mail['content']);
        Db::name('action')->insert($data_action);
        $this->success('保存成功!','instores');
    }
     
    
    /**
     * 删除产品入库单
     * @adminMenu(
     *     'name'   => '删除产品入库单',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '删除产品入库单',
     *     'param'  => ''
     * )
     */
    public function delete()
    {
        $data=$this->request->param();
        //不能修改已提交的入库单s
        $m1=$this->m1;
        $instore_info=$m1->where('id',$data['id'])->find();
        if(empty($instore_info)){
            $this->error('此单号信息已不存在');
        }
        if($instore_info['status']!==0){
            $this->error('不能删除已提交的入库单');
        }
        if($instore_info['aid0']!=session('ADMIN_ID')){
            $this->error('不能删除他人的入库单号');
        } 
        
        Db::startTrans();
        try{
            $row=$m1->where('id',$data['id'])->delete();
            if($row!==1){
                throw \Exception();
            }
            //删除相关联入库记录
            $m=$this->m;
            $rows=$m->where('oid',$instore_info['oid'])->delete(); 
            Db::commit();
        }catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error('删除失败');
        }
        $data_action=[
            'aid'=>$instore_info['aid0'],
            'time'=>time(),
            'type'=>'instore',
            'ip'=>get_client_ip(),
            'action'=>'删除入库单'.$instore_info['oid'],
        ];
        Db::name('action')->insert($data_action);
        $this->success('删除成功');
 
    }
    /**
     * 导出excel
     * @adminMenu(
     *     'name'   => '导出excel',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '导出excel',
     *     'param'  => ''
     * )
     */
    function excel(){
     
        $id=$this->request->param('id',0,'intval');
        
        $m=$this->m;
        $m1=$this->m1;
        $data_info=$m1->where('id',$id)->find();
        if(empty($data_info)){
            $this->error('该单号不存在');
        }
        $list=$m->where('oid',$data_info['oid'])->select();
         
        ini_set('max_execution_time', '0');
     
        $filename='入库单'.$data_info['oid'].'.xls';
        $phpexcel = new PHPExcel();
        
        //设置文本格式
        $str=PHPExcel_Cell_DataType::TYPE_STRING;
       
        //设置第一个sheet
        $phpexcel->setActiveSheetIndex(0);
        $sheet= $phpexcel->getActiveSheet();
        //设置sheet表名
        $sheet->setTitle('入库单'.$data_info['oid']);
        //A18到E22为对角的整个长方形区域合并
        //$sheet->mergeCells('A18:E22');
        // 所有单元格默认高度
        $sheet->getDefaultRowDimension()->setRowHeight(18);
        $sheet->getDefaultColumnDimension()->setWidth(10);
        //序号，单位，数量宽度设小以节约空间
        $sheet->getColumnDimension('A')->setWidth(5);
        $sheet->getColumnDimension('I')->setWidth(5);
        $sheet->getColumnDimension('K')->setWidth(5);
      
//         $sheet->getColumnDimension('E')->setWidth(30);
//         $sheet->getColumnDimension('K')->setWidth(20);
        //设置第一行 
        $i=1;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet
        ->setCellValue('A'.$i, '入库单号：')
        ->setCellValue('C'.$i, $data_info['oid'])
        ->setCellValue('F'.$i, '入库时间：')
        ->setCellValue('H'.$i, date('Y-m-d H:i',$data_info['insert_time']));
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet
        ->setCellValue('A'.$i, '入库仓库：')
        ->setCellValue('C'.$i, $data_info['store_name'])
        ->setCellValue('F'.$i, '购货人：')
        ->setCellValue('H'.$i, $data_info['buyer_name']);
        //设置第一行
        $i++; 
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet->mergeCells('K'.$i.':L'.$i);
        $sheet
        ->setCellValue('A'.$i, '供货商：')
        ->setCellValue('C'.$i, $data_info['seller_name'])
        ->setCellValue('F'.$i, '运费：')
        ->setCellValue('H'.$i, '￥'.$data_info['freight']) 
        ->setCellValue('J'.$i, '运费支付：')
        ->setCellValue('K'.$i, empty($data_info['is_freight'])?'不支付':'支付');
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet
        ->setCellValue('A'.$i, '入库品种：') 
        ->setCellValueExplicit('C'.$i, $data_info['count'],$str) 
        ->setCellValue('F'.$i, '入库数量：')
        ->setCellValueExplicit('H'.$i, $data_info['num'],$str);
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet
        ->setCellValue('A'.$i, '产品总价：')
        ->setCellValue('C'.$i, '￥'.$data_info['cprice'])
        ->setCellValue('F'.$i, '费用总计：')
        ->setCellValue('H'.$i, '￥'.$data_info['cprice1']);
       
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':L'.$i);
        $sheet
        ->setCellValue('A'.$i, '入库员：')
        ->setCellValue('C'.$i, $data_info['aname0'])
        ->setCellValue('F'.$i, '入库备注：')
        ->setCellValue('H'.$i, $data_info['cdsc']);
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':L'.$i);
        $sheet
        ->setCellValue('A'.$i, '审核员：')
        ->setCellValue('B'.$i, $data_info['aname1'])
        ->setCellValue('F'.$i, '审核备注：')
        ->setCellValue('H'.$i, $data_info['rdsc']);
        $n=$i;
        $i+=2;
        
        //设置入库记录表头
        $sheet->mergeCells('B'.$i.':C'.$i);
        $sheet->mergeCells('D'.$i.':E'.$i);
        $sheet->mergeCells('F'.$i.':H'.$i);
        $sheet 
        ->setCellValue('A'.$i, '序号') 
        ->setCellValue('B'.$i, '条码编号')
        ->setCellValue('D'.$i, '自编号')
        ->setCellValue('F'.$i, '产品名称--规格') 
        ->setCellValue('I'.$i, '单位') 
        ->setCellValue('J'.$i, '产品进价')
        ->setCellValue('K'.$i, '数量')
        ->setCellValue('L'.$i, '产品总价')
        ->setCellValue('M'.$i, '备注');
        foreach($list as $k=>$v){
            $i++;
            $sheet->mergeCells('B'.$i.':C'.$i);
            $sheet->mergeCells('D'.$i.':E'.$i);
            $sheet->mergeCells('F'.$i.':H'.$i);
            $sheet 
            ->setCellValueExplicit('A'.$i, $k+1,$str) 
            ->setCellValueExplicit('B'.$i, $v['gsn'],$str)
            ->setCellValueExplicit('D'.$i, $v['gsn0'],$str)
            ->setCellValueExplicit('F'.$i, $v['gname'].'--'.$v['ganame'],$str)
            ->setCellValueExplicit('I'.$i, $v['unit'],$str) 
            ->setCellValueExplicit('J'.$i, '￥'.$v['inprice'],$str)
            ->setCellValueExplicit('K'.$i, $v['num'],$str)
            ->setCellValueExplicit('L'.$i, '￥'.$v['cprice'],$str)
            ->setCellValueExplicit('M'.$i, $v['dsc'],$str);
           
        }
        //***********************画出单元格边框*****************************
        $styleArray = array(
            'borders' => array(
                'allborders' => array(
                    //'style' => PHPExcel_Style_Border::BORDER_THICK,//边框是粗的
                    'style' => PHPExcel_Style_Border::BORDER_THIN,//细边框
                    //'color' => array('argb' => 'FFFF0000'),
                ),
        ),
        );
        $sheet->getStyle('A1:D'.$n)->applyFromArray($styleArray);
        $sheet->getStyle('F1:I'.$n)->applyFromArray($styleArray);
        $sheet->getStyle('J3:L3')->applyFromArray($styleArray);
        $sheet->getStyle('H6:L7')->applyFromArray($styleArray);
        //这里就是画出从单元格A5到N5的边框，看单元格最右边在哪哪个格就把这个N改为那个字母替代  
        $sheet->getStyle('A'.($n+2).':M'.$i)->applyFromArray($styleArray);
        //在浏览器输出
        header('Content-Type: application/vnd.ms-excel');
        header("Content-Disposition: attachment;filename=$filename");
        header('Cache-Control: max-age=0');
        header('Cache-Control: max-age=1');
      
        header ('Cache-Control: cache, must-revalidate'); // HTTP/1.1
        header ('Pragma: public'); // HTTP/1.0
        
        $objwriter = PHPExcel_IOFactory::createWriter($phpexcel, 'Excel5');
        $objwriter->save('php://output');
        exit;
    }
    
}
