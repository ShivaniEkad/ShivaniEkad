<?php
defined('BASEPATH') || exit('No direct script access allowed');

/**
 * Description of Social Sign Up Controller
 *
 * @category webservice
 *
 * @package basic_appineers_master
 *
 * @subpackage controllers
 *
 * @module Social Sign Up
 *
 * @class Social_sign_up.php
 *
 * @path application\webservice\basic_appineers_master\controllers\Social_sign_up.php
 *
 * @version 4.4
 *
 */

class Social_sign_up extends Cit_Controller
{
    public $settings_params;

    /* @var array $output_params contains output parameters  */
    public $output_params;

    /* @var array $single_keys contains single array */
    public $single_keys;

    /* @var array $multiple_keys contains multiple array */
    public $multiple_keys;

    /* @var array $block_result contains query returns result array*/
    public $block_result;

    /**
     * To initialize class objects/variables.
     */
    public function __construct()
    {
        parent::__construct();
        $this->settings_params = array();
        $this->output_params = array();
        $this->single_keys = array(
            "create_user_social",
            "get_user_details_v1_v1",
        );
        $this->multiple_keys = array(
            "format_email_v2",
            "custom_function",
            "auth_token_generation",
        );
        $this->block_result = array();

        $this->load->library('wsresponse');
        $this->load->library('lib_log');
        $this->load->model('social_sign_up_model');
        $this->load->model("basic_appineers_master/users_model");
    }

    /**
     * This method is used to validate api input params.
     * 
     * @modified Suresh Nakate | 31.08.2021
     *
     * @param array $request_arr request input array.
     *
     * @return array $valid_res validation output response.
     */
    public function rules_social_sign_up($request_arr = array())
    {
        $valid_arr = array(
            "first_name" => array(
                array(
                    "rule" => "required",
                    "value" => true,
                    "message" => "first_name_required",
                ),
                array(
                    "rule" => "minlength",
                    "value" => FIRST_NAME_MIN_LENGTH,
                    "message" => "first_name_minlength",
                ),
                array(
                    "rule" => "maxlength",
                    "value" => FIRST_NAME_MAX_LENGTH,
                    "message" => "first_name_maxlength",
                ),

            ),
            "last_name" => array(
                array(
                    "rule" => "required",
                    "value" => true,
                    "message" => "last_name_required",
                ),
                array(
                    "rule" => "minlength",
                    "value" => LAST_NAME_MIN_LENGTH,
                    "message" => "last_name_minlength",
                ),
                array(
                    "rule" => "maxlength",
                    "value" => LAST_NAME_MAX_LENGTH,
                    "message" => "last_name_maxlength",
                )
            ),
            "user_name" => array(
                array(
                    "rule" => "regex",
                    "value" => "/^[0-9a-zA-Z]+$/",
                    "message" => "user_name_alpha_numeric_without_spaces",
                ),
                array(
                    "rule" => "minlength",
                    "value" => USER_NAME_MIN_LENGTH,
                    "message" => "user_name_minlength",
                ),
                array(
                    "rule" => "maxlength",
                    "value" => USER_NAME_MAX_LENGTH,
                    "message" => "user_name_maxlength",
                )
            ),
            "email" => array(
                array(
                    "rule" => "email",
                    "value" => true,
                    "message" => "email_email",
                )
            ),
            "mobile_number" => array(
                array(
                    "rule" => "number",
                    "value" => TRUE,
                    "message" => "mobile_number_number",
                ),
                array(
                    "rule" => "minlength",
                    "value" => MOBILE_NO_MIN_LENGTH,
                    "message" => "mobile_number_minlength",
                ),
                array(
                    "rule" => "maxlength",
                    "value" => MOBILE_NO_MAX_LENGTH,
                    "message" => "mobile_number_maxlength",
                )
            ),
            "dob" => array(
                array(
                    "rule" => "regex",
                    "value" => "/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/",
                    "message" => "dob_formate",
                )
            ),
             "zipcode" => array(
                array(
                    "rule" => "minlength",
                    "value" => ZIPCODE_MIN_LENGTH,
                    "message" => "zipcode_minlength",
                ),
                array(
                    "rule" => "maxlength",
                    "value" => ZIPCODE_MAX_LENGTH,
                    "message" => "zipcode_maxlength",
                )
            ),
            "device_type" => array(
                array(
                    "rule" => "required",
                    "value" => TRUE,
                    "message" => "device_type_required",
                )
            ),
            "device_model" => array(
                array(
                    "rule" => "required",
                    "value" => TRUE,
                    "message" => "device_model_required",
                )
            ),
            "device_os" => array(
                array(
                    "rule" => "required",
                    "value" => TRUE,
                    "message" => "device_os_required",
                )
            ),
            "social_login_type" => array(
                array(
                    "rule" => "required",
                    "value" => TRUE,
                    "message" => "social_login_type_required",
                )
            ),
            "social_login_id" => array(
                array(
                    "rule" => "required",
                    "value" => TRUE,
                    "message" => "social_login_id_required",
                )
            )
        );
        $valid_res = $this->wsresponse->validateInputParams($valid_arr, $request_arr, "social_sign_up");

        return $valid_res;
    }

