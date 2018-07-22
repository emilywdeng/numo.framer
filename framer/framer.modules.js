require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"YouTubePlayer":[function(require,module,exports){
var firstScriptTag, tag, youTubeReady,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

youTubeReady = new Promise(function(resolve, reject) {
  return window.onYouTubeIframeAPIReady = function() {
    return resolve();
  };
});

tag = document.createElement('script');

tag.src = 'https://www.youtube.com/iframe_api';

firstScriptTag = document.getElementsByTagName('script')[0];

firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

exports.YouTubePlayer = (function(superClass) {
  extend(YouTubePlayer, superClass);

  YouTubePlayer.Events = {
    Loaded: 'yt-loaded',
    Ready: 'yt-ready',
    StateChange: 'yt-stateChange',
    PlaybackQualityChange: 'yt-playbackQualityChange',
    PlaybackRateChange: 'yt-playbackRateChange',
    Error: 'yt-error',
    ApiChange: 'yt-apiChange'
  };

  function YouTubePlayer(options) {
    var div;
    if (options == null) {
      options = {};
    }
    div = document.createElement('div');
    this._playerReady = new Promise((function(_this) {
      return function(playerResolve, playerReject) {
        return youTubeReady.then(function() {
          _this._player = new YT.Player(div, {
            width: _this.width,
            height: _this.height,
            playerVars: options.playerVars,
            events: {
              'onReady': function(event) {
                playerResolve(event.target);
                return _this.emit(YouTubePlayer.Events.Ready, event);
              },
              'onStateChange': function(event) {
                return _this.emit(YouTubePlayer.Events.StateChange, event);
              },
              'onPlaybackQualityChange': function(event) {
                return _this.emit(YouTubePlayer.Events.PlaybackQualityChange, event);
              },
              'onPlaybackRateChange': function(event) {
                return _this.emit(YouTubePlayer.Events.PlaybackRateChange, event);
              },
              'onError': function(event) {
                playerReject(event.data);
                return _this.emit(YouTubePlayer.Events.Error, event);
              },
              'onApiChange': function(event) {
                return _this.emit(YouTubePlayer.Events.ApiChange, event);
              }
            }
          });
          _this.on("change:width", function() {
            return this._player.width = this.width;
          });
          return _this.on("change:height", function() {
            return this._player.height = this.height;
          });
        });
      };
    })(this));
    YouTubePlayer.__super__.constructor.call(this, options);
    this._element.appendChild(div);
  }

  YouTubePlayer.define("video", {
    get: function() {
      return this._video;
    },
    set: function(video) {
      this._video = video;
      return this._playerReady.then((function(_this) {
        return function() {
          var ref;
          _this._player.cueVideoById(video);
          if ((ref = _this.playerVars) != null ? ref.autoplay : void 0) {
            _this._player.playVideo();
          }
          return _this.emit(YouTubePlayer.Events.Loaded, _this._player);
        };
      })(this));
    }
  });

  YouTubePlayer.define("playerVars", {
    get: function() {
      return this._playerVars;
    },
    set: function(value) {
      return this._playerVars = value;
    }
  });

  return YouTubePlayer;

})(Layer);


},{}],"findModule":[function(require,module,exports){
var _findAll, _getHierarchy, _match;

_getHierarchy = function(layer) {
  var a, i, len, ref, string;
  string = '';
  ref = layer.ancestors();
  for (i = 0, len = ref.length; i < len; i++) {
    a = ref[i];
    string = a.name + '>' + string;
  }
  return string = string + layer.name;
};

_match = function(hierarchy, string) {
  var regExp, regexString;
  string = string.replace(/\s*>\s*/g, '>');
  string = string.split('*').join('[^>]*');
  string = string.split(' ').join('(?:.*)>');
  string = string.split(',').join('$|');
  regexString = "(^|>)" + string + "$";
  regExp = new RegExp(regexString);
  return hierarchy.match(regExp);
};

_findAll = function(selector, fromLayer) {
  var layers, stringNeedsRegex;
  layers = Framer.CurrentContext._layers;
  if (selector != null) {
    stringNeedsRegex = _.find(['*', ' ', '>', ','], function(c) {
      return _.includes(selector, c);
    });
    if (!(stringNeedsRegex || fromLayer)) {
      return layers = _.filter(layers, function(layer) {
        if (layer.name === selector) {
          return true;
        }
      });
    } else {
      return layers = _.filter(layers, function(layer) {
        var hierarchy;
        hierarchy = _getHierarchy(layer);
        if (fromLayer != null) {
          return _match(hierarchy, fromLayer.name + ' ' + selector);
        } else {
          return _match(hierarchy, selector);
        }
      });
    }
  } else {
    return layers;
  }
};

exports.Find = function(selector, fromLayer) {
  return _findAll(selector, fromLayer)[0];
};

exports.ƒ = function(selector, fromLayer) {
  return _findAll(selector, fromLayer)[0];
};

exports.FindAll = function(selector, fromLayer) {
  return _findAll(selector, fromLayer);
};

exports.ƒƒ = function(selector, fromLayer) {
  return _findAll(selector, fromLayer);
};

Layer.prototype.find = function(selector, fromLayer) {
  return _findAll(selector, this)[0];
};

Layer.prototype.ƒ = function(selector, fromLayer) {
  return _findAll(selector, this)[0];
};

Layer.prototype.findAll = function(selector, fromLayer) {
  return _findAll(selector, this);
};

Layer.prototype.ƒƒ = function(selector, fromLayer) {
  return _findAll(selector, this);
};


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL0Rlc2t0b3AvY2Fwc3RvbmUtbnVtby9udW1vLmZyYW1lci9tb2R1bGVzL215TW9kdWxlLmNvZmZlZSIsIi4uLy4uLy4uLy4uLy4uL0Rlc2t0b3AvY2Fwc3RvbmUtbnVtby9udW1vLmZyYW1lci9tb2R1bGVzL2ZpbmRNb2R1bGUuY29mZmVlIiwiLi4vLi4vLi4vLi4vLi4vRGVza3RvcC9jYXBzdG9uZS1udW1vL251bW8uZnJhbWVyL21vZHVsZXMvWW91VHViZVBsYXllci5jb2ZmZWUiLCJub2RlX21vZHVsZXMvYnJvd3Nlci1wYWNrL19wcmVsdWRlLmpzIl0sInNvdXJjZXNDb250ZW50IjpbIiMgQWRkIHRoZSBmb2xsb3dpbmcgbGluZSB0byB5b3VyIHByb2plY3QgaW4gRnJhbWVyIFN0dWRpby4gXG4jIG15TW9kdWxlID0gcmVxdWlyZSBcIm15TW9kdWxlXCJcbiMgUmVmZXJlbmNlIHRoZSBjb250ZW50cyBieSBuYW1lLCBsaWtlIG15TW9kdWxlLm15RnVuY3Rpb24oKSBvciBteU1vZHVsZS5teVZhclxuXG5leHBvcnRzLm15VmFyID0gXCJteVZhcmlhYmxlXCJcblxuZXhwb3J0cy5teUZ1bmN0aW9uID0gLT5cblx0cHJpbnQgXCJteUZ1bmN0aW9uIGlzIHJ1bm5pbmdcIlxuXG5leHBvcnRzLm15QXJyYXkgPSBbMSwgMiwgM10iLCJfZ2V0SGllcmFyY2h5ID0gKGxheWVyKSAtPlxuICBzdHJpbmcgPSAnJ1xuICBmb3IgYSBpbiBsYXllci5hbmNlc3RvcnMoKVxuICAgIHN0cmluZyA9IGEubmFtZSsnPicrc3RyaW5nXG4gIHJldHVybiBzdHJpbmcgPSBzdHJpbmcrbGF5ZXIubmFtZVxuXG5fbWF0Y2ggPSAoaGllcmFyY2h5LCBzdHJpbmcpIC0+XG4gICMgcHJlcGFyZSByZWdleCB0b2tlbnNcbiAgc3RyaW5nID0gc3RyaW5nLnJlcGxhY2UoL1xccyo+XFxzKi9nLCc+JykgIyBjbGVhbiB1cCBzcGFjZXMgYXJvdW5kIGFycm93c1xuICBzdHJpbmcgPSBzdHJpbmcuc3BsaXQoJyonKS5qb2luKCdbXj5dKicpICMgYXN0ZXJpa3MgYXMgbGF5ZXIgbmFtZSB3aWxkY2FyZFxuICBzdHJpbmcgPSBzdHJpbmcuc3BsaXQoJyAnKS5qb2luKCcoPzouKik+JykgIyBzcGFjZSBhcyBzdHJ1Y3R1cmUgd2lsZGNhcmRcbiAgc3RyaW5nID0gc3RyaW5nLnNwbGl0KCcsJykuam9pbignJHwnKSAjIGFsbG93IG11bHRpcGxlIHNlYXJjaGVzIHVzaW5nIGNvbW1hXG4gIHJlZ2V4U3RyaW5nID0gXCIoXnw+KVwiK3N0cmluZytcIiRcIiAjIGFsd2F5cyBib3R0b20gbGF5ZXIsIG1heWJlIHBhcnQgb2YgaGllcmFyY2h5XG5cbiAgcmVnRXhwID0gbmV3IFJlZ0V4cChyZWdleFN0cmluZykgXG4gIHJldHVybiBoaWVyYXJjaHkubWF0Y2gocmVnRXhwKVxuXG5fZmluZEFsbCA9IChzZWxlY3RvciwgZnJvbUxheWVyKSAtPlxuICBsYXllcnMgPSBGcmFtZXIuQ3VycmVudENvbnRleHQuX2xheWVyc1xuXG4gIGlmIHNlbGVjdG9yP1xuICAgIHN0cmluZ05lZWRzUmVnZXggPSBfLmZpbmQgWycqJywnICcsJz4nLCcsJ10sIChjKSAtPiBfLmluY2x1ZGVzIHNlbGVjdG9yLGNcbiAgICB1bmxlc3Mgc3RyaW5nTmVlZHNSZWdleCBvciBmcm9tTGF5ZXJcbiAgICAgIGxheWVycyA9IF8uZmlsdGVyIGxheWVycywgKGxheWVyKSAtPiBcbiAgICAgICAgaWYgbGF5ZXIubmFtZSBpcyBzZWxlY3RvciB0aGVuIHRydWVcbiAgICBlbHNlXG4gICAgICBsYXllcnMgPSBfLmZpbHRlciBsYXllcnMsIChsYXllcikgLT5cbiAgICAgICAgICBoaWVyYXJjaHkgPSBfZ2V0SGllcmFyY2h5KGxheWVyKVxuICAgICAgICAgIGlmIGZyb21MYXllcj9cbiAgICAgICAgICAgIF9tYXRjaChoaWVyYXJjaHksIGZyb21MYXllci5uYW1lKycgJytzZWxlY3RvcilcbiAgICAgICAgICBlbHNlXG4gICAgICAgICAgICBfbWF0Y2goaGllcmFyY2h5LCBzZWxlY3RvcilcbiAgZWxzZVxuICAgIGxheWVyc1xuXG5cbiMgR2xvYmFsXG5leHBvcnRzLkZpbmQgICAgPSAoc2VsZWN0b3IsIGZyb21MYXllcikgLT4gX2ZpbmRBbGwoc2VsZWN0b3IsIGZyb21MYXllcilbMF1cbmV4cG9ydHMuxpIgICAgICAgPSAoc2VsZWN0b3IsIGZyb21MYXllcikgLT4gX2ZpbmRBbGwoc2VsZWN0b3IsIGZyb21MYXllcilbMF1cblxuZXhwb3J0cy5GaW5kQWxsID0gKHNlbGVjdG9yLCBmcm9tTGF5ZXIpIC0+IF9maW5kQWxsKHNlbGVjdG9yLCBmcm9tTGF5ZXIpXG5leHBvcnRzLsaSxpIgICAgICA9IChzZWxlY3RvciwgZnJvbUxheWVyKSAtPiBfZmluZEFsbChzZWxlY3RvciwgZnJvbUxheWVyKVxuXG4jIE1ldGhvZHNcbkxheWVyOjpmaW5kICAgICA9IChzZWxlY3RvciwgZnJvbUxheWVyKSAtPiBfZmluZEFsbChzZWxlY3RvciwgQClbMF1cbkxheWVyOjrGkiAgICAgICAgPSAoc2VsZWN0b3IsIGZyb21MYXllcikgLT4gX2ZpbmRBbGwoc2VsZWN0b3IsIEApWzBdXG5cbkxheWVyOjpmaW5kQWxsICA9IChzZWxlY3RvciwgZnJvbUxheWVyKSAtPiBfZmluZEFsbChzZWxlY3RvciwgQClcbkxheWVyOjrGksaSICAgICAgID0gKHNlbGVjdG9yLCBmcm9tTGF5ZXIpIC0+IF9maW5kQWxsKHNlbGVjdG9yLCBAKSIsIiMgZG9jdW1lbnRhdGlvbjogaHR0cHM6Ly9kZXZlbG9wZXJzLmdvb2dsZS5jb20veW91dHViZS9pZnJhbWVfYXBpX3JlZmVyZW5jZVxuXG4jIHdpbGwgcmVzb2x2ZSB3aGVuIHdpbmRvdy5vbllvdVR1YmVJZnJhbWVBUElSZWFkeSBpcyBjYWxsZWRcbnlvdVR1YmVSZWFkeSA9IG5ldyBQcm9taXNlIChyZXNvbHZlLCByZWplY3QpIC0+XG4gICAgd2luZG93Lm9uWW91VHViZUlmcmFtZUFQSVJlYWR5ID0gLT4gcmVzb2x2ZSgpXG5cbiMgc3RhbmRhcmQgeW91dHViZSBpZnJhbWUgYXBpIGluaXRpYWxpemF0aW9uXG50YWcgPSBkb2N1bWVudC5jcmVhdGVFbGVtZW50ICdzY3JpcHQnXG50YWcuc3JjID0gJ2h0dHBzOi8vd3d3LnlvdXR1YmUuY29tL2lmcmFtZV9hcGknXG4jIFRPRE86IHNjcmlwdCBhc3luYyBkZWZlcj9cbmZpcnN0U2NyaXB0VGFnID0gZG9jdW1lbnQuZ2V0RWxlbWVudHNCeVRhZ05hbWUoJ3NjcmlwdCcpWzBdXG5maXJzdFNjcmlwdFRhZy5wYXJlbnROb2RlLmluc2VydEJlZm9yZSB0YWcsIGZpcnN0U2NyaXB0VGFnXG5cbmNsYXNzIGV4cG9ydHMuWW91VHViZVBsYXllciBleHRlbmRzIExheWVyXG5cbiAgICAjIGV2ZW50cywgc2VlIGh0dHBzOi8vZGV2ZWxvcGVycy5nb29nbGUuY29tL3lvdXR1YmUvaWZyYW1lX2FwaV9yZWZlcmVuY2UjRXZlbnRzXG4gICAgQEV2ZW50czpcbiAgICAgICAgTG9hZGVkOiAneXQtbG9hZGVkJyAjIG9jY3VycyB3aGVuIHZpZGVvIGlzIHF1ZXVlZCBhbmQgcmVhZHkgdG8gcGxheS4gd2lsbCBwcm92aWRlIHRoZSBwbGF5ZXIgYXMgcGFyYW1ldGVyLlxuICAgICAgICBSZWFkeTogJ3l0LXJlYWR5J1xuICAgICAgICBTdGF0ZUNoYW5nZTogJ3l0LXN0YXRlQ2hhbmdlJ1xuICAgICAgICBQbGF5YmFja1F1YWxpdHlDaGFuZ2U6ICd5dC1wbGF5YmFja1F1YWxpdHlDaGFuZ2UnXG4gICAgICAgIFBsYXliYWNrUmF0ZUNoYW5nZTogJ3l0LXBsYXliYWNrUmF0ZUNoYW5nZSdcbiAgICAgICAgRXJyb3I6ICd5dC1lcnJvcidcbiAgICAgICAgQXBpQ2hhbmdlOiAneXQtYXBpQ2hhbmdlJ1xuXG4gICAgIyBvcHRpb25zOiB7IHZpZGVvLCBwbGF5ZXJWYXJzIH1cbiAgICAjIGZvciBwbGF5ZXJWYXJzLCBzZWUgaHR0cHM6Ly9kZXZlbG9wZXJzLmdvb2dsZS5jb20veW91dHViZS9wbGF5ZXJfcGFyYW1ldGVyc1xuICAgIGNvbnN0cnVjdG9yOiAob3B0aW9ucz17fSkgLT5cblxuICAgICAgICAjIHRoaXMgZGl2IHdpbGwgYmUgcmVwbGFjZWQgd2l0aCB5b3V0dWJlIGlmcmFtZVxuICAgICAgICBkaXYgPSBkb2N1bWVudC5jcmVhdGVFbGVtZW50ICdkaXYnXG5cbiAgICAgICAgQF9wbGF5ZXJSZWFkeSA9IG5ldyBQcm9taXNlIChwbGF5ZXJSZXNvbHZlLCBwbGF5ZXJSZWplY3QpID0+XG5cbiAgICAgICAgICAgIHlvdVR1YmVSZWFkeS50aGVuID0+XG5cbiAgICAgICAgICAgICAgICAjIHBsYXllciBpcyBvbmx5IGFjY2Vzc2libGUgb24gcmVhZHkgZXZlbnRcbiAgICAgICAgICAgICAgICBAX3BsYXllciA9IG5ldyBZVC5QbGF5ZXIoZGl2LFxuICAgICAgICAgICAgICAgICAgICB3aWR0aDogQHdpZHRoXG4gICAgICAgICAgICAgICAgICAgIGhlaWdodDogQGhlaWdodFxuICAgICAgICAgICAgICAgICAgICBwbGF5ZXJWYXJzOiBvcHRpb25zLnBsYXllclZhcnNcbiAgICAgICAgICAgICAgICAgICAgZXZlbnRzOlxuICAgICAgICAgICAgICAgICAgICAgICAgJ29uUmVhZHknOiAoZXZlbnQpID0+XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcGxheWVyUmVzb2x2ZSBldmVudC50YXJnZXRcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBAZW1pdCBZb3VUdWJlUGxheWVyLkV2ZW50cy5SZWFkeSwgZXZlbnRcbiAgICAgICAgICAgICAgICAgICAgICAgICdvblN0YXRlQ2hhbmdlJzogKGV2ZW50KSA9PiBAZW1pdCBZb3VUdWJlUGxheWVyLkV2ZW50cy5TdGF0ZUNoYW5nZSwgZXZlbnRcbiAgICAgICAgICAgICAgICAgICAgICAgICdvblBsYXliYWNrUXVhbGl0eUNoYW5nZSc6IChldmVudCkgPT4gQGVtaXQgWW91VHViZVBsYXllci5FdmVudHMuUGxheWJhY2tRdWFsaXR5Q2hhbmdlLCBldmVudFxuICAgICAgICAgICAgICAgICAgICAgICAgJ29uUGxheWJhY2tSYXRlQ2hhbmdlJzogKGV2ZW50KSA9PiBAZW1pdCBZb3VUdWJlUGxheWVyLkV2ZW50cy5QbGF5YmFja1JhdGVDaGFuZ2UsIGV2ZW50XG4gICAgICAgICAgICAgICAgICAgICAgICAnb25FcnJvcic6IChldmVudCkgPT5cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwbGF5ZXJSZWplY3QgZXZlbnQuZGF0YVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBlbWl0IFlvdVR1YmVQbGF5ZXIuRXZlbnRzLkVycm9yLCBldmVudFxuICAgICAgICAgICAgICAgICAgICAgICAgJ29uQXBpQ2hhbmdlJzogKGV2ZW50KSA9PiBAZW1pdCBZb3VUdWJlUGxheWVyLkV2ZW50cy5BcGlDaGFuZ2UsIGV2ZW50XG4gICAgICAgICAgICAgICAgKTtcblxuICAgICAgICAgICAgICAgICMgb24gc2l6ZSBjaGFuZ2Ugb2YgdGhlIGxheWVyLCByZXNpemUgdGhlIGlmcmFtZVxuICAgICAgICAgICAgICAgIEBvbiBcImNoYW5nZTp3aWR0aFwiLCAtPiBAX3BsYXllci53aWR0aCA9IEB3aWR0aFxuICAgICAgICAgICAgICAgIEBvbiBcImNoYW5nZTpoZWlnaHRcIiwgLT4gQF9wbGF5ZXIuaGVpZ2h0ID0gQGhlaWdodFxuXG4gICAgICAgICMgY2FsbGluZyBzdXBlciBjYXVzZXMgQGRlZmluZSBwcm9wZXJ0aWVzIGJlaW5nIGFzc2lnbmVkXG4gICAgICAgIHN1cGVyIG9wdGlvbnNcblxuICAgICAgICBAX2VsZW1lbnQuYXBwZW5kQ2hpbGQgZGl2XG5cbiAgICBAZGVmaW5lIFwidmlkZW9cIixcbiAgICAgICAgZ2V0OiAtPiBAX3ZpZGVvXG4gICAgICAgIHNldDogKHZpZGVvKSAtPlxuICAgICAgICAgICAgQF92aWRlbyA9IHZpZGVvXG4gICAgICAgICAgICBAX3BsYXllclJlYWR5LnRoZW4gPT5cbiAgICAgICAgICAgICAgICBAX3BsYXllci5jdWVWaWRlb0J5SWQgdmlkZW9cbiAgICAgICAgICAgICAgICBAX3BsYXllci5wbGF5VmlkZW8oKSBpZiBAcGxheWVyVmFycz8uYXV0b3BsYXlcbiAgICAgICAgICAgICAgICBAZW1pdCBZb3VUdWJlUGxheWVyLkV2ZW50cy5Mb2FkZWQsIEBfcGxheWVyXG5cbiAgICBAZGVmaW5lIFwicGxheWVyVmFyc1wiLFxuICAgICAgICBnZXQ6IC0+IEBfcGxheWVyVmFyc1xuICAgICAgICBzZXQ6ICh2YWx1ZSkgLT4gQF9wbGF5ZXJWYXJzID0gdmFsdWVcbiIsIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBR0FBO0FER0EsSUFBQSxpQ0FBQTtFQUFBOzs7QUFBQSxZQUFBLEdBQW1CLElBQUEsT0FBQSxDQUFRLFNBQUMsT0FBRCxFQUFVLE1BQVY7U0FDdkIsTUFBTSxDQUFDLHVCQUFQLEdBQWlDLFNBQUE7V0FBRyxPQUFBLENBQUE7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
