(function(c){function y(b,a,f,d,e,g){b={target:b,onchange:f,onpropertyclick:d,original:a,propertyElement:e,valueElement:g};t(b,a,b.target);c(b.target).on("blur focus",".property, .value",function(){c(this).toggleClass("editing")});"undefined"!=typeof l.arrayLimit&&!isNaN(l.arrayLimit)&&0<parseInt(l.arrayLimit)&&c(b.target).find("div.item.array").each(function(){c(this).find("div.item.object:gt("+l.arrayLimit+")").remove()})}function n(b){return"[object Object]"==Object.prototype.toString.call(b)}
function m(b){return"[object Array]"==Object.prototype.toString.call(b)}function u(b,a,f){var d=2==arguments.length;if(-1<a.indexOf(".")){for(var c=b,g=0,h=a.split("."),k=h.length;g<k-1;g++)c=c[h[g]];d?delete c[h[k-1]]:c[h[k-1]]=f}else d?delete b[a]:b[a]=f;return b}function r(b){var a;try{a=JSON.parse(b)}catch(f){a=null,window.console&&console.error("JSON parse failed.")}return a}function p(b){var a;try{a=JSON.stringify(b)}catch(f){a="null",window.console&&console.error("JSON stringify failed.")}return a}
function v(b){if(0==b.children(".expander").length){var a=c("<span>",{"class":"expander"});a.bind("click",function(){c(this).parent().toggleClass("expanded")});b.prepend(a)}}function z(b,a){var f=c("<div>",{"class":"item appender"}),d=c("<button></button>",{"class":"property"});d.text("Add New Value");f.append(d);b.append(f);d.click(a);return f}function A(b,a){var f="responsekeyvalue_"+(new Date).getTime(),d="responseradio_"+(new Date).getTime();c(a).append(c("<div>",{id:d,"class":"itemradio"}));
c(a).find("#"+d).append(c("<input>",{type:"radio",name:"responsekeyvalue",id:f,value:c(a).attr("data-path")?c(a).attr("data-path")+"."+b:b,style:"margin-top: -2px;","class":"regular-radio"}));c(a).find("#"+d).append(c("<label>",{"for":f}).text(""))}function t(b,a,f,d){d=d||"";f.children(".item").remove();for(var e in a)if(a.hasOwnProperty(e)){if(l.viewOnly){var g=c("<div>",{"class":"item","data-path":d}),h=c(b.propertyElement||"<span>",{"class":"property"}),k=c(b.valueElement||"<span>",{"class":"value"});
(n(a[e])||m(a[e]))&&v(g);g.append(h).append(k);m(a[e])&&A(e,g)}else g=c("<div>",{"class":"item","data-path":d}),h=c(b.propertyElement||"<input>",{"class":"property"}),k=c(b.valueElement||"<input>",{"class":"value"}),g.append(h).append(k),(n(a[e])||m(a[e]))&&v(g);f.append(g);if(l.viewOnly){h.text(e).attr("title",e);var q=p(a[e]);n(a[e])?q="Object":m(a[e])&&(q="Array");k.text(q).attr("title",q);w(g,a[e])}else h.val(e).attr("title",e),q=p(a[e]),k.val(q).attr("title",q),w(g,a[e]),h.change(B(b)),k.change(C(b)),
h.click(D(b));(n(a[e])||m(a[e]))&&t(b,a[e],g,(d?d+".":"")+e)}!n(a)&&!m(a)||l.viewOnly||z(f,function(){if(m(a))a.push(null);else if(n(a)){for(var c=1,e="newKey";a.hasOwnProperty(e);)e="newKey"+c,c++;a[e]=null}t(b,a,f,d);b.onchange(r(p(b.original)))})}function x(b,a){c(b).parentsUntil(a.target).each(function(){var b=c(this).data("path"),b=(b?b+".":b)+c(this).children(".property").val(),d;a:{d=a.original;for(var b=b.split("."),e=0;e<b.length;)if(void 0==(d=d[b[e++]])){d=null;break a}}d=p(d);c(this).children(".value").val(d).attr("title",
d)})}function D(b){return function(){var a=c(this).parent().data("path"),f=c(this).attr("title"),a=a?a.split(".").concat([f]).join("']['"):f;b.onpropertyclick("['"+a+"']")}}function B(b){return function(){var a=c(this).parent().data("path"),f=r(c(this).next().val()),d=c(this).val(),e=c(this).attr("title");c(this).attr("title",d);u(b.original,(a?a+".":"")+e);d&&u(b.original,(a?a+".":"")+d,f);x(this,b);d||c(this).parent().remove();b.onchange(r(p(b.original)))}}function C(b){return function(){var a=
c(this).prev().val(),f=r(c(this).val()||"null"),d=c(this).parent(),e=d.data("path");u(b.original,(e?e+".":"")+a,f);!n(f)&&!m(f)||c.isEmptyObject(f)?d.find(".expander, .item").remove():(t(b,f,d,(e?e+".":"")+a),v(d));w(d,f);x(this,b);b.onchange(r(p(b.original)))}}function w(b,a){var c="null";n(a)?c="object":m(a)?c="array":"[object Boolean]"==Object.prototype.toString.call(a)?c="boolean":"[object String]"==Object.prototype.toString.call(a)?c="string":"[object Number]"==Object.prototype.toString.call(a)&&
(c="number");b.removeClass(E);b.addClass(c)}var l={};c.fn.jsonEditor=function(b,a){a=a||{};b=r(p(b));var f=function(){},d=a.change||f,e=a.propertyclick||f;l=c.extend({},l,a);return this.each(function(){y(c(this),b,d,e,a.propertyElement,a.valueElement)})};var E="object array boolean number string null"})(jQuery);