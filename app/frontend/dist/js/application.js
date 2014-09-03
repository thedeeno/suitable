$(document).ready(function() {
  $('form input[name="subreddit"]').focus();
});

var CharmView = Backbone.View.extend({

  el: $("body"),

  events: {
    "submit form": "submit",
    "mouseup input[type='submit']": "blur"
  },

  initialize: function() {
    this.$form = $('form');
  },

  blur: function(e) {
    console.log(e);
    button = $(e.target);
    button.blur();
  },

  submit: function(e) {
    e.preventDefault();

    $.ajax({
      url: "/charm",
      type: "POST",
      accepts: "application/json",
      data: this.$form.serialize(),
      success: function(data) {
        $(".last-charm").html(JST["assets/templates/last_charm.html"](data));
      }
    });
  },
});

view = new CharmView();
