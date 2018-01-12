<?php
 
namespace app\admin\controller;

 
use cmf\controller\AdminBaseController;
use app\admin\model\CateModel;
use think\Db;

 
/**
 * Class CountController
 * @package app\admin\controller
 * @adminMenuRoot(
 *     'name'   => '数据统计',
 *     'action' => 'default',
 *     'parent' => '',
 *     'display'=> true,
 *     'order'  => 10,
 *     'icon'   => '',
 *     'remark' => '数据统计'
 * )
 */
class CountController extends AdminBaseController
{
  
    public function _initialize()
    {
        parent::_initialize();
        
    }
     
    /**
     * 出入库统计 
     * @adminMenu(
     *     'name'   => '出入库统计',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 0,
     *     'icon'   => '',
     *     'remark' => '出入库统计',
     *     'param'  => ''
     * )
     */
    public function index()
    { 
        $where=['status'=>2];
        $data=$this->request->param();
        
        if(empty($data['store'])){
            $data['store']=0;
        }else{
            $where['store_id']=['eq', $data['store']];
        }
        $m1=Db::name('instore_info');
        $m2=Db::name('outstore_info');
        $count1=[];
        $count2=[];
        //计算月份
        $time=time();
        $date=getdate($time);
        $year=$date['year'];
        $mon=$date['mon'];
        //总订单，总用户
        $count1['order'][0]=$m1->where($where)->count();
        $count1['money'][0]=$m1->where($where)->sum('cprice1');
        $count2['order'][0]=$m2->where($where)->count();
        $count2['money'][0]=$m2->where($where)->sum('cprice1');
        if(empty($count1['money'][0])){
            $count1['money'][0]='0.00';
        }
        if(empty($count2['money'][0])){
            $count2['money'][0]='0.00';
        }
        $times[13]=$time;
        
        
        //计算前12个月每月的数据
        for($i=12;$i>0;$i--){
            
            $labels[$i]=$year.'-'.$mon;
            //stime用于datetime格式的数据库计算
            $stime=$labels[$i].'-01 00:00:00';
            if($i==12){
                $stime1=date('Y-m-d H:i:s',$time);
            }else{
                $stime1=$labels[$i+1].'-01 00:00:00';
            }
            
            $times[$i]=strtotime($stime);
            // 单数
            $where['insert_time']=array('between',array($times[$i],$times[$i+1]));
            $count1['order'][$i]=$m1->where($where)->count();
            $count1['money'][$i]=$m1->where($where)->sum('cprice1');
            if(empty($count1['money'][$i])){
                $count1['money'][$i]=0;
            }
            $count2['order'][$i]=$m2->where($where)->count();
            $count2['money'][$i]=$m2->where($where)->sum('cprice1');
            if(empty($count2['money'][$i])){
                $count2['money'][$i]=0;
            }
            
            $mon--;
            if($mon==0){
                $year--;
                $mon=12;
            }
        }
        //得到仓库
        $order='status desc,sort asc,id asc';
        $stores=Db::name('store')->order($order)->select();
          
        $this->assign('data',$data);
       
        $this->assign('stores',$stores);
        $this->assign('labels',$labels);
        $this->assign('count1',$count1);
        $this->assign('count2',$count2);
        return $this->fetch();
    }
    /**
     * 出入库统计查询
     * @adminMenu(
     *     'name'   => '出入库统计查询',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '出入库统计查询',
     *     'param'  => ''
     * )
     */
    public function search()
    {
        $where=['info.status'=>2];
        $data=$this->request->param();
        //仓库
        if(empty($data['store'])){
            $data['store']=0;
        }else{
            $where['info.store_id']=['eq', $data['store']];
        }
        //分类
        if(empty($data['cid'])){
            $data['cid']=0;
        }else{
            $path=Db::name('cate')->where('id',$data['cid'])->find();
            
            $cates=Db::name('cate')->where('path','like',$path['path'].'-%')->select();
            $cids=[$data['cid']];
            foreach($cates as $v){
                $cids[]=$v['id'];
            }
            $where['list.cid']=['in',$cids];
        }
        //产品名
        if(empty($data['gname'])){
            $data['gname']='';
        }else{
            $where['list.gname']=['like','%'.$data['gname'].'%'];
        }
         
        if(empty($data['start_time'] )){
            $data['start_time']='';
        }else{
            $data['start_time']=$data['start_time'];
            $start_time0=strtotime($data['start_time']);
        }
        if(empty($data['end_time'] )){
            $data['end_time']='';
        }else{
            $data['end_time']=$data['end_time'];
            $end_time0=strtotime($data['end_time']);
        }
        if(isset($start_time0)){
            if(isset($end_time0)){
                if($start_time0>=$end_time0){
                    $this->error('起始时间不能大于等于结束时间',url('search'));
                }else{
                    $where['info.insert_time']=['between',[$start_time0,$end_time0]];
                }
            }else{
                $where['info.insert_time']=['egt',$start_time0];
            }
        }elseif(isset($end_time0)){
            $where['info.insert_time']=['elt',$end_time0];
        }
        $m1=Db::name('instore');
        $m2=Db::name('outstore');
        $count1=[];
        $count2=[];
        
        //总次数，数量，总价
        $list1=$m1
        ->alias('list')
        ->join('cmf_instore_info info','info.oid=list.oid')
        ->where($where)->select();
        
        $count1['order']=count($list1);
        $count1['num']=0;
        $count1['money']=0;
      
        foreach ($list1 as $v){
            $count1['num']=bcadd( $count1['num'],$v['num']);
            $count1['money']=bcadd( $count1['money'],$v['cprice'],2);
        }
        
        if($count1['num']==0){
            $count1['num']=0;
            $count1['price']=0;
            $count1['cprice']=0;
        }else{
            $count1['price']=bcdiv($count1['money'],$count1['num'],2);
            
        }
        //总次数，数量，总价
        $list2=$m2
        ->alias('list')
        ->join('cmf_outstore_info info','info.oid=list.oid')
        ->where($where)->select();
        
        $count2['order']=count($list2);
        $count2['num']=0;
        $count2['money']=0;
        
        foreach ($list2 as $v){
            $count2['num']=bcadd( $count2['num'],$v['num']);
            $count2['money']=bcadd( $count2['money'],$v['cprice'],2);
        }
        
        if($count2['num']==0){
            $count2['num']=0;
            $count2['price']=0;
            $count2['cprice']=0;
        }else{
            $count2['price']=bcdiv($count2['money'],$count2['num'],2);
            
        }
         
         
        //得到仓库
        $order='status desc,sort asc,id asc';
        $stores=Db::name('store')->order($order)->select();
       
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree($data['cid']);
        
        $this->assign('cate_tree', $catesTree);
        $this->assign('data',$data); 
        $this->assign('stores',$stores);
      
        $this->assign('count1',$count1);
        $this->assign('count2',$count2);
        return $this->fetch();
    }
    
