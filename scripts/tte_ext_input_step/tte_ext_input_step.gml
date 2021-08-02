///
///@function tte_ext_input_step()
///@syntax tte_ext_input_step()
///
///@description This script should be called in the Step>Step
///							event of the object which is a text input.
///
function tte_ext_input_step(){
	__tte_ext_input_check_surface();
	__tte_ext_input_handle_mouse();
	__tte_ext_input_handle_keyboard();
	__tte_ext_input_handle_caret();
}