    /**
     * This method is used to initiate api execution flow.
     * 
     * @modified Suresh Nakate | 31.08.2021
     *
     * @param array $request_arr  array is used for api input.
     * @param bool $inner_api inner_api flag is used to idetify whether it is inner api request or general request.
     *
     * @return array $output_response returns output response of API.
     */
    public function start_social_sign_up($request_arr = array(), $inner_api = FALSE)
    {

        try {
            $validation_res = $this->rules_social_sign_up($request_arr);
            if ($validation_res["success"] == "0") { //Validation Failed
                if ($inner_api === TRUE) {
                    return $validation_res;
                } else {
                    $this->wsresponse->sendValidationResponse($validation_res);
                }
            }
            $output_response = array();
            $input_params = $validation_res['input_params'];
            $output_array = $func_array = array();

            $input_params = $this->format_email_v2($input_params);
           
            $input_params = $this->check_unique_user($input_params);

            //input_params["check_unique_user"]["status"] = 1
          if ($input_params["check_unique_user"]["status"]) {
               
                $input_params = $this->auth_token_generation($input_params);

                $condition_auth=$this->check_authtoken($input_params);

                if($condition_auth["success"]==0)
                {
                    $exemessage = $condition_auth['message'];
                    throw new Exception($exemessage);
                }

                $input_params = $this->check_device_token_exists($input_params);

                //input_params["check_device_token_exists"]["status"] = 1
               if ($input_params["check_device_token_exists"]["status"]) {

                   $input_params = $this->remove_device_token($input_params);
               }
               
                $input_params = $this->create_user_social($input_params);
                
                if ($input_params["create_user_social"]["success"] == 1) {

                    $input_params = $this->get_user_details_v1_v1($input_params);

                    $input_params = $this->email_notification($input_params);

                    $output_response = $this->users_finish_success($input_params);

                    return $output_response;
                } else {

                    $output_response = $this->users_finish_success_1($input_params);

                    return $output_response;
                }
            } else {
               
                $output_response = $this->finish_success_1($input_params);

                return $output_response;
            }
        } catch (Exception $e) {
           
            $this->general->apiLogger($input_params, $e);
            $message = $e->getMessage();
            $output_response["success"] = 0;
            $output_response["message"] = $message;
        }
        
        return $output_response;
    }

    /**
     * This method is used to process custom function.
     *
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $input_params returns modfied input_params array.
     */
    public function format_email_v2($input_params = array())
    {
        if (!method_exists($this->general, "format_email")) {
            $result_arr["data"] = array();
        } else {
            $result_arr["data"] = $this->general->format_email($input_params);
        }
        $format_arr = $result_arr;

        $format_arr = $this->wsresponse->assignFunctionResponse($format_arr);
        $input_params["format_email_v2"] = $format_arr;

        $input_params = $this->wsresponse->assignSingleRecord($input_params, $format_arr);

        return $input_params;
    }

    /**
     * This method is used to process custom function.
     * 
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $input_params returns modified input_params array.
     */
    public function check_unique_user($input_params = array())
    {
        if (!method_exists($this, "checkUniqueUser")) {
            $result_arr["data"] = array();
        } else {
            $result_arr["data"] = $this->checkUniqueUser($input_params);
        }
        $format_arr = $result_arr;

        $format_arr = $this->wsresponse->assignFunctionResponse($format_arr);
        $input_params["check_unique_user"] = $format_arr;

        $input_params = $this->wsresponse->assignSingleRecord($input_params, $format_arr);

        return $input_params;
    }


