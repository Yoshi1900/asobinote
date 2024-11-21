// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 
import "./playground_validation";
import "./post_validation";
import "./user_validation";

window.$ = window.jQuery = require('jquery');


Rails.start()
Turbolinks.start()
ActiveStorage.start()

import Raty from "raty.js"
  window.raty = function(elem,opt) {
    var raty =  new Raty(elem,opt)
    raty.init();
    return raty;
  }  

  $(document).on('turbo:load', function () {
    $('.slider').slick({
        dots: true, // スライドの下にドットのナビゲーションを表示
        autoplay: true, // 自動再生
        autoplaySpeed: 4000 // 再生スピード
    });
});