$(document).ready(function() {
  $('form input[name="subreddit"]').focus();
});

var CharmView = Backbone.View.extend({

  el: $("body"),

  events: {
    "submit form": "submit",
    "mouseup form .button": "blur"
  },

  initialize: function() {
    this.$form = $('form');
    this.$submit = $('form .submit');
    this.$button = $('form .button');
    this.$charm = $('.last-charm');
  },

  submit: function(e) {
    var self = this;

    e.preventDefault();

    this.startSpin();

    $.ajax({
      url: "/charm",
      type: "POST",
      accepts: "application/json",
      data: this.$form.serialize(),
      success: function(data) {
        self.stopSpin();
        self.renderCharm(data);
      },
      error: function(data) {
        self.stopSpin();
        self.renderError(data.responseJSON);
      }
    });
  },

  blur: function(e) {
    $(e.target).blur();
  },

  startSpin: function() {
    this.$button.hide();
    this.$charm.empty();
    this.$submit.append(JST["assets/templates/spinner.html"]());
  },

  stopSpin: function() {
    this.$submit.find(".spinner").remove();
    this.$button.show();
  },

  renderCharm: function(data) {
    this.$charm.html(JST["assets/templates/last_charm.html"](data));
  },

  renderError: function(data) {
    data = data || {};
    data.message = data.message || "Something went wrong. Does the subreddit exist?";
    this.$charm.html(JST["assets/templates/error.html"](data));
  }

});

view = new CharmView();