     /**
     * This method is used to check unique user.
     * 
     * @created  Suresh Nakate | 31.08.2021 
     * @modified Suresh Nakate | 31.08.2021
     *
     * @param array $input_params  array to process loop flow.
     *
     * @return array $input_params returns modified input_params inside check_device_token_exists array.
     */
    public function check_device_token_exists($input_params = array())
    {

        if (!method_exists($this, "checkDeviceTokenExist")) {
            $result_arr["data"] = array();
        } else {
            $result_arr["data"] = $this->checkDeviceTokenExist($input_params);
        }
        $format_arr = $result_arr;

        $format_arr = $this->wsresponse->assignFunctionResponse($format_arr);
        $input_params["check_device_token_exists"] = $format_arr;

        $input_params = $this->wsresponse->assignSingleRecord($input_params, $format_arr);

        return $input_params;
    }


   
    /**
     * This method is used to remove other device token.
     * 
     * @created  Suresh Nakate | 31.08.2021 
     * @modified Suresh Nakate | 31.08.2021
     * 
     * @param array $input_params  array to process loop flow.
     * 
     * @return array $input_params returns modified input_params array.
     */
    public function remove_device_token($input_params = array())
    {

        $this->block_result = array();
        try {

            $params_arr = $where_arr = array();
            if (isset($input_params["device_token"])) {
                $where_arr["device_token"] = $input_params["device_token"];
            }
            if (isset($input_params["device_token"])) {
                $params_arr["device_token"] = $input_params["device_token"];
            }

            $this->block_result = $this->users_model->remove_device_token($params_arr, $where_arr);
        } catch (Exception $e) {
            $this->general->apiLogger($input_params, $e);
            $success = 0;
            $this->block_result["data"] = array();
        }
        $input_params["remove_device_token"] = $this->block_result["data"];
        $input_params = $this->wsresponse->assignSingleRecord($input_params, $this->block_result["data"]);

        return $input_params;
    }


    
    /**
     * This method is used to process conditions.
     *
     * @param array $input_params input_params array to process condition flow.
     * 
     * @return array $block_result returns result of condition block as array.
     */
    public function check_authtoken($input_params = array())
    {
      
        $this->block_result = array();
        try {

            $cc_lo_0 = count($input_params["auth_token_generation"]);
            $cc_ro_0 = 1;

            $cc_fr_0 = ($cc_lo_0 == $cc_ro_0) ? TRUE : FALSE;
            if (!$cc_fr_0) {
                throw new Exception('Failed to generate auth token.');
            }
            $success = 1;
            $message = "Auth token Generated";
        } catch (Exception $e) {
            $this->general->apiLogger($input_params, $e);
            $success = 0;
            $message = $e->getMessage();
        }
        $this->block_result["success"] = $success;
        $this->block_result["message"] = $message;

        return $this->block_result;
    }

    /**
     * This method is used to process custom function.
     * 
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $input_params returns modfied input_params array.
     */
    public function auth_token_generation($input_params = array())
    {
        if (!method_exists($this->general, "generateAuthToken")) {
            $result_arr["data"] = array();
        } else {
            $result_arr["data"] = $this->general->generateAuthToken($input_params);
        }
        $format_arr = $result_arr;

        $format_arr = $this->wsresponse->assignFunctionResponse($format_arr);
        $input_params["auth_token_generation"] = $format_arr;

        $input_params = $this->wsresponse->assignSingleRecord($input_params, $format_arr);

        return $input_params;
    }