    /**
     * 销售统计查询
     * @adminMenu(
     *     'name'   => '销售统计查询',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '销售统计查询',
     *     'param'  => ''
     * )
     */
    public function seller()
    {
        $where=['status'=>2];
        $data=$this->request->param();
        //仓库
        if(empty($data['store'])){
            $data['store']=0;
        }else{
            $where['store_id']=['eq', $data['store']];
        }
        //顾客
        if(empty($data['buyer'])){
            $data['buyer']=0;
        }else{
            $where['buyer_id']=['eq', $data['buyer']];
        }
        //销售员
        if(empty($data['seller'])){
            $data['seller']=0;
        }else{
            $where['seller_id']=['eq', $data['seller']];
        }
         
        if(empty($data['start_time'] )){
            $data['start_time']='';
        }else{
            $data['start_time']=$data['start_time'];
            $start_time0=strtotime($data['start_time']);
        }
        if(empty($data['end_time'] )){
            $data['end_time']='';
        }else{
            $data['end_time']=$data['end_time'];
            $end_time0=strtotime($data['end_time']);
        }
        if(isset($start_time0)){
            if(isset($end_time0)){
                if($start_time0>=$end_time0){
                    $this->error('起始时间不能大于等于结束时间',url('search'));
                }else{
                    $where['insert_time']=['between',[$start_time0,$end_time0]];
                }
            }else{
                $where['insert_time']=['egt',$start_time0];
            }
        }elseif(isset($end_time0)){
            $where['insert_time']=['elt',$end_time0];
        }
       
        $count2=[]; 
        //总次数，数量，总价
        $list2=Db::name('outstore_info')->where($where)->select();
        
        $count2['order']=count($list2);
        $count2['num']=0;
        $count2['money']=0;
        
        foreach ($list2 as $v){
            $count2['num']=bcadd( $count2['num'],$v['num']);
            $count2['money']=bcadd( $count2['money'],$v['cprice1'],2);
        }
        
        if($count2['num']==0){
            $count2['num']=0;
            $count2['price']=0;
            $count2['cprice']=0;
        }else{
            $count2['price']=bcdiv($count2['money'],$count2['num'],2);
            
        }
        
        
        //得到仓库
        $order='status desc,sort asc,id asc';
        $stores=Db::name('store')->order($order)->select();
        //得到顾客 
        $customer=Db::name('customer')->order($order)->select();
        //得到销售员
        $worker=Db::name('worker')->where('type','in','2,3')->order($order)->select();
      
        $this->assign('data',$data);
        $this->assign('stores',$stores);
        $this->assign('customer',$customer);
        $this->assign('worker',$worker);
         
        $this->assign('count2',$count2);
        return $this->fetch();
    }
    /**
     * 进货统计查询
     * @adminMenu(
     *     'name'   => '进货统计查询',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '进货统计查询',
     *     'param'  => ''
     * )
     */
    public function buyer()
    {
        $where=['status'=>2];
        $data=$this->request->param();
        //仓库
        if(empty($data['store'])){
            $data['store']=0;
        }else{
            $where['store_id']=['eq', $data['store']];
        }
        //购货员
        if(empty($data['buyer'])){
            $data['buyer']=0;
        }else{
            $where['buyer_id']=['eq', $data['buyer']];
        }
        //供货商
        if(empty($data['seller'])){
            $data['seller']=0;
        }else{
            $where['seller_id']=['eq', $data['seller']];
        }
        
        if(empty($data['start_time'] )){
            $data['start_time']='';
        }else{
            $data['start_time']=$data['start_time'];
            $start_time0=strtotime($data['start_time']);
        }
        if(empty($data['end_time'] )){
            $data['end_time']='';
        }else{
            $data['end_time']=$data['end_time'];
            $end_time0=strtotime($data['end_time']);
        }
        if(isset($start_time0)){
            if(isset($end_time0)){
                if($start_time0>=$end_time0){
                    $this->error('起始时间不能大于等于结束时间',url('search'));
                }else{
                    $where['insert_time']=['between',[$start_time0,$end_time0]];
                }
            }else{
                $where['insert_time']=['egt',$start_time0];
            }
        }elseif(isset($end_time0)){
            $where['insert_time']=['elt',$end_time0];
        }
        
        $count2=[];
        //总次数，数量，总价
        $list2=Db::name('instore_info')->where($where)->select();
        
        $count2['order']=count($list2);
        $count2['num']=0;
        $count2['money']=0;
        
        foreach ($list2 as $v){
            $count2['num']=bcadd( $count2['num'],$v['num']);
            $count2['money']=bcadd( $count2['money'],$v['cprice1'],2);
        }
        
        if($count2['num']==0){
            $count2['num']=0;
            $count2['price']=0;
            $count2['cprice']=0;
        }else{
            $count2['price']=bcdiv($count2['money'],$count2['num'],2);
            
        }
        
        
        //得到仓库
        $order='status desc,sort asc,id asc';
        $stores=Db::name('store')->order($order)->select();
        //得到供货商
        $supplier=Db::name('supplier')->order($order)->select();
        //得到进货员
        $worker=Db::name('worker')->where('type','in','1,3')->order($order)->select();
        
        $this->assign('data',$data);
        $this->assign('stores',$stores);
        $this->assign('supplier',$supplier);
        $this->assign('worker',$worker);
        
        $this->assign('count2',$count2);
        return $this->fetch();
    }
    
}
