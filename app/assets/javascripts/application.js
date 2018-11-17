//= require jquery2
//= require vendor/jquery.dotdotdot.min

$(function(){
  "use strict";

  const util = {
    icon: (doc, name, styles) => {
      const icon = doc.createElement('i');
      icon.setAttribute('class', 'material-icons');
      icon.innerText = name;
      for (let key in styles) icon.style[key] = styles[key];
      icon.style.cursor = 'pointer';
      return icon;
    },
  }

  class CustomFullscreen {
    constructor(doc) {
      this.className = 'custom-fullscreen';
      this.target = doc.querySelector('div.box>.embed-responsive');
      this.button = this._createButton(doc);
    }
    toggle() {
      if (this.target.classList.contains(this.className)) {
        this._toDefault();
      } else {
        this._toFullscreen();
      }
    }
    _toDefault() {
      this.target.classList.remove(this.className);
      this.target.style = {};
    }
    _toFullscreen() {
      this.target.classList.add(this.className);
      this.target.style.position = 'fixed';
      this.target.style.top = '0';
      this.target.style.left = '0';
      this.target.style.width = '100%';
      this.target.style.zIndex = '2000';
    }
    _createButton(doc) {
      const button = doc.createElement('span');
      button.addEventListener('mouseenter', () => button.style.opacity = 1);
      button.addEventListener('mouseleave', () => button.style.opacity = 0);
      button.className = this.className;
      button.style.position = 'fixed';
      button.style.zIndex = '2001';
      button.style.right = '0';
      button.style.bottom = '0';
      button.style.backgroundColor = 'transparent';
      button.style.border = 'none';
      const icon = util.icon(doc, 'fullscreen', {color: 'white', fontSize: '4em'});
      button.addEventListener('click', () => this.toggle());
      button.appendChild(icon);
      return button;
    }
  }

  class CustomVideoControl {
    constructor(doc, selector) {
      this.selector = selector ? selector : 'video';
      this.vide = doc.querySelector(this.selector);
      const container = this._createContainer(doc);
      container.appendChild(this._createRewindButton(doc));
      container.appendChild(this._createForwardButton(doc));
      this.container = container;
    }
    forward(sec) { this.moveBy(sec); }
    rewind(sec) { this.moveBy(-sec); }
    moveBy(sec) { this.vide.currentTime += sec; }
    _createContainer(doc) {
      const container = doc.createElement('div');
      container.addEventListener('mouseenter', () => container.style.opacity = 1);
      container.addEventListener('mouseleave', () => container.style.opacity = 0);
      container.style.opacity = 0;
      container.style.transition = 'all 0.1s';
      container.style.position = 'absolute';
      container.style.display = 'flex';
      container.style.top = 0;
      container.style.right = 0;
      container.style.backgroundColor = 'rgba(0, 0, 0, 0.4)';
      return container;
    }
    _createRewindButton(doc) {
      const rewind = doc.createElement('div');
      rewind.appendChild(util.icon(doc, 'replay_10', {color:'white',fontSize:'4em'}));
      rewind.addEventListener('click', () => this.rewind(10));
      return rewind;
    }
    _createForwardButton(doc) {
      const forward = doc.createElement('div');
      forward.appendChild(util.icon(doc, 'forward_30', {color:'white',fontSize:'4em'}));
      forward.addEventListener('click', () => this.forward(30));
      return forward;
    }
  }
  // }}}

  $('.navbar-search-icon, .overlay-search').on('click', function(){
    $('.navbar-search-form').toggle();
    $('.overlay-search').toggle();
    if ($('.navbar-search-form').is(':visible')) {
      $('#q').focus();
    }
  });

  $(document).on('keyup',function(evt) {
    if (evt.keyCode == 27 && $('.overlay-search').is(':visible')) {
      $('.navbar-search-form').toggle();
      $('.overlay-search').toggle();
    }
  });

  $(document).ready(function(){
    $('.video-title, .video-description').dotdotdot({
      wrap: 'letter',
    });

    const fullscreen = new CustomFullscreen(window.document);
    document.body.appendChild(fullscreen.button);
    const control = new CustomVideoControl(window.document);
    document.querySelector('div.box>div.embed-responsive').appendChild(control.container);
  });
});