    /**
     * This method is used to process query block.
     * 
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $input_params returns modfied input_params array.
     */
    public function create_user_social($input_params = array())
    {
        
      
        $this->block_result = array();
        try {

            $params_arr = array();
            $upload_arr = array();
            if (isset($_FILES["user_profile"]["name"]) && isset($_FILES["user_profile"]["tmp_name"])) {
                $sent_file = $_FILES["user_profile"]["name"];
            } else {
                $sent_file = "";
            }
            if (!empty($sent_file)) {
                list($file_name, $ext) = $this->general->get_file_attributes($sent_file);
                $images_arr["user_profile"]["ext"] = implode(',', $this->config->item('IMAGE_EXTENSION_ARR'));
                $images_arr["user_profile"]["size"] = "102400";
                if ($this->general->validateFileFormat($images_arr["user_profile"]["ext"], $_FILES["user_profile"]["name"])) {
                    if ($this->general->validateFileSize($images_arr["user_profile"]["size"], $_FILES["user_profile"]["size"])) {
                        $images_arr["user_profile"]["name"] = $file_name;
                    }
                }
            }
            if (!empty($input_params["first_name"])) {
                $params_arr["first_name"] = $input_params["first_name"];
            }
            if (!empty($input_params["last_name"])) {
                $params_arr["last_name"] = $input_params["last_name"];
            }
            if (!empty($input_params["user_name"])) {
                $params_arr["user_name"] = $input_params["user_name"];
            }
            if (!empty($input_params["email"])) {
                $params_arr["email"] = $input_params["email"];
            }
            if (!empty($input_params["mobile_number"])) {
                $params_arr["mobile_number"] = $input_params["mobile_number"];
            }
            if (!empty($images_arr["user_profile"]["name"])) {
                $params_arr["user_profile"] = $images_arr["user_profile"]["name"];
            }
            if (!empty($input_params["dob"])) {
                $params_arr["dob"] = $input_params["dob"];
            }
            if (!empty($input_params["address"])) {
                $params_arr["address"] = $input_params["address"];
            }
            if (!empty($input_params["city"])) {
                $params_arr["city"] = $input_params["city"];
            }
            if (!empty($input_params["latitude"])) {
                $params_arr["latitude"] = $input_params["latitude"];
            }
            if (!empty($input_params["longitude"])) {
                $params_arr["longitude"] = $input_params["longitude"];
            }
          
            if (!empty($input_params["state_name"])) {
                $params_arr["state_name"] = $input_params["state_name"];
            }
            if (!empty($input_params["zipcode"])) {
                $params_arr["zipcode"] = $input_params["zipcode"];
            }
            $params_arr["status"] = "Active";
            $params_arr["_dtaddedat"] = "NOW()";
            $params_arr["_dtupdatedat"] = "''";
            if (!empty($input_params["device_type"])) {
                $params_arr["device_type"] = $input_params["device_type"];
            }
            if (!empty($input_params["device_model"])) {
                $params_arr["device_model"] = $input_params["device_model"];
            }
            if (!empty($input_params["device_os"])) {
                $params_arr["device_os"] = $input_params["device_os"];
            }
            if (!empty($input_params["device_token"])) {
                $params_arr["device_token"] = $input_params["device_token"];
            }
            $params_arr["_vemailverificationcode"] = "''";
            if (!empty($input_params["auth_token"])) {
                $params_arr["auth_token"] = $input_params["auth_token"];
            }
            if (!empty($input_params["social_login_type"])) {
                $params_arr["social_login_type"] = $input_params["social_login_type"];
            }
            if (!empty($input_params["social_login_id"])) {
                $params_arr["social_login_id"] = $input_params["social_login_id"];
            }
            $params_arr["_eemailverified"] = "Yes";
            $params_arr["_vtermsconditionsversion"] = '{%REQUEST.terms_conditions_version%}';
            if (method_exists($this, "getTermsConditionVersion")) {

                // $params_arr["_vtermsconditionsversion"] = $this->getTermsConditionVersion($params_arr["_vtermsconditionsversion"], $input_params);
                $params_arr["_vtermsconditionsversion"] = $this->getTermsConditionVersion();
            }
            $params_arr["_vprivacypolicyversion"] = '{%REQUEST.privacy_policy_version%}';
            if (method_exists($this, "getPrivacyPolicyVersion")) {
                // $params_arr["_vprivacypolicyversion"] = $this->getPrivacyPolicyVersion($params_arr["_vprivacypolicyversion"], $input_params);
                $params_arr["_vprivacypolicyversion"] = $this->getPrivacyPolicyVersion();
            }
           
            $this->block_result = $this->users_model->create_user_social($params_arr);
            
            if (!$this->block_result["success"]) {
                throw new Exception("Insertion failed.");
            }
            $data_arr = $this->block_result["data"]['0'];
            $upload_path = $this->config->item("upload_path");
            if (!empty($images_arr["user_profile"]["name"])) {
                $aws_folder_name = $this->config->item("AWS_FOLDER_NAME");
                $folder_name = $aws_folder_name . "/user_profile/" . $data_arr['insert_id'];
                $temp_file = $_FILES["user_profile"]["tmp_name"];
                
                $res = $this->general->uploadAWSData($temp_file, $folder_name, $images_arr["user_profile"]["name"]);
                
                if (!$res) {
                    //file upload failed
                    throw new Exception("Failed to upload file.");
                }
                
                
            }
            $this->db->trans_commit();
        } catch (Exception $e) {
            $this->db->trans_rollback();
            $this->general->apiLogger($input_params, $e);
            $success = 0;
            $this->block_result["data"] = array();
        }
        $input_params["create_user_social"] = $this->block_result;
        $input_params = $this->wsresponse->assignSingleRecord($input_params, $this->block_result["data"]);

        return $input_params;
    }

   
    /**
     * This method is used to process query block.
     * 
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $input_params returns modfied input_params array.
     */
    public function get_user_details_v1_v1($input_params = array())
    {

        $this->block_result = array();
        try {

            $insert_id = isset($input_params["user_id"]) ? $input_params["user_id"] : "";
            $this->block_result = $this->users_model->get_user_details_v1_v1($insert_id);
            if (!$this->block_result["success"]) {
                throw new Exception("No records found.");
            }
            $result_arr = $this->block_result["data"];
            if (is_array($result_arr) && count($result_arr) > 0) {
                $i = 0;
                foreach ($result_arr as $data_key => $data_arr) {

                    $data = $data_arr["u_profile_image"];
                    $user_id = $data_arr["u_user_id"];
                    $image_arr = array();
                    $image_arr["image_name"] = $data;
                    $image_arr["ext"] = implode(",", $this->config->item("IMAGE_EXTENSION_ARR"));
                    $image_arr["color"] = "FFFFFF";
                    $image_arr["no_img"] = FALSE;
                    $aws_folder_name = $this->config->item("AWS_FOLDER_NAME");
                    $image_arr["path"] = $aws_folder_name . "/user_profile/" . $user_id;
                    //$data = $this->general->get_image_aws($image_arr);
                    $folder_name = $aws_folder_name."/user_profile/".$user_id;
                
                    $data11 = $this->general->getFileFromAWS('', $folder_name, $data);
 
                    $data = $data11['@metadata']['effectiveUri'];
                    $result_arr[$data_key]["u_profile_image"] = (false == empty($data)) ? $data : "";

                    $i++;
                }
                $this->block_result["data"] = $result_arr;
            }
        } catch (Exception $e) {
            $this->general->apiLogger($input_params, $e);
            $success = 0;
            $this->block_result["data"] = array();
        }
        $input_params["get_user_details_v1_v1"] = $this->block_result["data"];
        $input_params = $this->wsresponse->assignSingleRecord($input_params, $this->block_result["data"]);

        return $input_params;
    }

