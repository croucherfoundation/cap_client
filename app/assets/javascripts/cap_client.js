(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  jQuery(function($) {
    var ApplicationPicker;
    $.fn.application_picker = function() {
      this.each(function() {
        return new ApplicationPicker(this);
      });
      return this;
    };
    return ApplicationPicker = (function() {
      function ApplicationPicker(element) {
        this.appendOption = bind(this.appendOption, this);
        this.setOptions = bind(this.setOptions, this);
        this.receiveApplications = bind(this.receiveApplications, this);
        this.restrictToRound = bind(this.restrictToRound, this);
        this.receiveRounds = bind(this.receiveRounds, this);
        this.restrictToYear = bind(this.restrictToYear, this);
        var ref, ref1;
        this._container = $(element);
        this._cache = {};
        this._year_chooser = this._container.find('[data-role="year"]');
        this._round_chooser = this._container.find('[data-role="round"]');
        this._application_chooser = this._container.find('[data-role="application"]');
        this._rounds_url = (ref = this._container.attr('data-rounds-url')) != null ? ref : '/cap/rounds';
        this._applications_url = (ref1 = this._container.attr('data-applications-url')) != null ? ref1 : '/cap/applications';
        this._year_chooser.restricts(this._round_chooser);
        this._round_chooser.on("refresh", this.restrictToYear);
        this._round_chooser.restricts(this._application_chooser);
        this._application_chooser.on("refresh", this.restrictToRound);
        console.log("ApplicationPicker", this._application_chooser.get(0));
      }

      ApplicationPicker.prototype.restrictToYear = function(e, year) {
        var data, ref;
        console.log("restrictToYear", year);
        this._round_chooser.empty();
        if ((ref = this._rounds_request) != null) {
          ref.abort();
        }
        if (data = this._cache["year_" + year]) {
          return this.setOptions(data, this._round_chooser);
        } else {
          this._year = year;
          this._round_chooser.addClass('waiting');
          return this._rounds_request = $.getJSON(this._rounds_url + "/" + year, this.receiveRounds);
        }
      };

      ApplicationPicker.prototype.receiveRounds = function(data) {
        this._cache["year_" + this._year] = data;
        this._round_chooser.removeClass('waiting');
        return this.setOptions(data, this._round_chooser);
      };

      ApplicationPicker.prototype.restrictToRound = function(e, round_id) {
        var data, ref;
        this._application_chooser.empty();
        if ((ref = this._applications_request) != null) {
          ref.abort();
        }
        if (data = this._cache["round_" + round_id]) {
          return this.setOptions(data, this._application_chooser);
        } else {
          this._round_id = round_id;
          this._application_chooser.addClass('waiting');
          return this._applications_request = $.getJSON(this._applications_url + "/" + round_id, this.receiveApplications);
        }
      };

      ApplicationPicker.prototype.receiveApplications = function(data) {
        console.log("->", data);
        this._cache["round_" + this._round_id] = data;
        this._application_chooser.removeClass('waiting');
        return this.setOptions(data, this._application_chooser);
      };

      ApplicationPicker.prototype.setOptions = function(data, chooser) {
        var code, i, len, name, ref, results;
        this.appendOption("", "", chooser);
        results = [];
        for (i = 0, len = data.length; i < len; i++) {
          ref = data[i], name = ref[0], code = ref[1];
          results.push(this.appendOption(name, code, chooser));
        }
        return results;
      };

      ApplicationPicker.prototype.appendOption = function(name, code, chooser) {
        return chooser.append($("<option />").val(code).text(name));
      };

      return ApplicationPicker;

    })();
  });

}).call(this);