function encrypt() {
	encrypt_jquery();
//	encrypt_prototype();
}
function encrypt_jquery() {
	var rsa = new RSAKey();
	rsa.setPublic($('#public_modulus').val(), $('#public_exponent').val());
	var res = rsa.encrypt($('#password').val());
	if (res) {
        var encrypted = linebrk(hex2b64(res), 64);
//	alert("RES="+ res +"\nENC="+ encrypted);
        $("input[name='login[encrypted_pwd]']").val(encrypted);
        $("input[name='password']").val('');
        $("input[name='confirm_password']").val('');
        return true;
	} else {
		alert("FAILED ENCRYPT");
	}
	return false;
}
/*
function encrypt_prototype() {
//	var form = document.findElementById('login');	// This no longer works?!
	var rsa = new RSAKey();
//      alert($('public_modulus') +"\n"+ $('public_exponent') +"\n"+ $('upassword') +"\n"+ $('password') );
//      alert($('public_modulus').name +"\n"+ $('public_exponent').name +"\n"+ $('upassword').name +"\n"+ $('password').name );
	rsa.setPublic($('public_modulus').value, $('public_exponent').value);
	var res = rsa.encrypt($('upassword').value);
	if (res) {
//        $('password').val(hex2b64(res));
        encrypted = linebrk(hex2b64(res), 64);
        $('password').setAttribute('value', encrypted);
        $('upassword').value = '';
        return true;
	}
	return false;
}
*/	

