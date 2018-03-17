<?php
 
namespace app\admin\controller;

 
use cmf\controller\AdminBaseController;
use app\admin\model\CateModel;
use think\Db;
use app\admin\model\GoodsAttrModel;
 
use app\admin\model\GoodsStoreModel;
use PHPExcel_IOFactory;
use PHPExcel;
use PHPExcel_Cell_DataType;
use PHPExcel_Style_Border;

/**
 * Class OutstoreController
 * @package app\admin\controller
 * @adminMenuRoot(
 *     'name'   => '产品出库',
 *     'action' => 'default',
 *     'parent' => '',
 *     'display'=> true,
 *     'order'  => 10,
 *     'icon'   => '',
 *     'remark' => '产品出库'
 * )
 */
class OutstoreController extends AdminBaseController
{
    private $m;
    private $m1;
    private $order;
    
    public function _initialize()
    {
        parent::_initialize();
        $this->order='oid desc';
        $this->m=Db::name('outstore');
        $this->m1=Db::name('outstore_info');
        $this->assign('flag','产品出库');
    }
    /**
     * 产品出库记录
     * @adminMenu(
     *     'name'   => '产品出库记录',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 11,
     *     'icon'   => '',
     *     'remark' => '产品出库记录',
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
     * 产品出库单
     * @adminMenu(
     *     'name'   => '产品出库单',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品出库单',
     *     'param'  => ''
     * )
     */
    public function outstores()
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
        $list= $m->where($where)->order('id desc')->paginate(10);
        // 获取分页显示
        $page = $list->render();
        
