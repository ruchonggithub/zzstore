<?php
 
namespace app\admin\controller;

 
use cmf\controller\AdminBaseController;
use app\admin\model\CateModel;
use think\Db;
 


class CateController extends AdminBaseController
{
    /**
     * 产品分类列表
     * @adminMenu(
     *     'name'   => '产品分类管理',
     *     'parent' => 'admin/goods/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 11,
     *     'icon'   => '',
     *     'remark' => '产品分类列表',
     *     'param'  => ''
     * )
     */
    public function index()
    {
        $CateModel = new CateModel();
        $cateTree        = $CateModel->adminCateTableTree();

        $this->assign('cate_tree', $cateTree);
        return $this->fetch();
    }

    /**
     * 添加产品分类
     * @adminMenu(
     *     'name'   => '添加产品分类',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '添加产品分类',
     *     'param'  => ''
     * )
     */
    public function add()
    {
        $parentId            = $this->request->param('parent', 0, 'intval');
        $CateModel = new CateModel();
        $catesTree      = $CateModel->adminCateTree($parentId);
 
        $this->assign('cates_tree', $catesTree);
        return $this->fetch();
    }

    /**
     * 添加产品分类提交
     * @adminMenu(
     *     'name'   => '添加产品分类提交',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '添加产品分类提交',
     *     'param'  => ''
     * )
     */
    public function addPost()
    {
        $CateModel = new CateModel();

        $data = $this->request->param();
        $data['time']=time();
        $data['insert_time']=$data['time'];
        $result = $this->validate($data, 'Cate');

        if ($result !== true) {
            $this->error($result);
        }

        $result = $CateModel->addCate($data);
        dump($result);exit;
        $this->error('添加失败!');
        if ($result === false) {
            $this->error('添加失败!');
        }

        $this->success('添加成功!');

    }

    /**
     * 编辑产品分类
     * @adminMenu(
     *     'name'   => '编辑产品分类',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '编辑产品分类',
     *     'param'  => ''
     * )
     */
    public function edit()
    {
        $id = $this->request->param('id', 0, 'intval');
        if ($id > 0) {
            $cate = CateModel::get($id)->toArray();

            $CateModel = new CateModel();
            $catesTree      = $CateModel->adminCateTree($cate['parent_id'], $id); 
            $this->assign($cate); 
            $this->assign('cates_tree', $catesTree);
            return $this->fetch();
        } else {
            $this->error('操作错误!');
        }

    }

    /**
     * 编辑产品分类提交
     * @adminMenu(
     *     'name'   => '编辑产品分类提交',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '编辑产品分类提交',
     *     'param'  => ''
     * )
     */
    public function editPost()
    {
        $data = $this->request->param();

        $result = $this->validate($data, 'Cate');

        if ($result !== true) {
            $this->error($result);
        }

        $CateModel = new CateModel();
        $data['time']=time();
        $result = $CateModel->editCate($data); 
        if ($result === false) {
            $this->error('保存失败!');
        }
       
        $this->success('保存成功!',url('index'));
    }

    /**
     * 产品分类选择对话框
     * @adminMenu(
     *     'name'   => '产品分类选择对话框',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品分类选择对话框',
     *     'param'  => ''
     * )
     */
    public function select()
    {
        $ids                 = $this->request->param('ids');
        $selectedIds         = explode(',', $ids);
        $CateModel = new CateModel();

        $tpl = <<<tpl
<tr class='data-item-tr'>
    <td>
        <input type='checkbox' class='js-check' data-yid='js-check-y' data-xid='js-check-x' name='ids[]'
               value='\$id' data-name='\$name' \$checked>
    </td>
    <td>\$id</td>
    <td>\$spacer <a href='\$url' target='_blank'>\$name</a></td>
</tr>
tpl;

        $cateTree = $CateModel->adminCateTableTree($selectedIds, $tpl);

       
        $cates = $CateModel->where()->select();

        $this->assign('cates', $cates);
        $this->assign('selectedIds', $selectedIds);
        $this->assign('cates_tree', $cateTree);
        return $this->fetch();
    }

    /**
     * 产品分类排序
     * @adminMenu(
     *     'name'   => '产品分类排序',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '产品分类排序',
     *     'param'  => ''
     * )
     */
    public function sort()
    {
        parent::sorts(Db::name('cate'));
        $this->success("排序更新成功！", '');
    }

    /**
     * 删除产品分类
     * @adminMenu(
     *     'name'   => '删除产品分类',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10,
     *     'icon'   => '',
     *     'remark' => '删除产品分类',
     *     'param'  => ''
     * )
     */
    public function delete()
    {
        $CateModel = new CateModel();
        $id                  = $this->request->param('id');
        //获取删除的内容
        $findCate = $CateModel->where('id', $id)->find();

        if (empty($findCate)) {
            $this->error('分类不存在!');
        }

        $cateChildrenCount = $CateModel->where('parent_id', $id)->count();

        if ($cateChildrenCount > 0) {
            $this->error('此分类有子类无法删除!');
        }

        $goodsCount = Db::name('goods')->where('cid', $id)->count();

        if ($goodsCount > 0) {
            $this->error('此分类有产品无法删除!');
        }

        
        $result = $CateModel
            ->where('id', $id)
            ->delete();
        if ($result) { 
            $this->success('删除成功!');
        } else {
            $this->error('删除失败');
        }
    }
}
