// Generated by CoffeeScript 1.3.3
(function() {

  (function($, window) {
    var CardContainer, defaults, document, pluginName;
    pluginName = 'cardcontainer';
    document = window.document;
    defaults = {
      property: 'value'
    };
    CardContainer = (function() {
      var previous;

      function CardContainer(containerElement, options) {
        this.containerElement = containerElement;
        this.options = $.extend({}, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.init();
      }

      CardContainer.prototype.init = function() {
        var _this = this;
        this.changeCard(0);
        return $(this.containerElement).on('click.card-container', "[card-change]", function(event) {
          switch ($(event.target).attr('card-change')) {
            case "next":
              return _this.next();
            case "previous":
              return _this.previous();
          }
        });
      };

      CardContainer.prototype.next = function() {
        return this.changeCard(this.currentIndex + 1);
      };

      previous = function() {
        return this.changeCard(this.currentIndex - 1);
      };

      CardContainer.prototype.changeCard = function(newIndex) {
        var _this = this;
        if (!($("[card-index=\"" + newIndex + "\"]", this.containerElement).size() > 0)) {
          return;
        }
        $('[card-index]', this.containerElement).each(function(index, element) {
          var i;
          i = $(element).attr('card-index');
          if (i === newIndex + '') {
            return $(element).show();
          } else {
            return $(element).hide();
          }
        });
        if ($("[card-index=\"" + (newIndex + 1) + "\"]", this.containerElement).size() > 0) {
          $("[card-change=\"next\"]", this.containerElement).each(function(index, element) {
            return $(element).removeClass('disabled');
          });
        } else {
          $("[card-change=\"next\"]", this.containerElement).each(function(index, element) {
            return $(element).addClass('disabled');
          });
        }
        if ($("[card-index=\"" + (newIndex - 1) + "\"]", this.containerElement).size() > 0) {
          $("[card-change=\"previous\"]", this.containerElement).each(function(index, element) {
            return $(element).removeClass('disabled');
          });
        } else {
          $("[card-change=\"previous\"]", this.containerElement).each(function(index, element) {
            return $(element).addClass('disabled');
          });
        }
        return this.currentIndex = newIndex;
      };

      return CardContainer;

    })();
    return $.fn[pluginName] = function(options) {
      return this.each(function() {
        if (!$.data(this, "plugin_" + pluginName)) {
          $.data(this, "plugin_" + pluginName, new CardContainer(this, options));
        }
        if (typeof options === 'string') {
          return $.data(this, "plugin_" + pluginName)[options]();
        }
      });
    };
  })(jQuery, window);

  $(function() {
    $('.card-container').cardcontainer();
    return $('.card-container').cardcontainer('next');
  });

  /*
  $ ->
  	$('.card-container').each ->
  		new CardContainer($(this))
  */


}).call(this);