        //得到顾客，仓库和销售员
        $order='status desc,sort asc,id asc';
        $suppliers=Db::name('customer')->order($order)->select();
        $stores=Db::name('store')->order($order)->select();
        $where_worker=[
            'type'=>['in',[2,3]]
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
     * 添加产品出库
     * @adminMenu(
     *     'name'   => '添加产品出库',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '添加产品出库',
     *     'param'  => ''
     * )
     */
    public function add()
    {
       
        //得到顾客，仓库和销售员
        $order='sort asc,id asc';
        $suppliers=Db::name('customer')->where('status',1)->order($order)->select();
        $stores=Db::name('store')->where('status',1)->order($order)->select();
        $where_worker=[
           'status'=>['eq',1],
           'type'=>['in',[2,3]]
        ];
        $workers=Db::name('worker')->where($where_worker)->order($order)->select();
        
        
    
        $this->assign('suppliers', $suppliers);
        $this->assign('stores', $stores);
        $this->assign('workers', $workers);
         
        return $this->fetch();
    }
    /**
     * 添加产品出库记录
     * @adminMenu(
     *     'name'   => '添加产品出库记录',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '添加产品出库记录',
     *     'param'  => ''
     * )
     */
    public function outstore_add()
    {
         $data=$this->request->param();
        //不能修改已提交的出库单 
        $m1=$this->m1;
        $outstore_info=$m1->where('oid',$data['oid'])->find();
        if(empty($outstore_info)){
            $this->error('此单号信息已不存在');
        }
        if($outstore_info['status']!=0){
            $this->error('不能修改已提交的出库单');
        }
        if($outstore_info['aid0']!=session('ADMIN_ID')){
            $this->error('不能编辑他人的出库单号');
        } 
        //得到库存id和ga_id
        $tmp=explode('-',$data['id']);
        $gsid=$tmp[0];
        $gaid=$tmp[1];
        $model_goods= new GoodsAttrModel();
        $goods=$model_goods->attr($gaid);
 
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
            'outprice0'=>$goods['outprice'],
            'num'=>$data['num'],
            'outprice'=>$data['price'],
            'dsc'=>$data['dsc'],
            'cprice'=>bcmul($data['num'],$data['price'],2),
        ]; 
        // 启动事务
        Db::startTrans();
        try{
            //出库
            $id=$m->insertGetId($data_add);
            if($id>0){
                
                $data_add['id']=$id;
            
                //更新库存
                $m_store=Db::name('goods_store');
                $row=$m_store->where('id',$gsid)->data('time',time())->setDec('num',$data['num']);
                //更新失败
                if($row!==1 ){
                    throw \Exception('库存更新失败,请刷新页面');
                } 
                $store_new=$m_store->where('id',$gsid)->find();
                 
                if($store_new['num']<0 ){
                    throw \Exception('库存不足,请刷新页面');
                } 
                //更新出库单
                $data_info=[
                    'count'=>bcadd($outstore_info['count'],1,0),
                    'num'=>bcadd($outstore_info['num'],$data['num'],0),
                    'cprice'=>bcadd($data_add['cprice'],$outstore_info['cprice'],2),
                    'time'=>time(),
                ];
                $row=$m1->where('id',$outstore_info['id'])->update($data_info);
                //更新失败
                if($row!==1){
                    throw \Exception('出库单更新失败');
                }
            }else{
                throw \Exception('出库记录添加失败');
            }
            
            Db::commit();
        }catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error('添加失败!'.$e->getMessage());
        }
        $data_add['ccount']=$data_info['count'];
        $data_add['ccprice']=$data_info['cprice'];
        $data_add['cnum']=$data_info['num'];
        $data_action=[
            'aid'=>$outstore_info['aid0'],
            'time'=>time(),
            'type'=>'outstore',
            'ip'=>get_client_ip(),
            'action'=>'对出库单'.$outstore_info['oid'].'添加了产品'.$data_add['gname'].'-'.$data_add['ganame'],
        ];
        Db::name('action')->insert($data_action);
        $this->success('已添加',null,$data_add,1);
        exit;
    }
    /**
     * 删除产品出库记录
     * @adminMenu(
     *     'name'   => '删除产品出库记录',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '删除产品出库记录',
     *     'param'  => ''
     * )
     */
    public function outstore_delete()
    {
        //  // success($msg = '', $url = null, $data = '', $wait = 3, array $header = [])
        
        $id=$this->request->param('id',0,'intval');
       
        //先根据得到出库单号和出库状态
        $m=$this->m;
        $info=$m->where('id',$id)->find();
        if(empty($info)){
            $this->error('该记录不存在，请刷新');
        }
        //不能修改已提交的出库单
        $m1=$this->m1;
        $outstore_info=$m1->where('oid',$info['oid'])->find();
        if(empty($outstore_info)){
            $this->error('此单号信息已不存在');
        }
        if($outstore_info['status']!=0){
            $this->error('不能修改已提交的出库单');
        }
        if($outstore_info['aid0']!=session('ADMIN_ID')){
            $this->error('不能编辑他人的出库单');
        } 
        $time=time();
        // 启动事务
        Db::startTrans();
        try{
            $row=$m->where('id',$id)->delete();
            if($row!==1){
                throw \Exception('出库记录删除失败');
            }
            //库存表信息 
            $m_store=Db::name('goods_store');
            $where_store=['store'=>$outstore_info['store_id'],'goods'=>$info['gaid']];
            //更新库存
            $row=$m_store->where($where_store)->data(['time'=>$time])->setInc('num',$info['num']);
            //更新失败
            //没有信息则添加
            if($row===0){
                $where_store['time']=$time;
                $where_store['num']=$info['num'];
                $insert=$m_store->insertGetId($where_store);
                if($insert<=0){
                    throw \Exception('添加库存记录失败');
                }
            }elseif($row!==1){
                throw \Exception('库存更新失败');
            }
            //更新出库单
            $data_info=[
                'count'=>bcsub($outstore_info['count'],1,0),
                'num'=>bcsub($outstore_info['num'],$info['num'],0),
                'cprice'=>bcsub($outstore_info['cprice'],$info['cprice'],2),
                'time'=>$time,
            ];
            $row=$m1->where('id',$outstore_info['id'])->update($data_info);
            //更新失败
            if($row!==1){
                throw \Exception('出库单更新失败');
            }
            
            Db::commit();
        }catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error('删除失败!'.$e->getMessage());
        }
        $data_action=[
            'aid'=>$outstore_info['aid0'],
            'time'=>time(),
            'type'=>'outstore',
            'ip'=>get_client_ip(),
            'action'=>'对出库单'.$outstore_info['oid'].'删除了产品'.$info['gname'].'-'.$info['ganame'],
        ];
        Db::name('action')->insert($data_action);
        $this->success('已删除',null,$data_info,1);
    }   
    
    /**
     * 添加产品出库提交
     * @adminMenu(
     *     'name'   => '添加产品出库提交',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '添加产品出库提交',
     *     'param'  => ''
     * )
     */
    public function addPost()
    {
       //先填单号信息再跳转到编辑页面  
       $data = $this->request->param(); 
       //得到库单号,当月的次序
       $date=getdate();
       
       $date0=$date['year'].'-'.$date['mon'];
       $time0=strtotime($date0);
       
       $m1=$this->m1;
       //查找最后一个单号
       $last=$m1->where('insert_time','egt',$time0)->order('insert_time desc')->find();
       if(empty($last)){
           $oid=$date0.'-1';
       }else{
           $arr=explode('-',$last['oid']);
           $oid=$date0.'-'.($arr[2]+1);
       }
       $data_info=[
           'oid'=>$oid,
           'insert_time'=>time(),
           'time'=>time(),
           'status'=>0,
           'aname0'=>$data['uname'],
           'aid0'=>session('ADMIN_ID'),
           'cdsc'=>$data['cdsc'],
           'freight'=>$data['freight'],
           'is_freight'=>$data['is_freight']
       ]; 
        try{
            $tmp=explode('-', $data['store']);
            $data_info['store_id']=$tmp[0];
            $data_info['store_name']=$tmp[1];
            $tmp=explode('-', $data['supplier']);
            $data_info['buyer_id']=$tmp[0];
            $data_info['buyer_name']=$tmp[1];
            $tmp=explode('-', $data['worker']); 
            $data_info['seller_id']=$tmp[0];
            $data_info['seller_name']=$tmp[1];
            //更新出库单
            
            $insert=$m1->insertGetId($data_info);
            if($insert<1){
                throw \Exception();
            }
        }catch (\Exception $e) {
          
            $this->error('添加失败');
        } 
        $data_action=[
            'aid'=>$data_info['aid0'],
            'time'=>time(),
            'type'=>'outstore',
            'ip'=>get_client_ip(),
            'action'=>'添加了出库单'.$data_info['oid']
        ];
        Db::name('action')->insert($data_action);
        $this->success('添加成功!',url('edit',['id'=>$insert]));

    }

    /**
     * 编辑产品出库
     * @adminMenu(
     *     'name'   => '编辑产品出库',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '编辑产品出库',
     *     'param'  => ''
     * )
     */
    public function edit()
    {
        //得到出库单信息
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
        $model= new GoodsStoreModel();
        $goods=$model->store($info['store_id']);
        
        foreach($goods as $k=>$v){
            $tmp=explode('-', $v['path']);
            $pathes='';
            foreach ($tmp as $vv){
                $pathes.=' goods'.$vv;
            }
            $goods[$k]['pathes']=$pathes;
        }
        //得到顾客，仓库和销售员
        $order='sort asc,id asc';
        $suppliers=Db::name('customer')->where('status',1)->order($order)->select();
        $stores=Db::name('store')->where('status',1)->order($order)->select();
        $where_worker=[
            'status'=>['eq',1],
            'type'=>['in',[2,3]]
        ];
        $workers=Db::name('worker')->where($where_worker)->order($order)->select();
        
        
        //list出库记录
        $m=$this->m;
        $list=$m->where('oid',$info['oid'])->select();
        $this->assign('info', $info);
        $this->assign('goods', $goods);
        $this->assign('suppliers', $suppliers);
        $this->assign('stores', $stores);
        $this->assign('workers', $workers);
        
        $this->assign('list', $list);
        $this->assign('statuss',config('store_status'));
        return $this->fetch();

    }

    /**
     * 编辑产品出库提交
     * @adminMenu(
     *     'name'   => '编辑产品出库提交',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '编辑产品出库提交',
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
                $this->error('不能审核未提交的出库');
            }else{
                $this->redirect(url('review',$data));
            }
        }elseif($info['aid0']!=session('ADMIN_ID')){
            $this->error('不能编辑他人的出库单号');
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
            $data_info['cdsc']=$data['cdsc'];
            $data_info['cdsc']=$data['cdsc'];
            //如果顾客支付运费，则总售价+运费
            $data_info['cprice1']=($info['is_freight']==0)?$info['cprice']:(bcadd($info['cprice'],$info['freight'],2));
        }
        //更新出库单
        $row=$m1->where('id',$data['id'])->update($data_info);
        if($row!==1){
            $this->error('保存失败');
        }
        $data_action=[
            'aid'=>$info['aid0'],
            'time'=>time(),
            'type'=>'outstore',
            'ip'=>get_client_ip(),
            'action'=>'对出库单'.$info['oid'].'编辑保存',
        ];
        Db::name('action')->insert($data_action);
        $this->success('保存成功!',url('outstores'));
    }
    /**
     * 审核产品出库 
     * @adminMenu(
     *     'name'   => '审核产品出库 ',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '审核产品出库 ',
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
        if($info['status']>1){
            $this->error('不能审核已审核的单号');
        }
        //审核
        if($data['status']<2 || $info['status']==0){
            $this->error('不能审核'); 
        } 
        $admin0=Db::name('user')->where('id',$info['aid0'])->find();
        $mail=[
            'to'=>$admin0['user_email'],
            'subject'=>'出库审核通知',
            'content'=>'审核人'.$data['uname'].'审核了你的出库单'.$info['oid'].'，决定',
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
            'type'=>'outstore',
            'ip'=>get_client_ip(),
            'action'=>'对出库单'.$info['oid'].'审核，结果为'.$status_info,
        ];
        //如果是暂不审核就只记录审核人和备注，不改变状态
        if($data['status']==4){
            $row=$m1->where('id',$data['id'])->update($data_info);
            if($row===1){
                cmf_send_email($mail['to'], $mail['subject'], $mail['content']);
                Db::name('action')->insert($data_action);
                $this->success('保存成功!','outstores');
            }else{
                $this->error('保存失败');
            }
        }
        $data_info['status']=$data['status'];
        // 启动事务
        Db::startTrans();
        $row=$m1->where('id',$data['id'])->update($data_info);
        
        //审核不通过则结束
        if($data['status']==2){
            Db::commit();
            cmf_send_email($mail['to'], $mail['subject'], $mail['content']); 
            Db::name('action')->insert($data_action);
            $this->success('保存成功!','outstores');
        }
        try{
            if($row!==1){
                throw \Exception('审核出库单失败');
            } 
            //审核完成更新库存
            $m=$this->m;
            $list=$m->where('oid',$info['oid'])->select();
            $m_store=Db::name('goods_store');
           
            foreach($list as $k=>$v){  
                //有记录则更新时间和数量，没有则添加
                $where_store=['store'=>$info['store_id'],'goods'=>$v['gaid']];
                //更新库存
                $row=$m_store->where($where_store)->data(['time'=>$time])->setInc('num',$v['num']);
                //更新失败
                //没有信息则添加
                if($row===0){ 
                    $where_store['time']=$time;
                    $where_store['num']=$v['num'];
                    $insert=$m_store->insertGetId($where_store);
                    if($insert<=0){
                        throw \Exception('添加库存记录失败');
                    }
                }elseif($row!==1){
                    throw \Exception('库存更新失败');
                }
                 
            }
            Db::commit();
        }catch (\Exception $e) {
            Db::rollback(); 
            $this->error('保存失败！'.$e->getMessage());
        }
        cmf_send_email($mail['to'], $mail['subject'], $mail['content']); 
        Db::name('action')->insert($data_action);
        $this->success('保存成功!','outstores');
    }
     
    
    /**
     * 删除产品出库单
     * @adminMenu(
     *     'name'   => '删除产品出库单',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '删除产品出库单',
     *     'param'  => ''
     * )
     */
    public function delete()
    {
        $data=$this->request->param();
        //不能修改已提交的出库单s
        $m1=$this->m1;
        $outstore_info=$m1->where('id',$data['id'])->find();
        if(empty($outstore_info)){
            $this->error('此单号信息已不存在');
        }
        if($outstore_info['status']!=0){
            $this->error('不能删除已提交的出库单');
        }
        if($outstore_info['aid0']!=session('ADMIN_ID')){
            $this->error('不能删除他人的出库单号');
        } 
        $time=time();
        Db::startTrans();
        try{
            $row=$m1->where('id',$data['id'])->delete();
            if($row!==1){
                throw \Exception();
            }
            //审核完成更新库存
            $m=$this->m;
            $list=$m->where('oid',$outstore_info['oid'])->select();
            $m_store=Db::name('goods_store');
            
            foreach($list as $k=>$v){
                //有记录则更新时间和数量，没有则添加
                
                //通过仓库和产品定位库存 
                $where_store=['store'=>$outstore_info['store_id'],'goods'=>$v['gaid']];
                //更新库存
                $row=$m_store->where($where_store)->data(['time'=>$time])->setInc('num',$v['num']);
                //更新失败
                //没有信息则添加
                if($row===0){
                    $where_store['time']=$time; 
                    $where_store['num']=$v['num'];
                    $insert=$m_store->insertGetId($where_store);
                    if($insert<=0){
                        throw \Exception('添加库存记录失败');
                    }
                }elseif($row!==1){
                    throw \Exception('库存更新失败');
                }
                
            }
            
            //删除相关联出库记录 
            $rows=$m->where('oid',$outstore_info['oid'])->delete(); 
            Db::commit();
        }catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error('删除失败');
        }
        $data_action=[
            'aid'=>$outstore_info['aid0'],
            'time'=>time(),
            'type'=>'outstore',
            'ip'=>get_client_ip(),
            'action'=>'删除出库单'.$outstore_info['oid'],
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
        
        $filename='出库单'.$data_info['oid'].'.xls';
        $phpexcel = new PHPExcel();
        
        //设置文本格式
        $str=PHPExcel_Cell_DataType::TYPE_STRING;
        
        //设置第一个sheet
        $phpexcel->setActiveSheetIndex(0);
        $sheet= $phpexcel->getActiveSheet();
        //设置sheet表名
        $sheet->setTitle('出库单'.$data_info['oid']);
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
        ->setCellValue('A'.$i, '出库单号：')
        ->setCellValue('C'.$i, $data_info['oid'])
        ->setCellValue('F'.$i, '出库时间：')
        ->setCellValue('H'.$i, date('Y-m-d H:i',$data_info['insert_time']));
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet
        ->setCellValue('A'.$i, '出库仓库：')
        ->setCellValue('C'.$i, $data_info['store_name'])
        ->setCellValue('F'.$i, '售货人：')
        ->setCellValue('H'.$i, $data_info['seller_name']);
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet->mergeCells('K'.$i.':L'.$i);
        $sheet
        ->setCellValue('A'.$i, '顾客：')
        ->setCellValue('C'.$i, $data_info['buyer_name'])
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
        ->setCellValue('A'.$i, '出库品种：')
        ->setCellValueExplicit('C'.$i, $data_info['count'],$str)
        ->setCellValue('F'.$i, '出库数量：')
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
        ->setCellValue('A'.$i, '出库员：')
        ->setCellValue('C'.$i, $data_info['aname0'])
        ->setCellValue('F'.$i, '出库备注：')
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
        
        //设置出库记录表头
         
        $sheet->mergeCells('B'.$i.':C'.$i);
        $sheet->mergeCells('D'.$i.':E'.$i);
        $sheet->mergeCells('F'.$i.':H'.$i);
        $sheet
        ->setCellValue('A'.$i, '序号')
        ->setCellValue('B'.$i, '条码编号')
        ->setCellValue('D'.$i, '自编号')
        ->setCellValue('F'.$i, '产品名称--规格')
        ->setCellValue('I'.$i, '单位')
        ->setCellValue('J'.$i, '产品售价')
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
            ->setCellValueExplicit('J'.$i, '￥'.$v['outprice'],$str)
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
    
    /**
     * 销售导出excel
     * @adminMenu(
     *     'name'   => '销售导出excel',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '销售导出excel',
     *     'param'  => ''
     * )
     */
    function excel0(){
        
        $id=$this->request->param('id',0,'intval');
        
        $m=$this->m;
        $m1=$this->m1;
        $data_info=$m1->where('id',$id)->find();
        if(empty($data_info)){
            $this->error('该单号不存在');
        }
        $list=$m->where('oid',$data_info['oid'])->select();
        $customer=Db::name('customer')->where('id',$data_info['buyer_id'])->find();
        if(empty($customer)){
            $this->error('该顾客不存在');
        }
        ini_set('max_execution_time', '0');
        
        $filename='销售单'.$data_info['oid'].'.xls';
        $phpexcel = new PHPExcel();
        
        //设置文本格式
        $str=PHPExcel_Cell_DataType::TYPE_STRING;
        
        //设置第一个sheet
        $phpexcel->setActiveSheetIndex(0);
        $sheet= $phpexcel->getActiveSheet();
        //设置sheet表名
        $sheet->setTitle('销售单'.$data_info['oid']);
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
        ->setCellValue('A'.$i, '出库单号：')
        ->setCellValue('C'.$i, $data_info['oid'])
        ->setCellValue('F'.$i, '出库时间：')
        ->setCellValue('H'.$i, date('Y-m-d H:i',$data_info['insert_time']));
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet
        ->setCellValue('A'.$i, '出库仓库：')
        ->setCellValue('C'.$i, $data_info['store_name'])
        ->setCellValue('F'.$i, '售货人：')
        ->setCellValue('H'.$i, $data_info['seller_name']);
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet->mergeCells('K'.$i.':L'.$i);
        $sheet
        ->setCellValue('A'.$i, '顾客：')
        ->setCellValue('C'.$i, $customer['name'])
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
        ->setCellValue('A'.$i, '联系人：')
        ->setCellValue('C'.$i, $customer['name'])
        ->setCellValue('F'.$i, '联系地址：')
        ->setCellValue('H'.$i, $customer['address']);
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':I'.$i);
        $sheet
        ->setCellValue('A'.$i, '手机号码：')
        ->setCellValueExplicit('C'.$i, $customer['phone'],$str)
        ->setCellValue('F'.$i, '固定电话：')
        ->setCellValueExplicit('H'.$i, $customer['tel'],$str);
        //设置第一行
        $i++;
        $sheet->mergeCells('A'.$i.':B'.$i);
        $sheet->mergeCells('C'.$i.':D'.$i);
        $sheet->mergeCells('F'.$i.':G'.$i);
        $sheet->mergeCells('H'.$i.':L'.$i);
        $sheet
        ->setCellValue('A'.$i, '出库员：')
        ->setCellValue('C'.$i, $data_info['aname0'])
        ->setCellValue('F'.$i, '出库备注：')
        ->setCellValue('H'.$i, $data_info['cdsc']);
        
        $n=$i;
        $i+=2;
        
        //设置出库记录表头
        
        $sheet->mergeCells('B'.$i.':C'.$i);
        $sheet->mergeCells('D'.$i.':E'.$i);
        $sheet->mergeCells('F'.$i.':H'.$i);
        $sheet
        ->setCellValue('A'.$i, '序号')
        ->setCellValue('B'.$i, '条码编号')
        ->setCellValue('D'.$i, '自编号')
        ->setCellValue('F'.$i, '产品名称--规格')
        ->setCellValue('I'.$i, '单位')
        ->setCellValue('J'.$i, '产品售价')
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
            ->setCellValueExplicit('J'.$i, '￥'.$v['outprice'],$str)
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
        $sheet->getStyle('H5:L5')->applyFromArray($styleArray);
        $sheet->getStyle('H7:L7')->applyFromArray($styleArray);
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
