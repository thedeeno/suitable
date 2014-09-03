$(document).ready(function() {
  $('form input[name="subreddit"]').focus();
});

var CharmView = Backbone.View.extend({

  el: $("body"),

  events: {
    "submit form": "submit"
  },

  initialize: function() {
    this.$form = $('form');
  },

  submit: function(e) {
    $.ajax({
      url: "/charm",
      type: "POST",
      accepts: "application/json",
      data: this.$form.serialize(),
      success: function(data) {
        $(".last-charm").html(JST["assets/templates/last_charm.html"](data));
      }
    });

    return false; // don't actually submit of the form.
  },
});

view = new CharmView();
