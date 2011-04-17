/* 
License:
You can use and/or modify HintValue as long as you leave this notice at the top.
HintValue project page: http://projects.functino.com/hintvalue/
*/
var HintValue = Class.create({
	initialize:function(element, options){
		if(!(this.element = $(element))) return;
		this.options = Object.extend(Object.clone(HintValue.OPTIONS), options || {});
		this.defaultValue = this.element.value;
		if(this.options.value != false)
		{
			this.defaultValue = this.options.value;
		}		

		if(this.element.readAttribute('type') == "password")
		{
			this.text = new Element('input', {"type": "text"})
				.addClassName(this.options.className);
			this.text.value = this.defaultValue;
			this.element.insert({before:this.text});
			if(!this.options.value)
			{
				this.element.value = ""
			}
			if(this.element.value == "")
			{
				this.element.hide();	
			}
			else
			{
				this.text.hide();
			}
			
			this.element.observe('blur', function(ev){
				if(ev.element().value == "")
				{
					this.element.hide();
					this.text.show();
				}	
			}.bind(this));
			
			this.text.observe('focus', function(ev){
				this.text.hide();
				this.element.show();
				this.element.focus();
			}.bind(this));
		}
		else
		{
			if(this.element.value == "")
			{
				this.element.value = this.defaultValue;
			}
			
			if(this.element.value == this.defaultValue)
			{
				this.element.addClassName(this.options.className)
			}
			
			this.element.observe('focus', function(ev){
				if(ev.element().value == this.defaultValue)
				{
					this.element.value = "";
					this.element.removeClassName(this.options.className)
				}	
			}.bind(this));
	
			this.element.observe('blur', function(ev){
				if(ev.element().value == "")
				{
					this.element.addClassName(this.options.className)
					this.element.value = this.defaultValue;
				}	
			}.bind(this));
		}
	}
});
HintValue.OPTIONS = {
	value: false,
	className: "empty"
}