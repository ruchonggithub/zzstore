<?php
 
namespace app\admin\controller;

 
use cmf\controller\AdminBaseController;
use app\admin\model\CateModel;
use think\Db;

 
/**
 * Class GoodsStoreController
 * @package app\admin\controller
 * @adminMenuRoot(
 *     'name'   => '仓储管理',
 *     'action' => 'default',
 *     'parent' => '',
 *     'display'=> true,
 *     'order'  => 10,
 *     'icon'   => '',
 *     'remark' => '仓储管理'
 * )
 */
class GoodsStoreController extends AdminBaseController
{
  
    public function _initialize()
    {
        parent::_initialize();
       
        $this->assign('flag','产品库存');
    }
     
    /**
     * 产品库存
     * @adminMenu(
     *     'name'   => '产品库存',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 0,
     *     'icon'   => '',
     *     'remark' => '产品库存',
     *     'param'  => ''
     * )
     */
    public function index()
    { 
        $where=[];
        $data=$this->request->param();
        
        if(empty($data['store'])){
            $data['store']=0;
        }else{
            $where['gs.store']=['eq', $data['store']];
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
            $where['g.cid']=['in',$cids];
        }
        if(empty($data['gname'])){
            $data['gname']='';
        }else{
            $where['g.name']=['like', '%'.$data['gname'].'%'];
        }
        
        $list= Db::name('goods_store')
        ->alias('gs')
        ->field('gs.*,s.name as sname,ga.attr,ga.sn,ga.unit,ga.inprice,ga.outprice,ga.dsc as gdsc,g.name as gname,g.cid,g.name as cname')
        ->join('cmf_store s','s.id = gs.store','left')
        ->join('cmf_goods_attr ga','ga.id = gs.goods','left')
        ->join('cmf_goods g','g.id = ga.gid','left')
        ->join('cmf_cate c','c.id = g.cid','left')
         ->where($where)
        ->order('gs.goods asc')
        ->paginate(10);
       
        // 获取分页显示
      
        $page = $list->appends($this->request->param())->render(); 
        //得到仓库
        $order='status desc,sort asc,id asc';
        $stores=Db::name('store')->order($order)->select();
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree($data['cid']); 
        $this->assign('cates_tree',$catesTree);
        $this->assign('page',$page);
        $this->assign('list',$list);
        
        $this->assign('data',$data);
       
        $this->assign('stores',$stores);
     
      
        return $this->fetch();
    }
    /**
     * 清理库存，把库存为0的库存清除
     * @adminMenu(
     *     'name'   => '清理库存',
     *     'parent' => 'default',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 0,
     *     'icon'   => '',
     *     'remark' => '清理库存',
     *     'param'  => ''
     * )
     */
    public function clear()
    { 
        Db::name('goods_store')->where('num=0')->delete();
        $this->redirect(url('index'));
    }
    
}
