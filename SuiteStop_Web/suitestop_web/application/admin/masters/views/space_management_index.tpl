<%if $this->input->is_ajax_request()%>
    <%$this->js->clean_js()%>
<%/if%>
<div class="module-list-container">
    <%include file="space_management_index_strip.tpl"%>
    <!-- Grid View HTML Block -->
    <div id="layout_grid_list2" class="perm-elem-hide">                        
        <style>
            .payroll-box-inn{height:290px !important;}
            /*.uigrid-status-btn-active,.uigrid-status-btn-inactive,.uigrid-status-btn-archived{display: none;}*/
        </style>
    </div>
    <div class="<%$module_name%>" data-list-name="<%$module_name%>">
        <div id="ajax_content_div" class="ajax-content-div top-frm-spacing box gradient">
            <!-- Page Loader -->
            <div id="ajax_qLoverlay"></div>
            <div id="ajax_qLbar"></div>
            <!-- Middle Content -->
            <div id="scrollable_content" class="scrollable-content top-list-spacing">
                <div class="grid-data-container pad-calc-container">
                    <div class="top-list-tab-layout" id="top_list_grid_layout">
                    </div>
                    <table class="grid-table-view " width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <!-- Module Listing Block -->
                            <td id="grid_data_col" class="<%$rl_theme_arr['grid_search_toolbar']%>">
                                <div id="pager2"></div>
                                <table id="list2"></table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <input type="hidden" name="selAllRows" value="" id="selAllRows" />
    </div>
