<?php


namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\Config;
use app\admin\model\GoodsAttrModel;
use app\admin\model\CateModel;
use PHPExcel_IOFactory;
use PHPExcel;
use PHPExcel_Cell_DataType;
use PHPExcel_Style_Border;
use PHPExcel_Worksheet_Drawing;
use PHPExcel_Style_Alignment;
/**
 * Class GoodsController
 * @package app\admin\controller
 * @adminMenuRoot(
 *     'name'   => '产品管理',
 *     'action' => 'default',
 *     'parent' => '',
 *     'display'=> true,
 *     'order'  => 10,
 *     'icon'   => '',
 *     'remark' => '产品管理'
 * )
 */
class GoodsController extends AdminbaseController {
    
    private $m;
    private $order;
    
    public function _initialize()
    {
        parent::_initialize();
        $this->order='sort asc,time desc';
        $this->m=Db::name('goods');
        $this->assign('flag','产品');
       
    }
    
    /**
     * 产品名称列表
     * @adminMenu(
     *     'name'   => '产品名称列表',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品名称列表',
     *     'param'  => ''
     * )
     */
    function index(){
       
        $m=$this->m;
        $where=[];
        $data=$this->request->param();
        if(empty($data['cid'])){
            $data['cid']=0;
        }else{
            $where['cid']=['eq',$data['cid']];
        }
        if(empty($data['name'])){
            $data['name']='';
        }else{
            $where['name']=['like','%'.$data['name'].'%'];
        }
        $list= $m->where($where)->order($this->order)->paginate(10);
        
        
        // 获取分页显示
        $page = $list->appends($data)->render();
       
        
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree($data['cid']);
        $cates=Db::name('cate')->order('path asc')->select();
        $tmp=[];
        foreach($cates as $v){
            $tmp[$v['id']]=$v['name'];
        }
        $this->assign('cates',$tmp);
        $this->assign('cates_tree',$catesTree);
        $this->assign('page',$page);
        $this->assign('list',$list);
        $this->assign('cid',$data['cid']);
        $this->assign('name',$data['name']);
        $this->assign('flag','产品名称');
        return $this->fetch();
    }
    /**
     * 产品名称编辑
     * @adminMenu(
     *     'name'   => '产品名称编辑',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品名称编辑',
     *     'param'  => ''
     * )
     */
    function edit(){
        $m=$this->m;
        $id=$this->request->param('id');
        $info=$m->where('id',$id)->find();
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree();
        $this->assign('cates_tree',$catesTree);
        $this->assign('info',$info); 
        $this->assign('flag','产品名称');
        return $this->fetch();
    }
    /**
     * 产品名称编辑_执行
     * @adminMenu(
     *     'name'   => '产品名称编辑_执行',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品名称编辑_执行',
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
                'type'=>'goods',
                'ip'=>get_client_ip(),
                'action'=>'编辑产品-id'.$data['id'].'-name-'.$data['name'],
            ];
            Db::name('action')->insert($data_action);
            $this->success('修改成功',url('index')); 
        }else{
            $this->error('修改失败');
        }
        
    }
    /**
     * 产品名称删除
     * @adminMenu(
     *     'name'   => '产品名称删除',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品名称删除',
     *     'param'  => ''
     * )
     */
    function delete(){
        $m=$this->m;
        $id=$this->request->param('id');
       $count=Db::name('goods_attr')->where('gid',$id)->count();
       if($count>0){
           $this->error('请先删除产品名称所属规格');
       }
       $info=$m->where('id',$id)->find();
        $row=$m->where('id='.$id)->delete();
        if($row===1){
            $data_action=[
                'aid'=>session('ADMIN_ID'),
                'time'=>time(),
                'type'=>'goods',
                'ip'=>get_client_ip(),
                'action'=>'删除产品-id'.$info['id'].'-name-'.$info['name'],
            ];
            Db::name('action')->insert($data_action);
            $this->success('删除成功');
        }else{
            $this->error('删除失败');
        }
       
    }
    
