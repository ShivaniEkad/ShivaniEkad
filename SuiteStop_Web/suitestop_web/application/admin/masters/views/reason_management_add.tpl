<%if $this->input->is_ajax_request()%>
    <%$this->js->clean_js()%>
<%/if%>
<div class="module-form-container">
    <%include file="reason_management_add_strip.tpl"%>
    <div class="<%$module_name%>" data-form-name="<%$module_name%>">
        <div id="ajax_content_div" class="ajax-content-div top-frm-spacing" >
            <input type="hidden" id="projmod" name="projmod" value="users_management" />
            <!-- Page Loader -->
            <div id="ajax_qLoverlay"></div>
            <div id="ajax_qLbar"></div>
            <!-- Module Tabs & Top Detail View -->
            <div class="top-frm-tab-layout" id="top_frm_tab_layout">
            </div>
            <!-- Middle Content -->
            <div id="scrollable_content" class="scrollable-content popup-content top-block-spacing ">
                <div id="users_management" class="frm-module-block frm-elem-block frm-stand-view">
                    <!-- Module Form Block -->
                    <form name="frmaddupdate" id="frmaddupdate" action="<%$admin_url%><%$mod_enc_url['add_action']%>?<%$extra_qstr%>" method="post"  enctype="multipart/form-data">
                        <!-- Form Hidden Fields Unit -->
                        <input type="hidden" id="id" name="id" value="<%$enc_id%>" />
                        <input type="hidden" id="mode" name="mode" value="<%$mod_enc_mode[$mode]%>" />
                        <input type="hidden" id="ctrl_prev_id" name="ctrl_prev_id" value="<%$next_prev_records['prev']['id']%>" />
                        <input type="hidden" id="ctrl_next_id" name="ctrl_next_id" value="<%$next_prev_records['next']['id']%>" />
                        <input type="hidden" id="draft_uniq_id" name="draft_uniq_id" value="<%$draft_uniq_id%>" />
                        <input type="hidden" id="extra_hstr" name="extra_hstr" value="<%$extra_hstr%>" />
                        
                        <input type="hidden" name="i_added_at" id="i_added_at" value="<%$this->general->dateDefinedFormat('Y-m-d',$data['i_added_at'])%>"  class='ignore-valid '  aria-date-format='yy-mm-dd'  aria-format-type='date' />
                      
                        <!-- Form Dispaly Fields Unit -->
                        <div class="main-content-block " id="main_content_block">
                            <div style="width:98%" class="frm-block-layout pad-calc-container">
                                <div class="box gradient <%$rl_theme_arr['frm_stand_content_row']%> <%$rl_theme_arr['frm_stand_border_view']%>">
                                    <div class="title <%$rl_theme_arr['frm_stand_titles_bar']%>"><h4><%$this->lang->line('REASON_MANAGEMENT_REASON_MANAGEMENT')%></h4></div>
                                    <div class="content <%$rl_theme_arr['frm_stand_label_align']%>">
                                        
                                            <div class="form-row row-fluid " id="cc_sh_i_reason_name">
                                                <label class="form-label span3 ">
                                                    <%$form_config['i_reason_name']['label_lang']%> <em>*</em> 
                                                </label> 
                                                <div class="form-right-div  <%if $mode eq 'Update'%>frm-elements-div<%/if%> ">
                                                
                                                        <input type="text" placeholder="" value="<%$data['i_reason_name']|@htmlentities%>" name="i_reason_name" id="i_reason_name" title="<%$this->lang->line('REASON_MANAGEMENT_NAME')%>"  data-ctrl-type='textbox'  class='frm-size-medium'  />
                                                </div>
                                                <div class="error-msg-form "><label class='error' id='i_reason_nameErr'></label></div>
                                            </div> 

                                            <div class="form-row row-fluid " id="cc_sh_i_reason_entity_type">
                                                <label class="form-label span3 ">
                                                    <%$form_config['i_reason_entity_type']['label_lang']%> <em>*</em> 
                                                </label> 
                                                 <div class="form-right-div  ">
                                                    <%if $mode eq 'Update'%>
                                                     <%$this->dropdown->display("i_reason_entity_type","i_reason_entity_type","  title='<%$this->lang->line('REASON_MANAGEMENT_ENTITY_TYPE')%>'  aria-chosen-valid='Yes'  class='chosen-select frm-size-medium'  data-placeholder='<%$this->general->parseLabelMessage('GENERIC_PLEASE_SELECT__C35FIELD_C35' ,'#FIELD#', 'REASON_MANAGEMENT_ENTITY_TYPE')%>'  ", "|||", "", $opt_selected,"i_reason_entity_type")%>
                                                     <%else%>
                                                    <%$this->dropdown->display("i_reason_entity_type","i_reason_entity_type[]","multiple","  title='<%$this->lang->line('REASON_MANAGEMENT_ENTITY_TYPE')%>'  aria-chosen-valid='Yes'  class='chosen-select frm-size-medium'  data-placeholder='<%$this->general->parseLabelMessage('GENERIC_PLEASE_SELECT__C35FIELD_C35' ,'#FIELD#', 'REASON_MANAGEMENT_ENTITY_TYPE')%>'  ", "|||", "", $opt_selected,"i_reason_entity_type")%> 
                                                    <%/if%>
                                                   
                                                </div>
                                               
                                                <div class="error-msg-form "><label class='error' id='i_reason_entity_typeErr'></label></div>
                                            </div> 


                                            <div class="form-row row-fluid " id="cc_sh_i_reason_status">
                                                <label class="form-label span3 ">
                                                    <%$form_config['i_reason_status']['label_lang']%> <em>*</em> 
                                                </label> 
                                                <div class="form-right-div  ">
                                                    <%assign var="opt_selected" value=$data['i_reason_statu']%>
                                                    <%$this->dropdown->display("i_reason_status","i_reason_status","  title='<%$this->lang->line('REASON_MANAGEMENT_STATUS')%>'  aria-chosen-valid='Yes'  class='chosen-select frm-size-medium'  data-placeholder='<%$this->general->parseLabelMessage('GENERIC_PLEASE_SELECT__C35FIELD_C35' ,'#FIELD#', 'REASON_MANAGEMENT_STATUS')%>'  ", "|||", "", $opt_selected,"i_reason_statu")%>
                                                </div>
                                                <div class="error-msg-form "><label class='error' id='i_reason_statuErr'></label></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <div class="frm-bot-btn <%$rl_theme_arr['frm_stand_action_bar']%> <%$rl_theme_arr['frm_stand_action_btn']%> popup-footer">
                                    <%if $rl_theme_arr['frm_stand_ctrls_view'] eq 'No'%>
                                        <%assign var='rm_ctrl_directions' value=true%>
                                    <%/if%>
                                    <%include file="reason_management_add_buttons.tpl"%>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- Module Form Javascript -->
