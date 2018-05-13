function trim(str) {
  return str.replace(/^\s+|\s+$/g, '');
}


function isEmpty(str) {
  str = trim(str);
  return ((str == null) || (str.length == 0))
}


function isDigit(c) {
  return ((c >= "0") && (c <= "9"))
}


function isInteger(str) {  
  var i;
  for (i = 0; i < str.length; i++) {
	var c = str.charAt(i);
	if (!isDigit(c)) return false;
  }
  return true;
}


function initForm(oForm, element_name, init_txt) {
	frmElement = oForm.elements[element_name];
	frmElement.value = init_txt;
}



function clearFieldFirstTime(element) {
  if (element.counter==undefined) {
	element.counter = 1;
  }

  else {
	element.counter++;
  }

  if (element.counter == 1) {
	element.value = '';
  }
}



function showFormData(oForm) {
   var msg = "The data that you entered for the form : \n";
   
   for (i = 0; i < oForm.length, oForm.elements[i].getAttribute("type") !== 'button'; i++) {
	   msg += oForm.elements[i].tagName + " with 'name' attribute='" + oForm.elements[i].name + "' and data: ";
	   if(oForm.elements[i].value == null || oForm.elements[i].value == '') {
		msg += "NOT SET \n";
	   } else {
		   msg += oForm.elements[i].value + "\n";
	   }
   }

   alert(msg);
}