    /**
     * 产品名称添加
     * @adminMenu(
     *     'name'   => '产品名称添加',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品名称添加',
     *     'param'  => ''
     * )
     */
    public function add(){
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree();
        $this->assign('cates_tree',$catesTree);
        $this->assign('flag','产品名称');
        return $this->fetch();
    }
    
    /**
     * 产品名称添加1
     * @adminMenu(
     *     'name'   => '产品名称添加_执行',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品名称添加_执行',
     *     'param'  => ''
     * )
     */
    public function addPost(){
        
        $m=$this->m;
        $data= $this->request->param();
        
        $data['time']=time();
        $data['insert_time']=time();
        
        $insert=$m->insertGetId($data);
        if($insert>=1){
            $this->success('已成功添加，继续添加规格',url('attr_add',['id'=>$insert])); 
        }else{
            $this->error('添加失败');
        }
        exit;
    }
    
    
    /**
     * 产品规格
     * @adminMenu(
     *     'name'   => '产品规格',
     *     'parent' => 'default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品规格',
     *     'param'  => ''
     * )
     */
    function goods_attr(){
       
        $data=$this->request->param();
        $where=[];
        //已添加的规格 
        if(!empty($data['id'])){
            $where['g.id']=['eq', $data['id']];
        }
        //分类
        if(empty($data['cid'])){
            $data['cid']=0;
        }else{
            /*
             * 多表查询模糊查询喝in 索引？
             * //子类
             $where['c.path']=['like','%-'.$cid.'-%'];
             //或自身 */
            $path=Db::name('cate')->where('id',$data['cid'])->find();
            $cates=Db::name('cate')->where('path','like',$path['path'].'-%')->select();
            $cids=[$data['cid']];
            foreach($cates as $v){
                $cids[]=$v['id'];
            }
            $where['c.id']=['in',$cids];
        }
        
        //产品吗，名
        if(empty($data['gname'])){
            $data['gname']=''; 
        }else{
            $where['g.name']=['like','%'.$data['gname'].'%'];
        }
        
        $list=Db::name('goods_attr')
        ->alias('ga')
        ->field('ga.*,g.name as gname,c.name as cname,g.cid')
        ->join('cmf_goods g','g.id=ga.gid')
        ->join('cmf_cate c','c.id=g.cid')
        ->where($where)
        ->order('c.path asc,g.sort asc,g.id asc,ga.sort asc')
        ->paginate(10);
        $page = $list->appends($data)->render(); 
        if(!empty($data['id']) && !empty($list[0])){
            $data['gname']=$list[0]['gname'];
        }
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree($data['cid']);
        $this->assign('cates_tree',$catesTree); 
        $this->assign('list',$list); 
        $this->assign('page',$page);  
        $this->assign('gname',$data['gname']); 
        $this->assign('cid',$data['cid']); 
       
       
        return $this->fetch();
    }
    /**
     * 产品规格排序
     * @adminMenu(
     *     'name'   => '产品规格排序',
     *     'parent' => 'goods_attr',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品规格排序',
     *     'param'  => ''
     * )
     */
    public function sort()
    {
        parent::sorts(Db::name('goods_attr'));
        $this->success("排序更新成功！", '');
    }
    /**
     * 规格编辑
     * @adminMenu(
     *     'name'   => '规格编辑',
     *     'parent' => 'goods_attr',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '规格编辑',
     *     'param'  => ''
     * )
     */
    function attr_edit(){
        
        $id=$this->request->param('id',0,'intval');
        
        //已添加的规格
        $model= new GoodsAttrModel();
        $info=$model->attr($id);
        if (empty($info)) {
            $this->error('产品规格不存在');
        }
       
        $units=config('units'); 
        $this->assign('info',$info);
        $this->assign('units',$units);
       
        return $this->fetch();
    }

