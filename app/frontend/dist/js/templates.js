this["JST"] = this["JST"] || {};

this["JST"]["assets/templates/error.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="small-12 column pinched bounceInDown error">\n  <h3 class="dispatch-failed">O Noes!</h3>\n  <p>' +
((__t = ( message )) == null ? '' : __t) +
'</p>\n</div>\n';

}
return __p
};

this["JST"]["assets/templates/last_charm.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="small-12 column pinched bounceInDown">\n  <h3 class="dispatch-success">Successfully Swooned.</h3>\n  <p>' +
((__t = ( message )) == null ? '' : __t) +
'</p>\n</div>\n';

}
return __p
};

this["JST"]["assets/templates/spinner.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="spinner">\n  <div class="rect1"></div>\n  <div class="rect2"></div>\n  <div class="rect3"></div>\n  <div class="rect4"></div>\n  <div class="rect5"></div>\n</div>\n';

}
return __p
};