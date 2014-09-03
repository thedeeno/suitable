$(document).ready(function() {
  $('form input[name="subreddit"]').focus();
});

var CharmView = Backbone.View.extend({

  el: $("#charm-form"),

  events: {
    "submit": "submit"
  },

  initialize: function() {
  },

  submit: function(e) {
    $.ajax({
      url: "/charm",
      type: "POST",
      accepts: "application/json",
      data: this.$el.serialize(),
      success: function(data) {
        console.log(data);
      }
    });

    return false; // don't actually submit of the form.
  },
});

view = new CharmView();