    /**
     * 规格编辑_执行
     * @adminMenu(
     * 'name' => '规格编辑_执行',
     * 'parent' => 'goods_attr',
     * 'display'=> false,
     * 'hasView'=> false,
     * 'order' => 10,
     * 'icon' => '',
     * 'remark' => '规格编辑_执行',
     * 'param' => ''
     * )
     */
    function attr_editPost()
    {
        $m=new GoodsAttrModel();
        $data = $this->request->param();
        $info = $m->get_gname($data['id']);
        if (empty($info)) {
            $this->error('产品或规格不存在');
        }
        $data['sn']=trim($data['sn']);
        if(empty($data['sn'])){
            if(empty($data['sn0'])){
                $this->error('条形码和自编码至少要输入一项');
            }
        }elseif(!preg_match('/^[0-9]{13}$/', $data['sn'])){
            $this->error('条形码编号错误');
        }
        
        $data['time']=time();
        
        try {
            $row = $m->where('id', $data['id'])->update($data);
            if($row!==1){
                throw \Exception('添加失败');
            }
        } catch (\Exception $e) {
            $this->error('保存失败!请确保条码编号和自编号唯一');
        }
        $data_action=[
            'aid'=>session('ADMIN_ID'),
            'time'=>time(),
            'type'=>'goods',
            'ip'=>get_client_ip(),
            'action'=>'编辑产品规格'.$info['gid'].'--'.$info['gname'].'--'.$info['id'].'--'.$info['attr'],
        ];
        Db::name('action')->insert($data_action);
        $size = config('goods_pic');
        $data['pic'] = zz_set_image($data['pic'], $data['pic'], $size['width'], $size['height'], 6);
        
        $this->success('保存成功',url('goods_attr'));
         
    }
    /**
     * 规格添加
     * @adminMenu(
     *     'name'   => '规格添加',
     *     'parent' => 'goods_attr',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '规格添加',
     *     'param'  => ''
     * )
     */
    function attr_add(){
        $id=$this->request->param('id');
        $m=$this->m;
        $info=$m->where('id',$id)->find();
       
        $units=config('units');
        $this->assign('units',$units);
        $this->assign('info',$info);
        return $this->fetch();
    }
    