</div>
<!-- Module Listing Javascript -->
<%javascript%>
    $.jgrid.no_legacy_api = true; $.jgrid.useJSON = true;
    var el_grid_settings = {}, js_col_model_json = {}, js_col_name_json = {}; 
                    
    el_grid_settings['module_name'] = '<%$module_name%>';
    el_grid_settings['extra_hstr'] = '<%$extra_hstr%>';
    el_grid_settings['extra_qstr'] = '<%$extra_qstr%>';
    el_grid_settings['enc_location'] = '<%$enc_loc_module%>';
    el_grid_settings['par_module '] = '<%$this->general->getAdminEncodeURL($parMod)%>';
    el_grid_settings['par_data'] = '<%$this->general->getAdminEncodeURL($parID)%>';
    el_grid_settings['par_field'] = '<%$parField%>';
    el_grid_settings['par_type'] = 'parent';

    el_grid_settings['index_page_url'] = '<%$mod_enc_url["index"]%>';
    el_grid_settings['add_page_url'] = '<%$mod_enc_url["add"]%>'; 
    el_grid_settings['edit_page_url'] =  admin_url+'<%$mod_enc_url["inline_edit_action"]%>?<%$extra_qstr%>';
    el_grid_settings['listing_url'] = admin_url+'<%$mod_enc_url["listing"]%>?<%$extra_qstr%>';
   
        
    el_grid_settings['search_refresh_url'] = admin_url+'<%$mod_enc_url["get_left_search_content"]%>?<%$extra_qstr%>';
    el_grid_settings['search_autocomp_url'] = admin_url+'<%$mod_enc_url["get_search_auto_complete"]%>?<%$extra_qstr%>';
    el_grid_settings['ajax_data_url'] = admin_url+'<%$mod_enc_url["get_chosen_auto_complete"]%>?<%$extra_qstr%>';
    el_grid_settings['auto_complete_url'] = admin_url+'<%$mod_enc_url["get_token_auto_complete"]%>?<%$extra_qstr%>';
    el_grid_settings['subgrid_listing_url'] =  admin_url+'<%$mod_enc_url["get_subgrid_block"]%>?<%$extra_qstr%>';
    el_grid_settings['jparent_switchto_url'] = admin_url+'<%$parent_switch_cit["url"]%>?<%$extra_qstr%>';
    
    el_grid_settings['admin_rec_arr'] = $.parseJSON('<%$hide_admin_rec|@json_encode%>');;
    el_grid_settings['status_arr'] = $.parseJSON('<%$status_array|@json_encode%>');
    el_grid_settings['status_lang_arr'] = $.parseJSON('<%$status_label|@json_encode%>');
                
     el_grid_settings['hide_add_btn'] = '';
    el_grid_settings['hide_del_btn'] = '';
    el_grid_settings['hide_status_btn'] = '1';
    el_grid_settings['hide_export_btn'] = '1';
    el_grid_settings['hide_columns_btn'] = 'Yes';
    
    el_grid_settings['show_saved_search'] = 'No';
    el_grid_settings['hide_advance_search'] = 'No';
    el_grid_settings['hide_search_tool'] = 'No';
    el_grid_settings['hide_multi_select'] = '<%$capabilities.hide_multi_select%>';
    el_grid_settings['hide_paging_btn'] = 'No';
    el_grid_settings['hide_refresh_btn'] = 'No';
    
    el_grid_settings['popup_add_form'] = 'No';
    el_grid_settings['popup_edit_form'] = 'No';
    el_grid_settings['popup_add_size'] = ['75%', '75%'];
    el_grid_settings['popup_edit_size'] = ['75%', '75%'];
    
    el_grid_settings['permit_add_btn'] = '<%$add_access%>';
    el_grid_settings['permit_del_btn'] = '<%$del_access%>';
    el_grid_settings['permit_edit_btn'] = '<%$edit_access%>';
    el_grid_settings['permit_view_btn'] = '<%$view_access%>';
    el_grid_settings['permit_expo_btn'] = '<%$expo_access%>';
    el_grid_settings['permit_print_btn'] = '<%$print_access%>';
        
    el_grid_settings['serial_number'] = 'No';
    el_grid_settings['group_search'] = '';
    el_grid_settings['default_sort'] = 'created_at';
    el_grid_settings['sort_order'] = 'asc';
    el_grid_settings['footer_row'] = 'No';
    el_grid_settings['grouping'] = 'No';
    el_grid_settings['group_attr'] = {};
    
    el_grid_settings['inline_add'] = 'No';
    el_grid_settings['rec_position'] = 'Top';
    el_grid_settings['auto_width'] = 'Yes';
    el_grid_settings['auto_refresh'] = 'No';
    el_grid_settings['lazy_loading'] = 'No';
    el_grid_settings['print_rec'] = 'No';
    el_grid_settings['print_list'] = 'No';
    
    el_grid_settings['subgrid'] = '<%$capabilities.subgrid%>';
    el_grid_settings['colgrid'] = 'No';
    el_grid_settings['listview'] = 'list';
    el_grid_settings['rating_allow'] = 'No';
    el_grid_settings['global_filter'] = 'No';
    
    el_grid_settings['search_slug'] = '<%$search_slug%>';
    el_grid_settings['search_list'] = $.parseJSON('<%$search_preferences|@json_encode%>');
    el_grid_settings['filters_arr'] = $.parseJSON('<%$default_filters|@json_encode%>');
    el_grid_settings['top_filter'] = [];
    el_grid_settings['buttons_arr'] = [];
    el_grid_settings['callbacks'] = [];
    el_grid_settings['message_arr'] = {
        "delete_alert" : "<%$this->general->processMessageLabel('ACTION_PLEASE_SELECT_ANY_RECORD')%>",
        "delete_popup" : "<%$this->general->processMessageLabel('ACTION_ARE_YOU_SURE_WANT_TO_DELETE_THIS_RECORD_C63')%>",
        "status_alert" : "<%$this->general->processMessageLabel('ACTION_PLEASE_SELECT_ANY_RECORD_TO__C35STATUS_C35')%>",
        "status_popup" : "<%$this->general->processMessageLabel('ACTION_ARE_YOU_SURE_WANT_TO__C35STATUS_C35_THIS_RECORDS_C63')%>",
    };
    
    js_col_name_json = [
    {
        "name": "first_name",
        "label": "<%$list_config['first_name']['label_lang']%>"
    },
    {
        "name": "space_name",
        "label": "<%$list_config['space_name']['label_lang']%>"
    },
    {
        "name": "address",
        "label": "<%$list_config['address']['label_lang']%>"
    },
    {
        "name": "city",
        "label": "<%$list_config['city']['label_lang']%>"
    },
     {
        "name": "state",
        "label": "<%$list_config['state']['label_lang']%>"
    },
     {
        "name": "zipcode",
        "label": "<%$list_config['zipcode']['label_lang']%>"
    },
     {
        "name": "stylist_required",
        "label": "<%$list_config['stylist_required']['label_lang']%>"
    },
     {
        "name": "space_details",
        "label": "<%$list_config['space_details']['label_lang']%>"
    },
    {
        "name": "status",
        "label": "<%$list_config['status']['label_lang']%>"
    },
    {
        "name": "created_at",
        "label": "<%$list_config['created_at']['label_lang']%>"
    },

    ];
    
    js_col_model_json = [
    {
        "name": "first_name",
        "index": "first_name",
        "label": "<%$list_config['first_name']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['first_name']['width']%>",
        "search": <%if $list_config['first_name']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['first_name']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['first_name']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['first_name']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['first_name']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['first_name']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['first_name']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_USER_NAME)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "first_name",
                "autocomplete": "off"
            },
            "sopt": strSearchOpts,
            "searchhidden": <%if $list_config['first_name']['search'] eq 'Yes' %>true<%else%>false<%/if%>
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "first_name",
            "placeholder": "",
            "class": "inline-edit-row "
        },
        "ctrl_type": "textbox",
        "default_value": "<%$list_config['first_name']['default']%>",
        "filterSopt": "bw",
        "formatter": formatAdminModuleEditLink,
        "unformat": unformatAdminModuleEditLink
    }, 
    {
        "name": "space_name",
        "index": "space_name",
        "label": "<%$list_config['space_name']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['space_name']['width']%>",
        "search": <%if $list_config['space_name']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['space_name']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['space_name']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['space_name']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['space_name']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['space_name']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['space_name']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_NAME)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "space_name",
                "autocomplete": "off"
            },
            "sopt": strSearchOpts,
            "searchhidden": <%if $list_config['space_name']['search'] eq 'Yes' %>true<%else%>false<%/if%>
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "space_name",
            "placeholder": "",
            "class": "inline-edit-row "
        },
        "ctrl_type": "textbox",
        "default_value": "<%$list_config['space_name']['default']%>",
        "filterSopt": "bw",
        "formatter": formatAdminModuleEditLink,
        "unformat": unformatAdminModuleEditLink
    },  
    {
        "name": "address",
        "index": "address",
        "label": "<%$list_config['address']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['address']['width']%>",
        "search": <%if $list_config['address']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['address']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['address']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['address']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['address']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['address']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['address']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_ADDRESS)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "address",
                "autocomplete": "off"
            },
            "sopt": strSearchOpts,
            "searchhidden": <%if $list_config['address']['search'] eq 'Yes' %>true<%else%>false<%/if%>
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "address",
            "placeholder": "",
            "class": "inline-edit-row "
        },
        "ctrl_type": "textbox",
        "default_value": "<%$list_config['address']['default']%>",
        "filterSopt": "bw",
        "formatter": formatAdminModuleEditLink,
        "unformat": unformatAdminModuleEditLink
    }, 
    {
        "name": "city",
        "index": "city",
        "label": "<%$list_config['city']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['city']['width']%>",
        "search": <%if $list_config['city']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['city']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['city']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['city']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['city']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['city']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['city']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_CITY)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "city",
                "autocomplete": "off"
            },
            "sopt": strSearchOpts,
            "searchhidden": <%if $list_config['city']['search'] eq 'Yes' %>true<%else%>false<%/if%>
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "city",
            "placeholder": "",
            "class": "inline-edit-row "
        },
        "ctrl_type": "textbox",
        "default_value": "<%$list_config['city']['default']%>",
        "filterSopt": "bw",
        "formatter": formatAdminModuleEditLink,
        "unformat": unformatAdminModuleEditLink
    },
    {
        "name": "state",
        "index": "state",
        "label": "<%$list_config['state']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['state']['width']%>",
        "search": <%if $list_config['state']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['state']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['state']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['state']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['state']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['state']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['state']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_STATE)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "state",
                "autocomplete": "off"
            },
            "sopt": strSearchOpts,
            "searchhidden": <%if $list_config['state']['search'] eq 'Yes' %>true<%else%>false<%/if%>
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "state",
            "placeholder": "",
            "class": "inline-edit-row "
        },
        "ctrl_type": "textbox",
        "default_value": "<%$list_config['state']['default']%>",
        "filterSopt": "bw",
        "formatter": formatAdminModuleEditLink,
        "unformat": unformatAdminModuleEditLink
    },
    {
        "name": "zipcode",
        "index": "zipcode",
        "label": "<%$list_config['zipcode']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['zipcode']['width']%>",
        "search": <%if $list_config['zipcode']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['zipcode']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['zipcode']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['zipcode']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['zipcode']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['zipcode']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['zipcode']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_ZIPCODE)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "zipcode",
                "autocomplete": "off"
            },
            "sopt": strSearchOpts,
            "searchhidden": <%if $list_config['zipcode']['search'] eq 'Yes' %>true<%else%>false<%/if%>
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "zipcode",
            "placeholder": "",
            "class": "inline-edit-row "
        },
        "ctrl_type": "textbox",
        "default_value": "<%$list_config['zipcode']['default']%>",
        "filterSopt": "bw",
        "formatter": formatAdminModuleEditLink,
        "unformat": unformatAdminModuleEditLink
    },
    {
        "name": "stylist_required",
        "index": "stylist_required",
        "label": "<%$list_config['stylist_required']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['stylist_required']['width']%>",
        "search": <%if $list_config['stylist_required']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['stylist_required']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['stylist_required']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['stylist_required']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['stylist_required']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['stylist_required']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['stylist_required']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_STYLIST_REQUIRED)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "stylist_required",
                "autocomplete": "off"
            },
            "sopt": strSearchOpts,
            "searchhidden": <%if $list_config['stylist_required']['search'] eq 'Yes' %>true<%else%>false<%/if%>
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "stylist_required",
            "placeholder": "",
            "class": "inline-edit-row "
        },
        "ctrl_type": "textbox",
        "default_value": "<%$list_config['stylist_required']['default']%>",
        "filterSopt": "bw",
        "formatter": formatAdminModuleEditLink,
        "unformat": unformatAdminModuleEditLink
    },
    {
        "name": "space_details",
        "index": "space_details",
        "label": "<%$list_config['space_details']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['space_details']['width']%>",
        "search": <%if $list_config['space_details']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['space_details']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['space_details']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['space_details']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['space_details']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['space_details']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['space_details']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_DETAILS)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "space_details",
                "autocomplete": "off"
            },
            "sopt": strSearchOpts,
            "searchhidden": <%if $list_config['space_details']['search'] eq 'Yes' %>true<%else%>false<%/if%>
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "space_details",
            "placeholder": "",
            "class": "inline-edit-row "
        },
        "ctrl_type": "textbox",
        "default_value": "<%$list_config['space_details']['default']%>",
        "filterSopt": "bw",
        "formatter": formatAdminModuleEditLink,
        "unformat": unformatAdminModuleEditLink
    },
    {
        "name": "status",
        "index": "status",
        "label": "<%$list_config['status']['label_lang']%>",
        "labelClass": "header-align-center",
        "resizable": true,
        "width": "<%$list_config['status']['width']%>",
        "search": <%if $list_config['status']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['status']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['status']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['status']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['status']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['status']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['status']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "center",
        "edittype": "select",
        "editrules": {
            "required": true,
            "infoArr": {
                "required": {
                    "message": ci_js_validation_message(js_lang_label.GENERIC_PLEASE_ENTER_A_VALUE_FOR_THE__C35FIELD_C35_FIELD_C46 ,"#FIELD#",js_lang_label.SPACE_MANAGEMENT_STATUS)
                }
            }
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "status",
                "autocomplete": "off",
                "data-placeholder": " ",
                "class": "search-chosen-select",
                "multiple": "multiple"
            },
            "sopt": intSearchOpts,
            "searchhidden": <%if $list_config['status']['search'] eq 'Yes' %>true<%else%>false<%/if%>,
            "dataUrl": <%if $count_arr["status"]["json"] eq "Yes" %>false<%else%>'<%$admin_url%><%$mod_enc_url["get_list_options"]%>?alias_name=status&mode=<%$mod_enc_mode["Search"]%>&rformat=html<%$extra_qstr%>'<%/if%>,
            "value": <%if $count_arr["status"]["json"] eq "Yes" %>$.parseJSON('<%$count_arr["status"]["data"]|@addslashes%>')<%else%>null<%/if%>,
            "dataInit": <%if $count_arr['status']['ajax'] eq 'Yes' %>initSearchGridAjaxChosenEvent<%else%>initGridChosenEvent<%/if%>,
            "ajaxCall": '<%if $count_arr["status"]["ajax"] eq "Yes" %>ajax-call<%/if%>',
            "multiple": true
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "status",
            "dataUrl": '<%$admin_url%><%$mod_enc_url["get_list_options"]%>?alias_name=status&mode=<%$mod_enc_mode["Update"]%>&rformat=html<%$extra_qstr%>',
            "dataInit": <%if $count_arr['status']['ajax'] eq 'Yes' %>initEditGridAjaxChosenEvent<%else%>initGridChosenEvent<%/if%>,
            "ajaxCall": '<%if $count_arr["status"] eq "Yes" %>ajax-call<%/if%>',
            "data-placeholder": "<%$this->general->parseLabelMessage('GENERIC_PLEASE_SELECT__C35FIELD_C35' ,'#FIELD#', 'SPACE_MANAGEMENT_STATUS')%>",
            "class": "inline-edit-row chosen-select"
        },
        "ctrl_type": "dropdown",
        "default_value": "<%$list_config['status']['default']%>",
        "filterSopt": "in",
        "stype": "select"
    },     
    {
        "name": "created_at",
        "index": "created_at",
        "label": "<%$list_config['created_at']['label_lang']%>",
        "labelClass": "header-align-left",
        "resizable": true,
        "width": "<%$list_config['created_at']['width']%>",
        "search": <%if $list_config['created_at']['search'] eq 'No' %>false<%else%>true<%/if%>,
        "export": <%if $list_config['created_at']['export'] eq 'No' %>false<%else%>true<%/if%>,
        "sortable": <%if $list_config['created_at']['sortable'] eq 'No' %>false<%else%>true<%/if%>,
        "hidden": <%if $list_config['created_at']['hidden'] eq 'Yes' %>true<%else%>false<%/if%>,
        "hideme": <%if $list_config['created_at']['hideme'] eq 'Yes' %>true<%else%>false<%/if%>,
        "addable": <%if $list_config['created_at']['addable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "editable": <%if $list_config['created_at']['editable'] eq 'Yes' %>true<%else%>false<%/if%>,
        "align": "left",
        "edittype": "text",
        "editrules": {
            "infoArr": []
        },
        "searchoptions": {
            "attr": {
                "aria-grid-id": el_tpl_settings.main_grid_id,
                "aria-module-name": "space_management",
                "aria-unique-name": "created_at",
                "autocomplete": "off",
                "class": "search-inline-date",
                "aria-date-format": "YYYY-MM-DD"
            },
            "sopt": dateSearchOpts,
            "searchhidden": <%if $list_config['created_at']['search'] eq 'Yes' %>true<%else%>false<%/if%>,
            "dataInit": initSearchGridDateRangePicker
        },
        "editoptions": {
            "aria-grid-id": el_tpl_settings.main_grid_id,
            "aria-module-name": "space_management",
            "aria-unique-name": "created_at",
            "aria-date-format": "yy-mm-dd",
            "aria-min": "",
            "aria-max": "",
            "placeholder": "",
            "class": "inline-edit-row inline-date-edit date-picker-icon dateOnly"
        },
        "ctrl_type": "date",
        "default_value": "<%$list_config['created_at']['default']%>",
        "filterSopt": "bt"
    },];
         
    initMainGridListing();
    createTooltipHeading();
    callSwitchToParent();
<%/javascript%>
<%$this->js->add_js("admin/custom/feedbackManagement.js")%>
<%if $this->input->is_ajax_request()%>
    <%$this->js->js_src()%>
<%/if%> 
<%if $this->input->is_ajax_request()%>
    <%$this->css->css_src()%>
<%/if%> 