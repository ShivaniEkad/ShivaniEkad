<?php
/* Smarty version 3.1.28, created on 2021-08-04 06:35:02
  from "/var/www/html/Appineers_V4_Web/Appineers_V4/application/admin/user/views/admin_add_buttons.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.28',
  'unifunc' => 'content_610a351603d5b9_02869932',
  'file_dependency' => 
  array (
    'd6401c72aa6d73743d1fa239bffda700d46dc83d' => 
    array (
      0 => '/var/www/html/Appineers_V4_Web/Appineers_V4/application/admin/user/views/admin_add_buttons.tpl',
      1 => 1626450606,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_610a351603d5b9_02869932 ($_smarty_tpl) {
?>
<!-- Form Redirection Control Unit -->
<?php if ($_smarty_tpl->tpl_vars['controls_allow']->value == false || $_smarty_tpl->tpl_vars['rm_ctrl_directions']->value == true) {?>
    <input value="<?php echo $_smarty_tpl->tpl_vars['ctrl_flow']->value;?>
" id="ctrl_flow_stay" name="ctrl_flow" type="hidden" />
<?php } else { ?>
    <div class='action-dir-align'>
        <?php if ($_smarty_tpl->tpl_vars['prev_link_allow']->value == true) {?>
            <input value="Prev" id="ctrl_flow_prev" name="ctrl_flow" class="regular-radio" type="radio" <?php if ($_smarty_tpl->tpl_vars['ctrl_flow']->value == 'Prev') {?> checked=true <?php }?> />
            <label for="ctrl_flow_prev">&nbsp;</label><label for="ctrl_flow_prev" class="inline-elem-margin"><?php echo $_smarty_tpl->tpl_vars['this']->value->lang->line('GENERIC_PREV_SHORT');?>
</label>&nbsp;&nbsp;
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['next_link_allow']->value == true || $_smarty_tpl->tpl_vars['mode']->value == 'Add') {?>
            <input value="Next" id="ctrl_flow_next" name="ctrl_flow" class="regular-radio" type="radio" <?php if ($_smarty_tpl->tpl_vars['ctrl_flow']->value == 'Next') {?> checked=true <?php }?> />
            <label for="ctrl_flow_next">&nbsp;</label><label for="ctrl_flow_next" class="inline-elem-margin"><?php echo $_smarty_tpl->tpl_vars['this']->value->lang->line('GENERIC_NEXT_SHORT');?>
</label>&nbsp;&nbsp;
        <?php }?>
        <input value="List" id="ctrl_flow_list" name="ctrl_flow" class="regular-radio" type="radio" <?php if ($_smarty_tpl->tpl_vars['ctrl_flow']->value == 'List') {?> checked=true <?php }?> />
        <label for="ctrl_flow_list">&nbsp;</label><label for="ctrl_flow_list" class="inline-elem-margin"><?php echo $_smarty_tpl->tpl_vars['this']->value->lang->line('GENERIC_LIST_SHORT');?>
</label>&nbsp;&nbsp;
        <input value="Stay" id="ctrl_flow_stay" name="ctrl_flow" class="regular-radio" type="radio" <?php if ($_smarty_tpl->tpl_vars['ctrl_flow']->value == '' || $_smarty_tpl->tpl_vars['ctrl_flow']->value == 'Stay') {?> checked=true <?php }?> />
        <label for="ctrl_flow_stay">&nbsp;</label><label for="ctrl_flow_stay" class="inline-elem-margin"><?php echo $_smarty_tpl->tpl_vars['this']->value->lang->line('GENERIC_STAY_SHORT');?>
</label>
    </div>
<?php }?>
<!-- Form Action Control Unit -->
<?php if ($_smarty_tpl->tpl_vars['controls_allow']->value == false) {?>
    <div class="clear"></div>
<?php }?>
<div class="action-btn-align" id="action_btn_container">
    <?php if ($_smarty_tpl->tpl_vars['mode']->value == 'Update') {?>
        <?php if ($_smarty_tpl->tpl_vars['update_allow']->value == true) {?>
            <input value="<?php echo $_smarty_tpl->tpl_vars['this']->value->lang->line('GENERIC_UPDATE');?>
" name="ctrlupdate" type="submit" id="frmbtn_update" class="btn btn-info"/>&nbsp;&nbsp;
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['delete_allow']->value == true) {?>
            <input value="<?php echo $_smarty_tpl->tpl_vars['this']->value->lang->line('GENERIC_DELETE');?>
" name="ctrldelete" type="button" id="frmbtn_delete" class="btn btn-danger" onclick="return deleteAdminRecordData('<?php echo $_smarty_tpl->tpl_vars['enc_id']->value;?>
', '<?php echo $_smarty_tpl->tpl_vars['mod_enc_url']->value['index'];?>
','<?php echo $_smarty_tpl->tpl_vars['mod_enc_url']->value['inline_edit_action'];?>
', '<?php echo $_smarty_tpl->tpl_vars['extra_qstr']->value;?>
', '<?php echo $_smarty_tpl->tpl_vars['extra_hstr']->value;?>
');" />&nbsp;&nbsp;
        <?php }?>
    <?php } else { ?>
    <input value="<?php echo $_smarty_tpl->tpl_vars['this']->value->lang->line('GENERIC_SAVE');?>
" name="ctrladd" type="submit" id="frmbtn_add" class="btn btn-info" />&nbsp;&nbsp;
    <?php }?>
    <?php if ($_smarty_tpl->tpl_vars['discard_allow']->value == true) {?>
        <input value="<?php echo $_smarty_tpl->tpl_vars['this']->value->lang->line('GENERIC_DISCARD');?>
" name="ctrldiscard" type="button" id="frmbtn_discard" class="btn" onclick="return loadAdminModuleListing('<?php echo $_smarty_tpl->tpl_vars['mod_enc_url']->value['index'];?>
', '<?php echo $_smarty_tpl->tpl_vars['extra_hstr']->value;?>
')" />
    <?php }?>
</div>            <?php }
}