    /**
     * 规格添加_执行
     * @adminMenu(
     * 'name' => '规格添加_执行',
     * 'parent' => 'goods_attr',
     * 'display'=> false,
     * 'hasView'=> false,
     * 'order' => 10,
     * 'icon' => '',
     * 'remark' => '规格添加_执行',
     * 'param' => ''
     * )
     */
    function attr_addPost()
    {
        $m = Db::name('goods_attr');
        $data = $this->request->param();
        $data['sn']=trim($data['sn']);
        if(empty($data['sn'])){
            if(empty($data['sn0'])){
                $this->error('条形码和自编码至少要输入一项');
            }
        }elseif(!preg_match('/^[0-9]{13}$/', $data['sn'])){ 
            $this->error('条形码编号错误');
        }
         $data['time']=time();
        $data['insert_time']= $data['time'];
        try {
            $row=$m->insertGetId($data);
            if($row<1){
                throw \Exception('添加失败');
            }
        } catch (\Exception $e) {
            $this->error('添加失败!请确保条码编号和自编号唯一');
        }
        $size = config('goods_pic');
        $data['pic'] = zz_set_image($data['pic'], $data['pic'], $size['width'], $size['height'], 6);
        
         $this->success('已成功添加');
         
         
    }
    /**
     * 产品规格删除
     * @adminMenu(
     *     'name'   => '产品规格删除',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品规格删除',
     *     'param'  => ''
     * )
     */
    function attr_delete(){
        $m1=new GoodsAttrModel();
        $id=$this->request->param('id');
       
        $count=Db::name('goods_store')->where('goods',$id)->count();
        if($count>0){
            $this->error('请先清除库存再删除');
        }
        $info=$m1->get_gname($id);
        $row=$m1->where('id',$id)->delete();
        if($row===1){
            $data_action=[
                'aid'=>session('ADMIN_ID'),
                'time'=>time(),
                'type'=>'goods',
                'ip'=>get_client_ip(),
                'action'=>'删除产品规格'.$info['gid'].'--'.$info['gname'].'--'.$info['id'].'--'.$info['attr'],
            ];
            Db::name('action')->insert($data_action);
            $this->success('删除成功');
        }else{
            $this->error('删除失败');
        }
        
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
        $data=$this->request->param();
        $where=[];
        //分类
        if(!empty($data['cid'])){
             
            $path=Db::name('cate')->where('id',$data['cid'])->find();
            $cates=Db::name('cate')->where('path','like',$path['path'].'-%')->select();
            $cids=[$data['cid']];
            foreach($cates as $v){
                $cids[]=$v['id'];
            }
            $where['c.id']=['in',$cids];
        }
        
        //产品吗，名
        if(!empty($data['gname'])){ 
            $where['g.name']=['like','%'.$data['gname'].'%'];
        }
        $list=Db::name('goods_attr')
        ->alias('ga')
        ->field('ga.*,g.name as gname,c.name as cname,g.cid')
        ->join('cmf_goods g','g.id=ga.gid')
        ->join('cmf_cate c','c.id=g.cid')
        ->where($where)
        ->order('c.path asc,g.sort asc,g.id asc,ga.sort asc')
        ->select();
        
        if(empty($list)){
            $this->error('没有数据');
        }
         
        ini_set('max_execution_time', '0');
        $title='产品规格表'.date('Ymd');
        $filename=$title.'.xls';
        $phpexcel = new PHPExcel();
        
        //设置文本格式
        $str=PHPExcel_Cell_DataType::TYPE_STRING;
        
        //设置第一个sheet
        $phpexcel->setActiveSheetIndex(0);
        $sheet= $phpexcel->getActiveSheet();
        //设置sheet表名
        $sheet->setTitle($title);
        //A18到E22为对角的整个长方形区域合并
        //$sheet->mergeCells('A18:E22');
        // 所有单元格默认高度
        $sheet->getDefaultRowDimension()->setRowHeight(18);
        $sheet->getDefaultColumnDimension()->setWidth(10);
        //序号，单位，数量宽度设小以节约空间
        $sheet->getColumnDimension('B')->setWidth(15);
        $sheet->getColumnDimension('C')->setWidth(15);
        $sheet->getColumnDimension('D')->setWidth(15);
        $sheet->getColumnDimension('E')->setWidth(30);
        $sheet->getColumnDimension('F')->setWidth(5);
      
        //设置第一行
        $i=1;
        
        
        //设置入库记录表头
      
        $sheet
        ->setCellValue('A'.$i, 'ID')
        ->setCellValue('B'.$i, '产品分类')
        ->setCellValue('C'.$i, '条码编号')
        ->setCellValue('D'.$i, '自编号')
        ->setCellValue('E'.$i, '产品名称--规格')
        ->setCellValue('F'.$i, '单位')
        ->setCellValue('G'.$i, '参考进价') 
        ->setCellValue('H'.$i, '参考售价');
        foreach($list as $k=>$v){
            $i++;
           
            $sheet
            ->setCellValueExplicit('A'.$i, $v['id'],$str)
            ->setCellValueExplicit('B'.$i, $v['cname'],$str)
            ->setCellValueExplicit('C'.$i, $v['sn'],$str)
            ->setCellValueExplicit('D'.$i, $v['sn0'],$str)
            ->setCellValueExplicit('E'.$i, $v['gname'].'--'.$v['attr'],$str)
            ->setCellValueExplicit('F'.$i, $v['unit'],$str)
            ->setCellValueExplicit('G'.$i, '￥'.$v['inprice'],$str)
            ->setCellValueExplicit('H'.$i, '￥'.$v['outprice'],$str);
            
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
        $sheet->getStyle('A1:H'.$i)->applyFromArray($styleArray);
        
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
     * 导出excel图片
     * @adminMenu(
     *     'name'   => '导出excel图片',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '导出excel图片',
     *     'param'  => ''
     * )
     */
    function excel0(){
        $data=$this->request->param();
        $where=[];
        //分类
        if(!empty($data['cid'])){
            
            $path=Db::name('cate')->where('id',$data['cid'])->find();
            $cates=Db::name('cate')->where('path','like',$path['path'].'-%')->select();
            $cids=[$data['cid']];
            foreach($cates as $v){
                $cids[]=$v['id'];
            }
            $where['c.id']=['in',$cids];
        }
        
        //产品吗，名
        if(!empty($data['gname'])){
            $where['g.name']=['like','%'.$data['gname'].'%'];
        }
        $list=Db::name('goods_attr')
        ->alias('ga')
        ->field('ga.*,g.name as gname,c.name as cname,g.cid')
        ->join('cmf_goods g','g.id=ga.gid')
        ->join('cmf_cate c','c.id=g.cid')
        ->where($where)
        ->order('c.path asc,g.sort asc,g.id asc,ga.sort asc')
        ->select();
        
        if(empty($list)){
            $this->error('没有数据');
        }
        
        ini_set('max_execution_time', '0');
        $title='产品规格表'.date('Ymd');
        $filename=$title.'.xls';
        $phpexcel = new PHPExcel();
        /*实例化插入图片类*/
        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $dir=getcwd().'/upload/';
        //设置文本格式
        $str=PHPExcel_Cell_DataType::TYPE_STRING;
        
        //设置第一个sheet
        $phpexcel->setActiveSheetIndex(0);
        $sheet= $phpexcel->getActiveSheet();
        //设置sheet表名
        $sheet->setTitle($title);
        //A18到E22为对角的整个长方形区域合并
        //$sheet->mergeCells('A18:E22');
        // 水平居中（位置很重要，建议在最初始位置）
        //$sheet->getStyle('A')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $sheet->getDefaultStyle()->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
         
        //垂直居中
        $sheet->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
        //自动换行
        $sheet->getDefaultStyle()->getAlignment()->setWrapText(true);
        // 所有单元格默认高度
        $sheet->getDefaultRowDimension()->setRowHeight(180);
        $sheet->getDefaultColumnDimension()->setWidth(10);
        //第一行
        $sheet->getRowDimension('1')->setRowHeight(40);
        //序号，单位，数量宽度设小以节约空间
        $sheet->getColumnDimension('B')->setWidth(15);
        $sheet->getColumnDimension('C')->setWidth(15);
        $sheet->getColumnDimension('D')->setWidth(15);
        $sheet->getColumnDimension('E')->setWidth(32);
        $sheet->getColumnDimension('F')->setWidth(30);
        $sheet->getColumnDimension('G')->setWidth(5);
      
        //设置第一行
        $i=1;
        
        
        //设置入库记录表头
        
        $sheet
        ->setCellValue('A'.$i, 'ID')
        ->setCellValue('B'.$i, '产品分类')
        ->setCellValue('C'.$i, '条码编号')
        ->setCellValue('D'.$i, '自编号')
        ->setCellValue('E'.$i, '产品图片')
        ->setCellValue('F'.$i, '产品名称--规格')
        ->setCellValue('G'.$i, '单位')
        ->setCellValue('H'.$i, '参考进价')
        ->setCellValue('I'.$i, '参考售价');
        foreach($list as $k=>$v){
            $i++;
            
            $sheet
            ->setCellValueExplicit('A'.$i, $v['id'],$str)
            ->setCellValueExplicit('B'.$i, $v['cname'],$str)
            ->setCellValueExplicit('C'.$i, $v['sn'],$str)
            ->setCellValueExplicit('D'.$i, $v['sn0'],$str) 
            ->setCellValueExplicit('F'.$i, $v['gname'].'--'.$v['attr'],$str)
            ->setCellValueExplicit('G'.$i, $v['unit'],$str)
            ->setCellValueExplicit('H'.$i, '￥'.$v['inprice'],$str)
            ->setCellValueExplicit('I'.$i, '￥'.$v['outprice'],$str);
            if(is_file($dir.$v['pic'])){
                
           
            /*设置图片路径 切记：只能是本地图片*/
            $objDrawing = new PHPExcel_Worksheet_Drawing();
            $objDrawing->setPath($dir.$v['pic']);
            /*设置图片高度*/
            
            $objDrawing->setHeight(200);//照片高度
            $objDrawing->setWidth(200); //照片宽度
           
            /*设置图片要插入的单元格*/
            $objDrawing->setCoordinates('E'.$i);
            /*设置图片所在单元格的格式*/
            $objDrawing->setOffsetX(10);
            $objDrawing->setOffsetY(10);
            $objDrawing->setRotation(0); 
            $objDrawing->setWorksheet($sheet);
             }
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
        $sheet->getStyle('A1:I'.$i)->applyFromArray($styleArray);
        
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

?>