    /**
     * This method is used to process email notification.
     * 
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $input_params returns modfied input_params array.
     */
    public function email_notification($input_params = array())
    {

        $this->block_result = array();
        try {

            $email_arr["vEmail"] = $input_params["email"];

            $email_arr["vUserName"] = $input_params["email_user_name"];

            $success = $this->general->sendMail($email_arr, "WELCOME", $input_params);

            $log_arr = array();
            $log_arr['eEntityType'] = 'General';
            $log_arr['vReceiver'] = is_array($email_arr["vEmail"]) ? implode(",", $email_arr["vEmail"]) : $email_arr["vEmail"];
            $log_arr['eNotificationType'] = "EmailNotify";
            $log_arr['vSubject'] = $this->general->getEmailOutput("subject");
            $log_arr['tContent'] = $this->general->getEmailOutput("content");
            if (!$success) {
                $log_arr['tError'] = $this->general->getNotifyErrorOutput();
            }
            $log_arr['dtSendDateTime'] = date('Y-m-d H:i:s');
            $log_arr['eStatus'] = ($success) ? "Executed" : "Failed";
            $this->general->insertExecutedNotify($log_arr);
            if (!$success) {
                throw new Exception("Failure in sending mail.");
            }
            $success = 1;
            $message = "Email notification send successfully.";
        } catch (Exception $e) {
            $this->general->apiLogger($input_params, $e);
            $success = 0;
            $message = $e->getMessage();
        }
        $this->block_result["success"] = $success;
        $this->block_result["message"] = $message;
        $input_params["email_notification"] = $this->block_result["success"];

        return $input_params;
    }