<%javascript%>
            
    var el_form_settings = {}, elements_uni_arr = {}, child_rules_arr = {}, google_map_json = {}, pre_cond_code_arr = [];
    el_form_settings['module_name'] = '<%$module_name%>'; 
    el_form_settings['extra_hstr'] = '<%$extra_hstr%>';
    el_form_settings['extra_qstr'] = '<%$extra_qstr%>';
    el_form_settings['upload_form_file_url'] = admin_url+"<%$mod_enc_url['upload_form_file']%>?<%$extra_qstr%>";
    el_form_settings['get_chosen_auto_complete_url'] = admin_url+"<%$mod_enc_url['get_chosen_auto_complete']%>?<%$extra_qstr%>";
    el_form_settings['token_auto_complete_url'] = admin_url+"<%$mod_enc_url['get_token_auto_complete']%>?<%$extra_qstr%>";
    el_form_settings['tab_wise_block_url'] = admin_url+"<%$mod_enc_url['get_tab_wise_block']%>?<%$extra_qstr%>";
    el_form_settings['parent_source_options_url'] = "<%$mod_enc_url['parent_source_options']%>?<%$extra_qstr%>";
    el_form_settings['jself_switchto_url'] =  admin_url+'<%$switch_cit["url"]%>';
    el_form_settings['callbacks'] = [];
    
    google_map_json = $.parseJSON('<%$google_map_arr|@json_encode%>');
    child_rules_arr = {};
            
    <%if $auto_arr|@is_array && $auto_arr|@count gt 0%>
        setTimeout(function(){
            <%foreach name=i from=$auto_arr item=v key=k%>
                if($("#<%$k%>").is("select")){
                    $("#<%$k%>").ajaxChosen({
                        dataType: "json",
                        type: "POST",
                        url: el_form_settings.get_chosen_auto_complete_url+"&unique_name=<%$k%>&mode=<%$mod_enc_mode[$mode]%>&id=<%$enc_id%>"
                        },{
                        loadingImg: admin_image_url+"chosen-loading.gif"
                    });
                }
            <%/foreach%>
        }, 500);
    <%/if%>        
    el_form_settings['jajax_submit_func'] = '';
    el_form_settings['jajax_submit_back'] = '';
    el_form_settings['jajax_action_url'] = '<%$admin_url%><%$mod_enc_url["add_action"]%>?<%$extra_qstr%>';
    el_form_settings['save_as_draft'] = 'No';
    el_form_settings['buttons_arr'] = [];
    el_form_settings['message_arr'] = {
        "delete_message" : "<%$this->general->processMessageLabel('ACTION_ARE_YOU_SURE_WANT_TO_DELETE_THIS_RECORD_C63')%>",
    };
    
    callSwitchToSelf();
<%/javascript%>
<%$this->js->add_js('admin/reason_add_js.js')%>
<%if $this->input->is_ajax_request()%>
    <%$this->js->js_src()%>
<%/if%> 
<%if $this->input->is_ajax_request()%>
    <%$this->css->css_src()%>
<%/if%> 
<%javascript%>
    Project.modules.reason_management.callEvents();
<%/javascript%>