// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import $ from "jquery"
window.$ = $
import _ from "underscore"
window._ = _
import "bootstrap"
import "./angular/modules/kake-bosan"
import "./angular/directives/ng_focus_first_input_if"
import "./angular/directives/ng_focus_on_change"
import "./angular/directives/ng_wait_cursor_on"
import "./angular/directives/suggest_on_unbalanced"
import "./angular/models/type"
import "./angular/models/item"
import "./angular/models/transaction"
import "./angular/models/transaction_history"
import "./angular/models/inventory_setting"
import "./angular/models/inventory"
import "./angular/controllers/application_controller"
import "./angular/controllers/entry_form_controller"
import "./angular/controllers/history_controller"
import "./angular/controllers/recent_transactions_controller"
import "./angular/controllers/account_select_controller"
import "./angular/filters/by_account"
import "./angular/filters/by_item_type"
import "./angular/filters/item_name"
import "./angular/filters/item_type"
import "./angular/services/error-handler"
import "../stylesheets/application"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