    /**
     * This method is used to process finish flow.
     * 
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $responce_arr returns responce array of api.
     */
    public function users_finish_success($input_params = array())
    {

        $setting_fields = array(
            "success" => "1",
            "message" => "users_finish_success",
        );
        $output_fields = array(
            'u_first_name',
            'u_last_name',
            'u_user_name',
            'u_email',
            'u_mobile_no',
            'u_profile_image',
            'u_dob',
            'u_address',
            'u_city',
            'u_latitude',
            'u_longitude',
          
            'u_state_name',
            'u_zip_code',
            'u_status',
            'u_email_verified',
            'u_access_token',
            'u_device_type',
            'u_device_model',
            'u_device_os',
            'u_device_token',
            'u_added_at',
            'u_social_login_type',
            'u_social_login_id',
            //'ms_state',
            'e_one_time_transaction',
            't_one_time_transaction',
            'u_push_notify',
            'terms_conditions_version',
            'privacy_policy_version',
            'u_log_status_updated',
        );
        $output_keys = array(
            'get_user_details_v1_v1',
        );
        $ouput_aliases = array(
            "get_user_details_v1_v1" => "get_user_details",
            "u_first_name" => "first_name",
            "u_last_name" => "last_name",
            "u_user_name" => "user_name",
            "u_email" => "email",
            "u_mobile_no" => "mobile_no",
            "u_profile_image" => "profile_image",
            "u_dob" => "dob",
            "u_address" => "address",
            "u_city" => "city",
            "u_latitude" => "latitude",
            "u_longitude" => "longitude",
         
            "u_state_name" => "state_name",
            "u_zip_code" => "zip_code",
            "u_status" => "status",
            "u_email_verified" => "email_verified",
            "u_access_token" => "access_token",
            "u_device_type" => "device_type",
            "u_device_model" => "device_model",
            "u_device_os" => "device_os",
            "u_device_token" => "device_token",
            "u_added_at" => "added_at",
            "u_social_login_type" => "social_login_type",
            "u_social_login_id" => "social_login_id",
            //"ms_state" => "state",
            "e_one_time_transaction" => "purchase_status",
            "t_one_time_transaction" => "purchase_receipt_data",
            "u_push_notify" => "push_notify",
            "u_log_status_updated" => "log_status_updated",
        );

        $output_array["settings"] = $setting_fields;
        $output_array["settings"]["fields"] = $output_fields;
        $output_array["data"] = $input_params;

        $func_array["function"]["name"] = "social_sign_up";
        $func_array["function"]["output_keys"] = $output_keys;
        $func_array["function"]["output_alias"] = $ouput_aliases;
        $func_array["function"]["single_keys"] = $this->single_keys;
        $func_array["function"]["multiple_keys"] = $this->multiple_keys;

        $this->wsresponse->setResponseStatus(SET_RESPONSE_STATUS);

        $responce_arr = $this->wsresponse->outputResponse($output_array, $func_array);

        return $responce_arr;
    }

    /**
     * This method is used to process finish flow.
     * 
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $responce_arr returns responce array of api.
     */
    public function users_finish_success_1($input_params = array())
    {

        $setting_fields = array(
            "success" => "0",
            "message" => "users_finish_success_1",
        );
        $output_fields = array();

        $output_array["settings"] = $setting_fields;
        $output_array["settings"]["fields"] = $output_fields;
        $output_array["data"] = $input_params;

        $func_array["function"]["name"] = "social_sign_up";
        $func_array["function"]["single_keys"] = $this->single_keys;
        $func_array["function"]["multiple_keys"] = $this->multiple_keys;

        $this->wsresponse->setResponseStatus(SET_RESPONSE_STATUS);

        $responce_arr = $this->wsresponse->outputResponse($output_array, $func_array);

        return $responce_arr;
    }

    /**
     * This method is used to process finish flow.
     * 
     * @param array $input_params input_params array to process loop flow.
     * 
     * @return array $responce_arr returns responce array of api.
     */
    public function finish_success_1($input_params = array())
    {

        $setting_fields = array(
            "success" => "0",
            "message" => "finish_success_1",
        );
        $output_fields = array();

        $output_array["settings"] = $setting_fields;
        $output_array["settings"]["fields"] = $output_fields;
        $output_array["data"] = $input_params;

        $func_array["function"]["name"] = "social_sign_up";
        $func_array["function"]["single_keys"] = $this->single_keys;
        $func_array["function"]["multiple_keys"] = $this->multiple_keys;

        $this->wsresponse->setResponseStatus(SET_RESPONSE_STATUS);

        $responce_arr = $this->wsresponse->outputResponse($output_array, $func_array);

        return $responce_arr;
    }
}
